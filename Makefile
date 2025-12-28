.PHONY: install
install:
	./install.sh

.PHONY: uninstall
uninstall:
	./install.sh rm

.PHONY: gitconfig
gitconfig:
	./install-gitconfig.sh
