# coredotbin/infra

[![Ansible Lint](https://github.com/coredotbin/infra/actions/workflows/ansible_lint.yaml/badge.svg)](https://github.com/coredotbin/infra/actions/workflows/ansible_lint.yaml)

Very basic Ansible to configure and deploy my home infrastructure, primarily based around Docker.

## Credits

* Alex Kretzschmar / ironicbadger - this is heavily based on [his infra repo](https://github.com/ironicbadger/infra) and utilizing his awesome [docker_compose_generator](https://github.com/IronicBadger/ansible-role-docker-compose-generator), dhcp, and bash_aliases Ansible roles.
* Amrts for his [docker-postgresql-multiple-databases](https://github.com/mrts/docker-postgresql-multiple-databases) script, which I have [forked](https://github.com/coredotbin/docker-postgresql-multiple-databases) for my own uses in this project.
* Nick Busey from HomelabOS for the [git pre-commit hook](https://gitlab.com/NickBusey/HomelabOS/-/issues/355) ensuring vars/vault.yaml is encrypted before committing.
* Woodpecker-CI team for the [self-documenting makefile](https://github.com/woodpecker-ci/woodpecker/blob/master/Makefile).
