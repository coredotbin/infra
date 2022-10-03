##@ General

.PHONY: help
help: ## Display this help
	# Credit the the Woodpecker-CI team for this awesome line
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
echo Ensure vault is encrypted...
if ( cat vars/vault.yaml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "\e[38;5;108mVault Encrypted. Safe to commit.\e[0m"
else
echo "\e[38;5;208mVault not encrypted! Run 'make encrypt' and try again.\e[0m"
exit 1
fi
echo Running yamllint...
hash yamllint > /dev/null 2>&1; if [ \$\$ -ne 0 ]; then yamllint . || exit 1; fi
echo Running ansible-lint...
hash ansible-lint > /dev/null 2>&1; if [ \$\$ -ne 0 ]; then ansible-lint || exit 1; fi
EOT
chmod +x .git/hooks/pre-commit
fi
echo Set git pre-commit hook
endef
export gitinit = $(value _gitinit)

.PHONY: init
init: install-tools reqs ## Initialize git hooks and install 
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

.PHONY: check
check: ## Run Ansible playbook in check mode
	ansible-playbook -b run.yaml --check

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
	ansible-playbook -b run.yaml --limit $(RUN_ARGS)
