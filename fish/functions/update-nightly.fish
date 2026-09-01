function update-nightly
    set tmpdir (mktemp -d)
    set asset nvim-macos-(arch)

    set prefix $argv[1]
    if not set --query prefix[1]
        set prefix "/usr/local"
    end

    pushd $tmpdir

    gh -R neovim/neovim release download nightly -p $asset.tar.gz -p shasum.txt
	echo $tmpdir

    xattr -c $asset.tar.gz
    tar xzf $asset.tar.gz

    mv -f $asset/bin/* $prefix/bin/
    mv -f $asset/lib/* $prefix/lib/
    mv -f $asset/share/* $prefix/share/

    popd
end
