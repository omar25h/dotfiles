function navigate_to_git_root
  if test -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    echo z \(git root\)
  else
    echo z
  end
end

abbr --add zz --function navigate_to_git_root 

abbr --add n nvim

abbr --add gco git checkout
abbr --add gcob git checkout -b
abbr --add gsw git switch
abbr --add gswc git switch -c
abbr --add gpr git pull --rebase origin \(git main-branch\)
abbr --add gpull git pull
abbr --add gpushf git push --force-with-lease
abbr --add gpush git push
abbr --add gst git status
