define BREW_INSTALL
	$(eval PACKAGE_NAME := $(strip $1))
	@if ! brew list $(PACKAGE_NAME) >/dev/null 2>&1; then \
		echo '[Homebrew] Installing: $(PACKAGE_NAME)'; \
		brew install $(PACKAGE_NAME); \
	fi
endef
define RUN_CMD
	$(eval CMD := $(strip $1))
	@if [[ -z "$(DRY_RUN)" ]]; then echo '[RUNNING] $(CMD)'; else echo '[DRY_RUN] $(CMD)'; fi
	@if [[ -z "$(DRY_RUN)" ]]; then /bin/bash -c '$(CMD)'; fi;
endef
