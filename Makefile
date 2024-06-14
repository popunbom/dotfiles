SUBDIRS = $(dir $(wildcard */Makefile))

.PHONY: setup
setup:
	@$(foreach dir,$(SUBDIRS),$(MAKE) -C $(dir) setup)
