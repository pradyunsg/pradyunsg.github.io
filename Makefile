default: build

.PHONY: build serve

_check:
	bundler || echo "Could not find bundler"

build: _check
	bundler exec jekyll build
serve: _check
	bundler exec jekyll serve
