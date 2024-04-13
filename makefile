##@ General

# Credit the the Woodpecker-CI team for this awesome help script
.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install-tools: ## Install development tools
	@hash yamllint > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		pip install yamllint; \
	fi ; \
	hash ansible-lint > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		pip install ansible-lint; \
	fi

# Initiliaze git pre-commit hook to ensure vault.yaml is encrypted
# Credit to Nick Busey from HomelabOS
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355
define _gitinit
if [ -d .git/ ]; then
rm .git/hooks/pre-commit > /dev/null 2>&1
cat <<EOT >> .git/hooks/pre-commit
# git pre-commit
printf "Checking that vault is encrypted...\n"
if ( cat vars/vault.yaml | grep -q "\$ANSIBLE_VAULT;" ); then
printf "\033[0;32mVault Encrypted. Safe to commit.\033[0m\n"
else
printf  "\033[0;31mVault not encrypted! Run 'make encrypt' and try again.\033[0m\n"
exit 1
fi
printf "Running yamllint...\n"
hash yamllint > /dev/null 2>&1; if [ \$\$ -ne 0 ]; then yamllint . || exit 1; fi
printf "Running ansible-lint..."
hash ansible-lint > /dev/null 2>&1; if [ \$\$ -ne 0 ]; then ansible-lint || exit 1; fi
EOT
chmod +x .git/hooks/pre-commit
else
printf "\033[1;31mError\033[0;31m: Either the repository failed to download, or a new repository has not yet been initialized.\033[0m\n"
fi
echo Set git pre-commit hook
endef
export gitinit = $(value _gitinit)

.PHONY: init
init: install-tools reqs ## Initialize Git hooks, requirements, and dev tools
	@ eval "$$gitinit"

##@ Requirements

reqs: ## Install Ansible Galaxy requirements
	ansible-galaxy install -r roles/requirements.yaml
forcereqs: ## Force install Ansible Galaxy requirements
	ansible-galaxy install -r roles/requirements.yaml --force

##@ Vault

encrypt: ## Encrypt the Ansible vault
	ansible-vault encrypt vars/vault.yaml
decrypt: ## Decrypt the Ansible vault
	ansible-vault decrypt vars/vault.yaml

##@ Test

.PHONY: lint
lint: install-tools ## Lint yaml and Ansible
	yamllint .
	ansible-lint

# If the first argument is "check"...
ifeq (check,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "check"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: check
check: lint ## Run Ansible playbook in check mode
	ansible-playbook -b run.yaml --check --diff $(RUN_ARGS)

##@ Run

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: run
run: lint ## Run Ansible
	ansible-playbook -b run.yaml $(RUN_ARGS)

# If the first argument is "upgrade"...
ifeq (upgrade,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "upgrade"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: upgrade
upgrade: ## Update and Upgrade apt packages
	ansible-playbook -b upgrade.yaml $(RUN_ARGS)
