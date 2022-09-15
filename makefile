all:
	ansible-playbook -b run.yaml
docker_hosts:
	ansible-playbook -b run.yaml --limit docker_hosts
hypervisor:
	ansible-playbook -b run.yaml --limit hypervisor
cb-lin-deb-use-01:
	ansible-playbook -b run.yaml --limit cb-lin-deb-use-01
pihole:
	ansible-playbook -b run.yaml --limit pihole
nextcloud:
	ansible-playbook -b run.yaml --limit nextcloud

lint:
	-yamllint .
	ansible-lint

reqs:
	ansible-galaxy install -r requirements.yaml
forcereqs:
	ansible-galaxy install -r requirements.yaml --force

encrypt:
	ansible-vault encrypt vars/vault.yaml
decrypt:
	ansible-vault decrypt vars/vault.yaml
