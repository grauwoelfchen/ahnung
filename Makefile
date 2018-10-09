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


# -- test

test:  ## Run unit tests and integration tests
	cargo test
.PHONY: test

test\:coverage:  ## Generate coverage report of unit tests using kcov (alias: test:cov)
	# cargo build --tests
	cargo test --no-run
	#./.tools/check-kcov integration_test
	./.tools/check-kcov ahnung kcov
.PHONY: test\:coverage

test\:cov: | test\:coverage
.PHONY: test\:cov


# -- doc

document:  ## Generate documentation files (alias: doc)
	cargo rustdoc -- --document-private-items -Z --display-warnings
.PHONY: document

doc: | document
.PHONY: doc


# -- build

build:  ## Create debug build
	cargo build
.PHONY: build

build\:release:  ## Create release build
	cargo build --release
.PHONY: build\:release


# -- other utilities

clean:  ## Clean up
	cargo clean
.PHONY: clean

help:  ## Display this message
	@grep -E '^[0-9a-z\:\\]+: ' $(MAKEFILE_LIST) | grep -E '  ## ' | \
	  sed -e 's/\(\s|\(\s[0-9a-z\:\\]*\)*\)  /  /' | tr -d \\\\ | \
	  awk 'BEGIN {FS = ":  ## "}; {printf "\033[36m%-14s\033[0m %s\n", $$1, $$2}' | \
	  sort
.PHONY: help

.DEFAULT_GOAL = test
default: test
