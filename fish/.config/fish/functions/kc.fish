function kc --description 'Switch between Kubernetes contexts'
	kubectl config use-context $argv[1]
end
