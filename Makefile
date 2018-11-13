# -- vet

vet\:check:  ## Check rust syntax (alias: check)
	cargo check --all -v
.PHONY: vet\:check

check: | vet\:check
.PHONY: check

vet\:format:  ## Check format without changes (alias: vet:fmt, fmt)
	cargo fmt --all -- --check
.PHONY: format

vet\:fmt: | vet\:format
.PHONY: vet\:fmt

fmt: | vet\:format
.PHONY: fmt

vet\:lint:  ## Check code style using clippy (alias: lint)
	cargo clippy --all-targets
.PHONY: vet\:lint

lint: | vet\:lint
.PHONY: lint

vet\:all: | vet\:check vet\:format vet\:lint  ## Check by all vet:xxx targets
.PHONY: vet\:all

vet: | vet\:check  ## Same as vet:check
.PHONY: vet


# -- test

test\:bin:  ## Run only tests for bin (ahnung)
	cargo test --bin ahnung
.PHONY: test\:bin

test\:lib:  ## Run only tests for lib
	cargo test --lib
.PHONY: test\:lib

test\:integration:  ## Run integrations test only
	cargo test --test integration_test
.PHONY: test\:integration

test\:all:  ## Run all tests
	cargo test --tests
.PHONY: test\:all

test: | test\:lib  ## Same as test:lib
.PHONY: test


# -- coverage

coverage\:bin:  ## Create coverage report of tests for bin (alias cov:bin)
	cargo clean --target-dir target/debug
	cargo test --bin ahnung --no-run
	./.tools/check-kcov ahnung kcov
.PHONY: coverage\:bin

cov\:bin: | coverage\:bin
.PHONY: cov\:bin

coverage\:lib:  ## Create coverage report of tests for lib (alias cov:lib)
	cargo clean --target-dir target/debug
	cargo test --lib --no-run
	./.tools/check-kcov ahnung kcov
.PHONY: coverage\:lib

cov\:lib: | coverage\:lib
.PHONY: cov\:lib

coverage\:integration:  ## Create coverage report of integrations test (alias cov:integration)
	cargo clean --target-dir target/debug
	cargo test --test integration_test --no-run
	./.tools/check-kcov integration_test kcov
.PHONY: coverage\:integration

cov\:integration: | coverage\:integration
.PHONY: cov\:integration

coverage: | coverage\:lib  ## Same as coverage:lib (alias: cov)
.PHONY: coverage

cov: | coverage
.PHONY: cov

# -- doc

document:  ## Generate documentation files (alias: doc)
	cargo rustdoc -- --document-private-items -Z --display-warnings
.PHONY: document

doc: | document
.PHONY: doc


# -- build

build\:debug:  ## Create debug build
	cargo build
.PHONY: build\:debug

build\:release:  ## Create release build
	cargo build --release
.PHONY: build\:release

build: | build\:debug  ## Same as build:debug
.PHONY: build


# -- other utilities

clean:  ## Clean up
	cargo clean
.PHONY: clean

help:  ## Display this message
	@grep -E '^[0-9a-z\:\\]+: ' $(MAKEFILE_LIST) | grep -E '  ## ' | \
	  sed -e 's/\(\s|\(\s[0-9a-z\:\\]*\)*\)  /  /' | tr -d \\\\ | \
	  awk 'BEGIN {FS = ":  ## "}; {printf "\033[36m%-21s\033[0m %s\n", $$1, $$2}' | \
	  sort
.PHONY: help

.DEFAULT_GOAL = test
default: test
