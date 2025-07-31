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

DEFAULT_MODEL = openrouter/deepseek/deepseek-chat-v3-0324:free
GIT_COMMIT_MODEL = openrouter/deepseek/deepseek-chat-v3-0324:free

.PHONY: llm llm-git-commit
llm-git-commit: ## Configure llm for git commits
	llm aliases set git-commit $(GIT_COMMIT_MODEL)
	cp -f home/.mdeng/llm/git-commit.yaml "$$(llm templates path)"

llm-plugins: ## Install llm plugins
	llm install llm-gemini llm-cmd llm-anthropic llm-gguf llm-ollama llm-mistral
	llm uninstall -y llm-openrouter llm-deepseek llm-mdeng
	llm install 'https://github.com/michaelmdeng/llm-openrouter/archive/refs/tags/v0.4.1-mdeng0.1.zip'
	llm install 'https://github.com/michaelmdeng/llm-deepseek/archive/refs/tags/v0.1.4-mdeng.zip'
	llm install 'git+ssh://git@github.com/michaelmdeng/llm-mdeng.git@v0.0.2'

llm-options: ## Configure model options for llm CLI
	home/.mdeng/llm/apply-model-options.sh home/.mdeng/llm/model-options.json

llm-aliases: llm-plugins ## Install llm CLI and dependencies
	llm aliases set fast-free openrouter/deepseek/deepseek-chat-v3-0324:free
	llm aliases set tool-free openrouter/moonshotai/kimi-k2:free
	llm aliases set reason-free openrouter/deepseek/deepseek-r1-0528:free
	llm aliases set default-open openrouter/qwen/qwen3-235b-a22b-2507
	llm aliases set fast-open openrouter/qwen/qwen3-235b-a22b-2507
	llm aliases set tool-open openrouter/moonshotai/kimi-k2
	llm aliases set reason-open openrouter/deepseek/deepseek-r1-0528
	llm models default $(DEFAULT_MODEL)

llm: llm-aliases llm-git-commit llm-plugins ## Install llm CLI and dependencies
