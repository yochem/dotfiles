function mergepr
    gh pr review --approve "$argv[1]" && gh pr merge --squash "$argv[1]"
end
