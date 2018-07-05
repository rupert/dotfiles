function kc --description 'Switch between Kubernetes contexts'
    if count $argv >/dev/null
        kubectl config use-context $argv[1]
    else
        kubectl config current-context
    end
end
