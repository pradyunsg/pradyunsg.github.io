---
title: "Improving my dotfiles manager with pipx and inline dependency metadata"
tags: ["Python", "dotfiles"]
---

I have a (somewhat unnecessarily) custom setup for managing my dotfiles and I made a nice improvement to it today.

## How it works

The dotfiles are managed by a Python script. In broad strokes, the script will:

- read a TOML file
- locate the configured paths
- create symlinks, based on custom marker text in the filenames, for files in subdirectories under the configured paths[^1]

If there's a conflict (i.e. two configured paths provide the same symlink target location), the TOML file contains the resolution for it (i.e. specifies one of the paths as the "winner" for that file). If a resolution doesn't exist, the script errors out.

This setup exists mainly to allow me to have work-only dotfiles managed in work's VCS with all their corporate stuff while keeping them separate yet cooperative with my dotfiles managed publicly on GitHub.

## The problem

Now, this effectively means that my dotfiles manager is a Python script. It also has a bunch of dependencies (specifically, `rich` because I like colors and `tomli` because it should probably run on all supported Python versions).

This usually means that you need to create a virtual environment to run it. That's gotten a bit tedious and fragile given how frequently I keep changing my Python installations (gotta keep up with the latest and greatest!).

## The solution

### The implementation

I figured out a way to ensure that the script can be run without needing to manage a virtual environment myself. Now, it can be run on any machine with a working `curl`, `bash`, `python3` and the ability to download from https://github.com. It also gracefully triggers MacOS' prompt for "Hey, do you want to install our developer tooling stuff?" (XCode Command Line Tools, via the `python3` shim they install on a new Mac).

This is made possible by `pipx`, inline dependency metadata and Python's zipapps. There are also a few shenanigans to make this script a valid Bash script and a valid Python script. A `""""true` serves as our little gem of polyglot magic to make that possible.

### How it works: Bash

Let me show you the script first, with Bash's syntax highlighting:

```bash
#!/usr/bin/env bash
#
# /// script
# requires-python = ">=3.8"
# dependencies = [
#   "rich",
#   "tomli",
# ]
# ///
#
""""true
if [[ ! -f '/tmp/pipx-dotfiles.pyz' ]]; then
  echo "Downloading pipx..."
  curl --proto '=https' --tlsv1.2 -sSLf https://github.com/pypa/pipx/releases/latest/download/pipx.pyz -o /tmp/pipx-dotfiles.pyz
fi
python3 /tmp/pipx-dotfiles.pyz run "$0" -- "$@"
exit
"""

import rich
print(rich.__version__)
```

From Bash's perspective, this script has a bunch of comments, then a few commands, and then an `exit`.

The way Bash processes a script is by reading it as a buffer and executing it before moving on. This allows Bash scripts containing syntax issues to be run, as long as the syntax issue is somewhere that isn't being read by Bash (i.e. after the point of exit). We're definitely using that since the Python code (which is not valid Bash syntax) is present after the `exit`.

To Bash, our little gem of magic (`""""true`) is the same as a `true` command since it's a bunch of empty strings concatenated together with `true`. And, `true` is used as a no-op command (it exits with code 0 and does nothing else).[^2] It is treated the same as a `true` on its own line and Bash proceeds with the rest of the logic as a regular Bash script.

The rest of the logic in the Bash script is to download `pipx`'s zipapp (if it's not already downloaded) and then run the script itself with `python3 <pipx-zipapp> run <script> -- <any arguments passed to the script>`.

### How it works: zipapp

Wait, a zipapp?

So, that's a fun Python feature: it can execute a zip file as if it were a script. Python will look for a `__main__.py` in the zip file and, if it's there, the `__main__.py` as if it were a script. See [the documentation](https://docs.python.org/3/library/zipapp.html) if you want to learn more about this.

In this case, the `pipx` maintainers create a maintain a zipapp and attach it to their GitHub releases. By using GitHub's `latest` release URL, we can fetch the zipapp for the latest release (with a redirect, hence the `-L` to `curl`) without much additional complexity.

### How it works: pipx run

`pipx run` enables running a script with the dependencies being installed by `pipx` in a cached virtual environment that is managed by `pipx`.

Notably, it supports [PEP 723](https://peps.python.org/pep-0723/) (inline script metadata) which enables declaring dependency information inline. This is what the `/// script` and `///` are serving as markers for. The `requires-python` and `dependencies` are bits of metadata that `pipx` will use to determine what needs to be present for running the script.

Assuming you're on a compatible Python, `pipx` will parse that chunk, install the dependencies in a cached virtual environment and then run the script within that virtual environment. This means that the dependencies are installed by `pipx` and can/will be reused across multiple runs of the script by `pipx`.

### How it works: Python

Let's look at the script again, this time with Python's syntax highlighting:

```python
#!/usr/bin/env bash
#
# /// script
# requires-python = ">=3.8"
# dependencies = [
#   "rich",
#   "tomli",
# ]
# ///
#
""""true
if [[ ! -f '/tmp/pipx-dotfiles.pyz' ]]; then
  echo "Downloading pipx..."
  curl --proto '=https' --tlsv1.2 -sSLf https://github.com/pypa/pipx/releases/latest/download/pipx.pyz -o /tmp/pipx-dotfiles.pyz
fi
python3 /tmp/pipx-dotfiles.pyz run "$0" -- "$@"
exit
"""

import rich
print(rich.__version__)
```

From Python's perspective, this script has a bunch of comments, then a docstring, and then the whole Python script.

To Python, our little gem of magic (`""""true`) is the start of a multiline string which starts with the content `"true\n`. This is valid Python syntax, and Python will happily treat it as the start of the string literal. The end of the string literal is the next `"""` it encounters, which is the one at the end of the Bash parts of the script.

This means that the Bash script is treated as a multiline string by Python. It's treated as the docstring of the Python script. I am not too concerned about that since this is a script that doesn't need a docstring.

[^1]: `symlink` with periods around it based on where in the file it shows up
[^2]: It is possible to put almost any valid Bash syntax after the 4 double quotes (like, you can start an `if` statement, or something else) as long as you don't have whitespace between the 4th double quote and the keyword/CLI tool name. I just didn't like how that stuff looked so I went with `true` on that line.
