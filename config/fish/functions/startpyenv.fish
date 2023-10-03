function startpyenv
	status is-login; and pyenv init --path --no-rehash | source
	status is-login; and pyenv virtualenv-init - | source
end
