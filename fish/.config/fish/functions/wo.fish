function wo --description 'Work on a project'
    set -l project ~/Developer/(fish -c 'cd ~/Developer; and find * -type d -depth 0 | fzf')

    if test $status -eq 0
        code $project
    end
end
