import argparse
from pathlib import Path
import os
import sys
from functools import partial
import typing
from typing import Iterable

repo_dirs = (
	"config",
	"data",
	"home",
	"bin",
)


err_print = partial(print, file=sys.stderr)


def ensure_path_from_env(env_var: str, exit_code: int = 2) -> Path:
    try:
        path = Path(os.environ[env_var])
    except KeyError:
        err_print(f"{env_var} not set!")
        sys.exit(exit_code)

    if not path.exists():
        err_print(f"{env_var} set but {path} does not exist!")
        sys.exit(exit_code)

    return path


def user_dir(repo_dir: str) -> Path:
	if repo_dir == "config":
		return ensure_path_from_env("XDG_CONFIG_HOME")
	elif repo_dir == "data":
		return ensure_path_from_env("XDG_DATA_HOME")
	elif repo_dir == "home":
		return ensure_path_from_env("HOME")
	elif repo_dir == "bin":
		return ensure_path_from_env("BIN")

	raise ValueError(f"repo_dir must be one of {repo_dirs}")


def prog_files(prog: Path, must_exist: bool = True) -> Iterable[Path]:
    paths: Iterable[Path]
    # 1: config, data, home, bin
    # 2: nvim, ...
    # 3: config/nvim
    if prog.name in repo_dirs:
        paths = prog.iterdir()
    elif len(prog.parts) == 1:
        paths = [repo_dir / prog for repo_dir in repo_dirs]
    elif prog.resolve().is_relative_to(Path(".").resolve()):
        paths = [prog]
    else:
        raise ValueError(f"{prog} is not a valid sub path")

    if must_exist:
        paths = [path for path in paths if path.exists()]

    return paths


def symlink_prog(prog: Path, dryrun: bool = False, force: bool = False) -> bool:
    target = user_dir(prog.resolve().parent.name) / prog.name

    dryrun_print = "DRYRUN: " if dryrun else ""
    force_print = "force " if force else ""

    if not force and target.exists():
        if target.is_symlink():
            err_print(f"{dryrun_print}skip {prog}: already synced")
        else:
            err_print(f"{dryrun_print}skip {prog}: {target} exists")

        return False

    print(f"{dryrun_print}{force_print}sync {prog} to {target}")

    if not dryrun:
        prog.symlink_to(target)

    return True


def sync(args: Iterable[str], dryrun: bool = False, force: bool = False) -> int:
    dirs_synced = 0

    if not args:
        args = repo_dirs

    for arg in args:
        path = Path(arg)
        prog_paths = prog_files(path, must_exist=True)
        for prog_path in prog_paths:
            is_synced = symlink_prog(prog_path, dryrun=dryrun, force=force)
            dirs_synced += is_synced

    return dirs_synced


def track(args: Iterable[str], dryrun: bool = False, force: bool = False) -> int:
    dirs_tracked = 0
    dryrun_print = "DRYRUN: " if dryrun else ""
    force_print = "force " if force else ""

    for arg in args:
        path = Path(arg)
        repo_paths = prog_files(path, must_exist=False)

        for repo_path in repo_paths:
            if not force and repo_path.exists():
                err_print(f"{dryrun_print}skip {repo_path}: {repo_path} exists")
                continue

            system_path = user_dir(repo_path.parent.name) / path.name

            if not system_path.exists():
                err_print(
                    f"{dryrun_print}skip {repo_path}: {system_path} does not exist"
                )
                continue

            print(f"{dryrun_print}{force_print}track {repo_path} from {system_path}")

            if not dryrun:
                # move program from system dir to repo dir first
                system_path.rename(repo_path)
                repo_path.symlink_to(system_path)
                dirs_tracked += 1

    return dirs_tracked


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="dot",
        description="Manage dotfiles.",
    )

    general_args = argparse.ArgumentParser(add_help=False)
    general_args.add_argument(
        "-f", "--force", action="store_true", help="force overwrite"
    )
    general_args.add_argument(
        "--dry-run",
        action="store_true",
        help="do not perform any copying or symlinking",
    )
    general_args.add_argument(
        "pathspec",
        nargs="*",
        help="relative path to directories in this repository",
    )

    subparsers = parser.add_subparsers(required=True)

    sync_parser = subparsers.add_parser("sync", parents=[general_args])
    sync_parser.set_defaults(func=sync)

    track_parser = subparsers.add_parser("track", parents=[general_args])
    track_parser.set_defaults(func=track)

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    num_actions = args.func(args.pathspec, dryrun=True, force=args.force)

    if num_actions > 0:
        sys.exit(0)
    else:
        sys.exit(1)
