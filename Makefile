# originally from github.com/docker/cli
all: binary

.PHONY: test
test:
	go test -v ./...

.PHONY: clean
clean: ## remove build artifacts
	rm -rf ./build/* cli/winresources/rsrc_* ./man/man[1-9] docs/yaml/gen

.PHONY: binary
binary: ## build executable for Linux
	@echo "WARNING: binary creates a Linux executable. Use cross for macOS or Windows."
	./scripts/build/binary

.PHONY: cross
cross: ## build executable for macOS and Windows
	./scripts/build/cross

.PHONY: binary-windows
binary-windows: ## build executable for Windows
	./scripts/build/windows

.PHONY: binary-osx
binary-osx: ## build executable for macOS
	./scripts/build/osx

.PHONY: help
help: ## print this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
