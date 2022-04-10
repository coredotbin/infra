pihole:
	ansible-playbook -b run.yaml --limit pihole

dev:
	ansible-playbook -b run.yaml --limit dev

encrypt:
	ansible-vault encrypt vars/vault.yaml

decrypt:
	ansible-vault decrypt vars/vault.yaml
