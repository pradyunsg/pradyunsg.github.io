# Testing the next-gen pip dependency resolver

This is an attempt to summarize the broader software architecture around dependency resolution in pip and how testing is being done around this area.

The motivation behind writing this, is to make sure all the developers working on this project are on the same page, and to have a written record about the state of affairs.

## Architecture

The "legacy" resolver in pip, is implemented as part of pip's codebase and has been a part of it for many years. It's very tightly coupled with the existing code, isn't easy to work with and has severe backward compatibility concerns with modifying directly -- which is why we're implementing a separate "new" resolver in this project, instead of trying to improve the existing one.

The "new" resolver that is under development, is not implemented as part of pip's codebase; not completely anyway. We're using an abstraction that separates all the metadata-generation-and-handling stuff vs the core algorithm. This allows us to work on the core algorithm logic (i.e. the NP-hard search problem) separately from pip-specific logic (eg. download, building etc). The abstraction and core algorithm are written/maintained in <https://github.com/sarugaku/resolvelib> right now. The pip-specific logic for implementing the "other side" of the abstraction is in <https://github.com/pypa/pip/tree/master/src/pip/_internal/resolution/resolvelib>.

## Testing

In terms of testing, we have dependency-resolution-related tests in both resolvelib and pip.

### resolvelib

The tests in resolvelib are intended more as "check if the algorithm does things correctly" and even contains tests that are agnostic to the Python ecosystem (eg. we've borrowed tests from Ruby, Swift etc). The goal here is to make sure that the core algorithm we implement is capable of generating correct answers (for example: not getting stuck in looping on the same "requirement", not revisiting rejected nodes etc).

### pip

The tests in pip is where I'll start needing more words to explain what's happening. :)

#### YAML-based tests

We have "YAML" tests which I'd written back in 2017, as a format to easily write tests for pip's new resolver when we implement it. However, since we didn't have a need for it to be working completely back then (there wasn't a new resolver to test with it!), the "harness" for running these tests isn't complete and would likely need some work to be as feature complete as we'd want it to be, for writing good tests.

YAML tests: <https://github.com/pypa/pip/tree/master/tests/yaml>
YAML test "harness": <https://github.com/pypa/pip/blob/master/tests/functional/test_yaml.py> and <https://github.com/pypa/pip/blob/master/tests/lib/yaml_helpers.py>

#### "new" resolver tests

##### unit tests

We have some unit tests for the new resolver implementation. These cover very basic "sanity checks" to ensure it follows the "contract" of the abstraction, like "do the candidates returned by a requirement actually satisfy that requirement?". These likely don't need to be touched, since they're fairly well scoped and test fairly low-level details (i.e. ideal for unit tests).

New resolver unit tests: <https://github.com/pypa/pip/tree/master/tests/unit/resolution_resolvelib>

##### functional tests

We also have "new resolver functional tests", which are written as part of the current work. These exist since how-to-work-with-YAML-tests was not an easy question to answer and there needs to be work done (both on the YAML format, as well as the YAML test harness) to flag which tests should run with which resolver (both, only legacy, only new) and make it possible to put run these tests in CI easily.

New resolver functional tests: <https://github.com/pypa/pip/blob/master/tests/functional/test_new_resolver.py>

#### test_install*.py

These files test all the functionality of the install command (like: does it use the right build dependencies, does it download the correct files, does it write the correct metadata etc). There might be some dependency-resolution-related tests in `test_install*.py` files.

These files contain a lot of tests so, ideally, at some point, someone would go through and de-duplicate tests from this as well.

## How can you help?

If you use pip, there are a multiple ways that you can help us!

- First and most fundamentally, [please help us understand how you use pip by **talking with our user experience researchers**](https://bit.ly/pip-ux-studies). You can do this right now! You can take a survey, or have a researcher interview you over a video call. [Please sign up and spread the word](https://bit.ly/pip-ux-studies) to anyone who uses pip (even a little bit).

- Right now, even before we release the new resolver as a beta, you can help by **running `pip check` on your current environment**. This will report if you have any inconsistencies in your set of installed packages. Having a clean installation will make it much less likely that you will hit issues when the new resolver is released (and may address hidden problems in your current environment!). If you run `pip check` and run into stuff you can’t figure out, please [ask for help in our issue tracker or chat](https://pip.pypa.io/).

---

Thanks to Paul Moore and Tzu-Ping for help in reviewing and writing this post,
as well as Sumana Harihareswara for suggesting to put this up on my blog!
