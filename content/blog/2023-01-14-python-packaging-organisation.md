---
title: "How the Python Packaging community is organised"
tags: ["Python Packaging", "Governance", "Python"]
---

The way the Python packaging community is organised is something that I've
explained in multiple places, in multiple contexts. I figure that it'll be
useful to actually write it down in a single place, so that I don't have to
repeat myself.

## The Python Packaging Authority

The Python Packaging Authority (PyPA) is a fairly loose group of projects that
happen to be related to Python packaging. While the PyPA has a formal
[governance](https://peps.python.org/pep-0609/) model, there's no "oversight" or
"enforcement" on projects that are part of the PyPA -- they are only required to
adopt the PSF Code of Conduct and to be accepted by the existing members.

Functionally, each PyPA project is free to do what it wants. The only real
benefit of being a PyPA project is the ability to use the PSF as a fiscal
sponsor and the ability to say that it's a "PyPA project".

Practically, the PyPA serves as ["a body to hammer out & maintain
interoperability specifications"][pypa-hammer-specs] for Python packaging. The
PyPA also includes foundational tools that are used in the Python packaging
ecosystem, like `pip` and `setuptools`.

## Relationship with "Python Core"

(I'm using "Core Python" to refer to the Python language and standard library,
as maintained by the CPython Core Developers, also known as ["core
team"][cpython-core-team] for Python)

As of the time of writing, Core Python's involvement in Python Packaging (in a
[post-distutils](https://peps.python.org/pep-0632/) world) is fairly limited.
The interpreter and Python standard library provide the following pieces, around
the packaging ecosystem:

- Shipping `ensurepip` and `venv` in the standard library.

  - `venv` supports creating a virtual environment with pip and
    setuptools[^setuptools-is-gonna-be-removed] installed in it.
  - `ensurepip` provides copies of `pip` and
    `setuptools`[^setuptools-is-gonna-be-removed] that are used by `venv`, and
    allows bootstrapping the packaging tooling for Python.

- "site-packages" directories on the import path.

  - `site` adds site-packages ("global" and "user") to the import path.
  - `site` respects the presence of a `pyvenv.cfg` file (used by `venv`) to mark
    a virtual environment, influencing which site-packages it adds to the import
    path.

- `sysconfig` provides relevant paths for placing files and build configuration
  for the interpreter.

- a [stable ABI](https://docs.python.org/3/c-api/stable.html) for the C API, for
  building extensions compatible across Python 3.x (x >= 2).

### Delegation of Python packaging ecosystem decisions

The Python Steering Council delegates the decision making for the packaging
ecosystem to the Python Packaging Authority (PyPA). This is done through
[standing delegations][pypa-delegations] to specific PyPA members on specific
aspects of Python Packaging. The PyPA is, like CPython Core Developers, a group
of volunteers who maintain various bits and pieces of the Python packaging
ecosystem.

The CPython Core Developers and the PyPA are not the same group of people, but
there is meaningful overlap between the two groups. There are 85 "active"
CPython Core Developers[^cpython-count] and 50+ (public) PyPA
members[^pypa-count]. Off the top of my head, I can count 5 people who are
active in both CPython and one or more PyPA projects.

## A bit of history

From https://www.pypa.io/en/latest/history/:

> 2011-02-28: The Python Packaging Authority (PyPA) is created to take over the
> maintenance of pip and virtualenv from Ian Bicking, led by Carl Meyer, Brian
> Rosner and Jannis Leidel. Other proposed names were “ianb-ng”, “cabal”, “pack”
> and “Ministry of Installation”.

As "Ministry of Installation" likely implies, these names were [chosen partly in
jest][jest]. The name stuck and, those who started using Python _after_ this
name was picked, ended up treating the name at face value. PyPA projects
essentially serves as _all_ of the packaging infrastructure for Python making it
the de facto authority.

Over time, "Authority" in PyPA did end up being backed by real authority: the
standing delegations from the elected Python Steering Council, ceding control of
certain kinds of Python Enhancement Proposals (PEPs) to specific PyPA members.
There's [formal processes][process], [formal interoperability
specifications][specs] as Python PEPs and a [formal governance
model][governance].

To quote [Thomas Kluyver][pypa-hammer-specs] again:

> You don’t get much more authoritative than that without an army.
> :slightly_smiling_face:

## What about non-PyPA projects?

Since PyPA's inception, there have been non-PyPA projects related to Python
packaging (eg: buildout is older than pip). By and large, there isn't any sort
of antagonistic relationship between PyPA and non-PyPA projects. PyPA and
non-PyPA project maintainers have often worked together on various things, and
many [non-PyPA projects are listed as "key projects"][key-projects] for Python
packaging.

For example, at the time of writing, the two most popular non-PyPA projects are
Conda and Poetry. Both of these rely on the interoperability specifications
and/or tools that the PyPA works on ([conda][conda-build],
[poetry][poetry-pyproject]) to do what they do.

[pypa-delegations]:
  https://github.com/python/steering-council/blob/main/process/standing-delegations.md#pypa-delegations
[pypa-hammer-specs]:
  https://discuss.python.org/t/what-is-the-pypa/12297/2?u=pradyunsg
[cpython-core-team]: https://peps.python.org/pep-0013/#the-core-team
[jest]: https://discuss.python.org/t/what-is-the-pypa/12297/6?u=pradyunsg
[specs]: https://peps.python.org/topic/packaging/
[process]: https://www.pypa.io/en/latest/specifications/
[governance]: https://peps.python.org/pep-0609/
[conda-build]: https://conda-forge.org/docs/maintainer/adding_pkgs.html#use-pip
[poetry-pyproject]: https://python-poetry.org/docs/pyproject/#poetry-and-pep-517
[key-projects]:
  https://packaging.python.org/en/latest/key_projects/#non-pypa-projects

[^cpython-count]:
    Based on the number of eligible votes in the last SC election:
    <https://peps.python.org/pep-8104/#results>. "active" is determined as
    described in [Python Language Governance][python-governance] document.

[^pypa-count]:
    Based on public folks listed in https://github.com/orgs/pypa/people (not all
    are active though, and there's active folks who are not members of the
    GitHub org but have access to the various repositories).
