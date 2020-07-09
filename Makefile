default: build

.PHONY: build serve

_check:
	bundler 2>&1 >/dev/null || (echo "Could not find bundler"; exit 1)

build: _check
	bundler exec jekyll build
serve: _check
	bundler exec jekyll serve
