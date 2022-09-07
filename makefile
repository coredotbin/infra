hypervisor:
	ansible-playbook -b run.yaml --limit hypervisor
ks-lin-deb-use-01:
	ansible-playbook -b run.yaml --limit ks-lin-deb-use-01
pihole:
	ansible-playbook -b run.yaml --limit pihole
nextcloud:
	ansible-playbook -b run.yaml --limit nextcloud
db:
	ansible-playbook -b run.yaml --limit pgsql

dev:
	ansible-playbook -b run.yaml --limit dev

reqs:
	ansible-galaxy install -r requirements.yaml
forcereqs:
	ansible-galaxy install -r requirements.yaml --force

encrypt:
	ansible-vault encrypt vars/vault.yaml
decrypt:
	ansible-vault decrypt vars/vault.yaml
