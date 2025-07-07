DEFAULT_MODEL = openrouter/deepseek/deepseek-chat-v3-0324:free
GIT_COMMIT_MODEL = openrouter/deepseek/deepseek-chat-v3-0324:free

.PHONY: llm llm-git-commit
llm-git-commit:
	llm aliases set git-commit $(GIT_COMMIT_MODEL)
	cp -f git-commit.yaml "$$(llm templates path)"

llm: llm-git-commit
	llm install llm-gemini llm-openrouter llm-cmd llm-anthropic llm-deepseek llm-gguf llm-ollama llm-mistral
	llm models default $(DEFAULT_MODEL)
