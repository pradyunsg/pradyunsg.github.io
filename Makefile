default: build

.PHONY: build serve

build:
	bundler exec jekyll build
serve:
	bundler exec jekyll serve
