function rm-merged-branches
    gh pr list --author @me --state merged --json headRefName --jq '.[].headRefName' | xargs -n 1 git branch -D 2>/dev/null
end
