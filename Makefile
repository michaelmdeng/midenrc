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

shellcheck: ## Run shellcheck on shell scripts
	git ls-files "**/*.sh" | xargs shellcheck

DEFAULT_MODEL = openrouter/qwen/qwen3-235b-a22b-07-25:free
GIT_COMMIT_MODEL = openrouter/qwen/qwen3-235b-a22b-07-25:free

.PHONY: llm llm-git-commit
llm-git-commit: ## Configure llm for git commits
	llm aliases set git-commit $(GIT_COMMIT_MODEL)
	cp -f home/.mdeng/llm/git-commit.yaml "$$(llm templates path)"

llm-plugins: ## Install llm plugins
	llm install llm-gemini llm-cmd llm-anthropic llm-gguf llm-ollama llm-mistral
	llm uninstall -y llm-openrouter llm-deepseek llm-mdeng
	llm install 'https://github.com/michaelmdeng/llm-openrouter/archive/refs/tags/v0.4.1-mdeng0.1.zip'
	llm install 'https://github.com/michaelmdeng/llm-deepseek/archive/refs/tags/v0.1.4-mdeng.zip'
	llm install 'https://github.com/michaelmdeng/llm-mdeng/archive/refs/tags/v0.0.1.zip'

llm-options: ## Configure model options for llm CLI
	home/.mdeng/llm/apply-model-options.sh home/.mdeng/llm/model-options.json

llm: llm-git-commit llm-plugins ## Install llm CLI and dependencies
	llm aliases set fast-free openrouter/qwen/qwen3-235b-a22b-07-25:free
	llm aliases set tool-free openrouter/qwen/qwen3-coder:free
	llm aliases set reason-free openrouter/deepseek/deepseek-r1-0528:free
	llm aliases set default-open openrouter/deepseek/deepseek-chat-v3-0324
	llm aliases set fast-open openrouter/qwen/qwen3-235b-a22b-07-25
	llm aliases set tool-open openrouter/qwen/qwen3-coder
	llm aliases set reason-open openrouter/deepseek/deepseek-r1-0528
	llm models default $(DEFAULT_MODEL)
