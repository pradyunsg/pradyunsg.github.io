---
title: "Choreographing a release process for my PyPI packages"
tags: ["Python Packaging"]
---

I maintain quite a few Python packages and they all have development workflows as well as release processes that are different in various ways.

This is basically my research document as I am exploring what I want the release process (and supporting development workflow) to look like for the Python packages I maintain, so that I can reduce the overhead caused by the various differences in these projects as well as the need to make all these decisions myself. I'm posting this publicly so that I can get feedback from a few people I know about this and whether they think it makes sense.

None of this is related to the whole "what build-backend/environment management/script runner tool should I use" situation but rather it's everything "around" that. I'm not going into the test running or documentation building aspects here, "just" the mechanics around making a package release.

## My design goals

This is basically "what I want" in terms of using existing communication channels, ensuring consistency and the development workflow.

- Have the version number managed as-is in the source tree.
- Have the version number be `{last_release+1}.dev{N}` during development.
- Have a git tag pointing to the commit with a release's code.
- Have a changelog auto-generated based on the Git history or source tree.
- Include the changelog in the documentation at the release tag.
- Publish to pypi.org via Trusted Publishers, triggered automatically but requiring manual approval[^paranoid].
- Publish a GitHub release.
  - Include the changelog in the GitHub release description.
  - Include the release files on the GitHub release.
- The git tag and GitHub release must not be published if the release cannot be uploaded to PyPI.
- Releasing to PyPI requires a manual approval even after PR merge.

## What those design goals imply

- changelog:
  - needs to be maintained in Markdown, specifically the intersection of [GFM] and [MyST].
  - needs to be generated _before_ making the commit that the release would be tagged on, since the documentation within the release should contain the generated changelog.
  - needs to only describe what happened between this release and the last one (so that it makes sense in the GitHub releases UI).
- PyPI release:
  - needs to happen on GitHub Actions, and the release needs to be triggered by a git tag (with protection rules on git tags).
  - needs to also upload the files to GitHub release.
- version number:
  - need a figure out the logic for bumping to next development version.
  - need some way to detect when a PR changes the version number and determine the commit that should trigger a release.

## Let's figure out the details now

The specific flow that seems to be needed here is:

- Merge a PR that bumps the release version.
- The merge will trigger a "release" workflow that has the ability to push a commit (containing the changelog) and trigger a different "publish" workflow.
- The triggered "publish" workflow needs approval to run and has the ability to publish to PyPI, push a git tag, publish a GitHub release and include the description as well as release files[^2].

### Changelog is not the same everywhere

Well, the changelog in documentation needs to do some things that the GitHub UI would do for "free": have a link to the original diff between releases and a link to individual PRs in changelog entries.

Additionally, the changelog in documentation should also have a preview when looking at "latest" documentation, to communicate how things would work.

### Deciding on how to detect version number changes

There's basically 2 options here:

- Try to look at the source of truth that lives in the source code (like `src/package/__init__.py -> __version__` / `pyproject.toml -> project.version`).
- Look at the relevant PR and bump the version based on some immutable thing about the PR.

I think the first is a better experience, since it's a bit more intuitive -- the version number changed and a release was automatically made. With this, an obvious place to make the release tag would be the "first" commit that bumps the version, which would need to vary based on merge strategy...

- merge commit: Use the merge commit into `main`, that has the multiple parents.
- squash merges: Use the first commit that bumps the version.
- rebase merges: Use the first commit that bumps the version... but wait...

#### Oh heck, rebase merges

Ohk, let's think through this. I have a PR that contains 3 commits:

- `3pstrel` Awesome change after the version bump
- `2verbmp` Version bump
- `1prerel` Awesome change before the version bump
- `0staquo` (main) Status quo

Assuming that this is rebase-merged, I _think_ the release commit should be based on top of `2verbmp`. But, the only way to have it make sense with `3pstrel` is to have the release commit be based on `2verbmp` and then later to do a merge commit -- which defeats the point of rebase merges (linear history).

I guess there's 2 options here:

- Detect such cases and error out.
- Don't bother merging back the release tag commit.

If we don't merge back the release tag commit, then the release process needs to not require _any_ code change other than the version bump. The changelog needs to be managed out-of-tree somehow (eg: in git?). I like having the ability to update a changelog entry that was contributed by a fly-by contributor after the PR has been merged, so this is a no-go for me.

In terms of detecting such cases, I guess I could have a GitHub Actions check that there isn't a commit in the PR after one that bumps the version.

#### Looking at the source of truth

Doing a quick search on the internet for how to find when a line has changed with git, I found [a useful StackOverflow question](https://stackoverflow.com/questions/13692072/git-blame-committed-line) which points me to `git log -L <range>:<file>`. Trying it out on pip tells me this is a good option:

```sh-session
❯ git ls -L 3,3:src/pip/__init__.py -q
c0cce3ca6 Bump for development [Stéphane Bidoul]
e3dc91dad (tag: 23.3) Bump for release [Stéphane Bidoul]
b6a267059 Bump for development [Paul Moore]
a3c2c43c5 (tag: 23.2) Bump for release [Paul Moore]
2fd3e408d Bump for development [Paul Moore]
6424ac460 (tag: 23.1) Bump for release [Paul Moore]
d21af1c98 Bump for development [Pradyun Gedam]
368c7b4c5 (tag: 23.0) Bump for release [Pradyun Gedam]
c8ae28001 Bump for development [Paul Moore]
0a76da3a9 (tag: 22.3) Bump for release [Paul Moore]
2132eb4cd Bump for development [Stéphane Bidoul]
8e7e76e60 (tag: 22.2) Bump for release [Stéphane Bidoul]
88d565cc3 Bump for development [Pradyun Gedam]
3c953322c (tag: 22.1) Bump for release [Pradyun Gedam]
6012b48e5 Bump for development [Pradyun Gedam]
9b203d5af (tag: 22.1b1) Bump for release [Pradyun Gedam]
0a916125e Bump for development [Pradyun Gedam]
1742af7bd (tag: 22.0) Bump for release [Pradyun Gedam]
2bf32f5f9 Bump for development [Pradyun Gedam]
abec8a701 (tag: 21.3) Bump for release [Pradyun Gedam]
[...]
```

And, that the existing automation around pip releases is quite nice.

I still need to figure out how to gracefully handle changes to the source of truth for versions as well as moving it around without logical changes (eg: editing the docstring, or changing quoting etc).

Oh, this reminded me about pip's releases...

### Let's think about pip

I'm not the only one who makes the calls on this but I think it would be nice to move pip to Trusted Publishers for publishing releases. Looking at the documented pip process, the main things that'd **need** to different if it adopted this release process would be:

1. Update `get-pip.py`'s GitHub repository to reflect the new pip release on PyPI.
2. Update an AUTHORS file.

Those don't seem particularly bad. For 1, we'd need to tweak the generation logic over on `get-pip.py` to listen for `repository_dispatch` and [trigger that event](https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-dispatch-event) manually with the relevant payload and that'll need `pypa/pip` to store an access token to `pypa/get-pip` that is only exposed for that specific trigger, which... seems doable.

## What needs to be created?

- 3 GitHub Actions reusable workflows for individual "tasks"
  - A "release" workflow that determines if a release needs to be made and triggers the "publish" workflow via a `workflow_dispatch`.
  - A "publish" workflow that does all the mechanics of making the release.
  - A "release-check" workflow that checks the commit situation to protect against "commit after version bump" edge cases.
- 1 GitHub Actions reusable workflow for consolidated handling in project CI, to enable the project's `release.yml` to be a short file that's "just" `on: [...]` and `uses: [...]`.

## Naming: The second hardest problem in computer science

I feel like I should come up with a name for this, because it'd make communicating about this easier for me and because this workflow _feels_ like it would be useful to more than just me.

This is automation that makes a release when it detects by a version change in source code and publishes to PyPI and GitHub, with an auto-generated changelog.

For now, this is a problem for future me and depends on whether he decides that he needs to maintain another piece of reusable software.

[gfm]: https://github.github.com/gfm/
[myst]: https://myst-parser.readthedocs.io/en/latest/

[^paranoid]: With a few too many "critical" (i.e. top 1% packages) on PyPI, including literally pip, I think an extra step to ensure that it's a bit harder to take-over things unilaterally seems reasonable to me.
[^2]: If you're an SBOM/SLSA person, this is also where I'd like to include some sort of attestation/provenance information but there isn't any clear-enough documentation that I could find for how to do this. Please email me if you know of a solution (`mail@{this domain}`).
