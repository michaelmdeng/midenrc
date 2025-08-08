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

.PHONY: llm-install
llm-install: ## Reinstall the llm tool
	uv tool install --python=python3.13 --reinstall "git+ssh://git@github.com/michaelmdeng/llm.git@mdeng/main"

.PHONY: llm llm-templates
llm-templates: ## Configure llm templates
	llm aliases set git-commit $(GIT_COMMIT_MODEL)
	cp -f home/.mdeng/llm/git-commit.yaml "$$(llm templates path)"
	cp -f home/.mdeng/llm/agent.yaml "$$(llm templates path)"

.PHONY: llm-plugins
llm-plugins: ## Install llm plugins
	llm install llm-gemini llm-cmd llm-anthropic llm-ollama
	llm uninstall -y llm-openrouter llm-mdeng
	llm install 'https://github.com/michaelmdeng/llm-openrouter/archive/refs/tags/v0.4.1-mdeng0.1.zip'
	llm install 'git+ssh://git@github.com/michaelmdeng/llm-mdeng.git@v0.1.1'

.PHONY: llm-options
llm-options: ## Configure llm model options
	home/.mdeng/llm/apply-model-options.sh home/.mdeng/llm/model-options.json

.PHONY: llm-aliases
llm-aliases: llm-plugins ## Configure llm model aliases
	llm aliases set default-free openrouter/deepseek/deepseek-chat-v3-0324:free
	llm aliases set fast-free openrouter/deepseek/deepseek-chat-v3-0324:free
	llm aliases set tool-free openrouter/moonshotai/kimi-k2:free
	llm aliases set reason-free openrouter/deepseek/deepseek-r1-0528:free

	llm aliases set default-paid openrouter/openai/gpt-5-mini
	llm aliases set fast-paid openrouter/openai/gpt-oss-120b
	llm aliases set tool-paid openrouter/openai/gpt-5
	llm aliases set reason-paid openrouter/openai/gpt-5

	llm models default $(DEFAULT_MODEL)

.PHONY: llm
llm: llm-aliases llm-templates llm-plugins ## Install llm CLI and dependencies
