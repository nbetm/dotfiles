# Shell dotfile targets
BASH_DOTFILES := shell/dot-bashrc shell/dot-bash_profile shell/dot-blerc
SH_SCRIPTS := $(shell git ls-files '*.sh')
BIN_SCRIPTS := $(shell git ls-files 'shell/dot-local/bin/*' 'tmux/dot-local/bin/*' | xargs grep -l '^#!/.*bash' 2>/dev/null)
ALL_SHELL := $(BASH_DOTFILES) $(SH_SCRIPTS) $(BIN_SCRIPTS)
SHFMT_FLAGS := -i 4 -ci

.PHONY: help ci shellcheck shellformat shellformat-fix

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

ci: shellcheck shellformat ## Run all checks

shellcheck: ## Lint shell scripts
	@shellcheck $(ALL_SHELL)

shellformat: ## Check shell script formatting
	@shfmt $(SHFMT_FLAGS) --diff $(ALL_SHELL)

shellformat-fix: ## Auto-format shell scripts
	@shfmt $(SHFMT_FLAGS) --write $(ALL_SHELL)
