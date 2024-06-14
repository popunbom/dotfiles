MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

include $(MAKEFILE_DIR)/../functions.mk

.PHONY: setup
setup:
	$(call RUN_CMD, ln -s $(MAKEFILE_DIR)/.vimrc $(HOME)/.vimrc)
	@echo "Installing NeoBundle..."
	$(call RUN_CMD, /bin/bash <(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh))
