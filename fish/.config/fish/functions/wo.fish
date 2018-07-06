function wo --description 'Work on a project'
    set command fzf

    if count $argv >/dev/null
        set command "$command --query $argv[1] --select-1"
    end

    set project ~/Developer/(fish -c "cd ~/Developer; and find * -type d -depth 0 | eval $command")

    if test $status -eq 0
        code $project
        return 0
    else
        return 1
    end
end
