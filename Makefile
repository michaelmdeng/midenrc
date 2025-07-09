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

DEFAULT_MODEL = openrouter/deepseek/deepseek-chat-v3-0324:free
GIT_COMMIT_MODEL = openrouter/deepseek/deepseek-chat-v3-0324:free

.PHONY: llm llm-git-commit
llm-git-commit: ## Configure llm for git commits
	llm aliases set git-commit $(GIT_COMMIT_MODEL)
	cp -f home/.mdeng/llm/git-commit.yaml "$$(llm templates path)"

llm: llm-git-commit ## Install and configure llm models
	llm install llm-gemini llm-openrouter llm-cmd llm-anthropic llm-deepseek llm-gguf llm-ollama llm-mistral
	llm models default $(DEFAULT_MODEL)
