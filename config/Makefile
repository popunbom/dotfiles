MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

include $(MAKEFILE_DIR)/../functions.mk

.PHONY: setup
setup:
	$(call RUN_CMD, ln -s $(MAKEFILE_DIR) $(HOME)/.config)
