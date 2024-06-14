MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

include $(MAKEFILE_DIR)/../functions.mk

.PHONY: setup
setup:
	$(call BREW_INSTALL, sheldon)
	$(call RUN_CMD, curl -L https://iterm2.com/shell_integration/zsh > scripts/iterm2/shell_integration.zsh)
#	$(call RUN_CMD, sudo /bin/bash -c "echo export ZDOTDIR=$(MAKEFILE_DIR) >> /etc/zshenv")
