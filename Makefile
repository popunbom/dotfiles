SUBDIRS = $(dir $(wildcard */Makefile))

define MAKE_SETUP
	$(eval SUBDIR := $(strip $(1)))

	$(MAKE) -C $(SUBDIR) setup
endef

.PHONY: setup
setup:
	$(foreach SUBDIR, $(SUBDIRS), $(call MAKE_SETUP, $(SUBDIR)))
