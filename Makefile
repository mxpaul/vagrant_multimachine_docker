vendor-galaxy:
	ansible-galaxy install -v -r requirements.yml
	ansible-galaxy collection install -v -r requirements.yml
