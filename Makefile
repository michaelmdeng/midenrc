HOMESHICK_REPO = $(HOME)/.homesick/repos/
HOMESHICK = $(HOME)/.homesick/repos/homeshick/bin/homeshick

.PHONY: link
link:
	$(HOMESHICK) link -f midenrc

.PHONY: clean
clean:
	./scripts/clean.sh
