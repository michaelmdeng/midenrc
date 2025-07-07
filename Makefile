DEFAULT_GOAL := help

HOMESHICK_REPO = $(HOME)/.homesick/repos/
HOMESHICK = $(HOME)/.homesick/repos/homeshick/bin/homeshick

.PHONY: help
help: ## Display this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: link
link: ## Link dotfiles using homeshick
	$(HOMESHICK) link -f midenrc

.PHONY: clean
clean: ## Clean broken symlinks
	./scripts/clean.sh