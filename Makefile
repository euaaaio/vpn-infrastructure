.PHONY: install vault-create vault-decrypt deploy backup lint lint-yml

install:
	python3 -m venv venv
	pip install --upgrade pip
	pip install -r requirements.txt
	ansible-galaxy install -r requirements.yml
	@echo "Installation complete!"

vault-encrypt:
	ansible-vault encrypt vars/secrets.yml

vault-decrypt:
	ansible-vault decrypt vars/secrets.yml

deploy:
	ansible-playbook site.yml -u root

backup:
	ansible-playbook site.yml -u root --tags backup

lint-yml:
	@yamllint --strict . && echo "Yaml linting ok"

lint: lint-yml
	ansible-lint --format pep8 --offline
