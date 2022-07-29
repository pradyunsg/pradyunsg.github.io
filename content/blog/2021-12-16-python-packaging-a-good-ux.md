---
title: "Python packaging: A good user experience?!"
# State of the Python Packaging Ecosystem
tags: ["python", "ecosystem", "opinion"]
summary: "What kind of sorcery would that be?"
draft: true
---

Python packaging has quite a reputation of being ridiculously difficult to get
right, understand and work with. It would not be a stretch to say that the
packaging and distribution story for Python is one of the main sources of pain
for many users.

I think there are many reasons for this, from the default tooling being "third
party", multiple competing solutions throughout the ecosystem, some design
choices that haven't aged well, the constraints of backwards compatibility and
more.

## The tragedy of choice

I am certain that it is not possible to create a single "workflow" tool for
Python software. What we have today, an ecosystem of tooling where each makes
different design choices and technical trade-offs, is a part of why Python is as
widespread as it is today. This flexibility and availability of choice is,
however, both a blessing and a curse.

When you package Python software, you have to make a lot of choices. There are a
_lot_, and I do mean a _lot_, of "A vs B" comparisons that you can make when it
comes to figuring out the scaffolding for packaging and distributing Python
software. Here's a short list: pip vs conda, poetry vs pipenv vs pdm, venv vs
virtualenv, flit vs setuptools, setup.py vs pyproject.toml, requirements.txt vs
setup.py.

This has a significant cognitive cost for developers. Most folks don't really
care strongly about most of these choices and would prefer that they be made for
them; at least, by default. What they usually want to do is get the scaffolding
done with, so that they can start doing the thing they actually wanted to do .
If they don't have "the battle scars" yet, the conversion usually includes one
of "why isn't there one recommended way to do things!?" or "why is there this
magical option to have the right behaviour!?". There's also quoting of the Zen
of Python, depending on whether you're on r/Python or Hacker News. :)

## Papercuts

### Publisher

One of the most frustrating parts of trying to publish a Python package is
working with distutils (and by extension, setuptools). Writing a setup.py file
that works and does the right things for your package is frustratingly
difficult. In fact, it's easier to make an unintended choice (i.e. mistake)
because of unintuitive behaviours and a lack of documentation.

You often need to have multiple files to get things working right. A `setup.py`
file, _maybe_ a `setup.cfg` file and a `MANIFEST.in` file. Even then, you might
still get things wrong! Even something like having a dirty build directory can
be the reason for issues major issues (see the pip 20.0 release).

### Redistributor

It is not possible to determine the dependencies of a package without executing
code [^1].

### Consumer

## Contrast

Let's contrast this with... Javascript + npm. A single file `package.json`
specifies the metadata in a machine readable format, provides a basic runner for
various development commands and serves as both the distribution generation tool
(i.e. publishing) as well as the development tool (i.e. installing already
published packages). Each project gets it's own separate directory containing
dependencies (`node_modules`).

## The problem under the trench coat

[discuss how of Python packaging problems being Python distribution problems in
a trench coat]

The moment you start looking at how Python gets redistributed though... well,
it's a fucking mess. Many popular redistributors make significant opinionated
choices that are just... plain bad from a user experience perspective.

[homebrew python is not for you]. [debian python is not for you]. [arch linux
python is not for you].

## The clear lagoon

Once you make it past the initial hump, of getting a "good" copy of CPython
(possibly by compiling it yourself, with pyenv or asdf) and learning to always
use virtual environments, there is an existing solution

- getting a working Python installation that's not been messed up by a
  redistributor.
- learning to always use a virtual environment to isolate your projects.

Even then, you need These aren't negligible humps.

Things are getting better. You can move away from certain painful things (eg:
setuptools) Use flit

This is a collection of summaries of the state of the Python Packaging
Ecosystem.

I've had a lot of people express confusion about the state of many ongoing
projects in the Python packaging ecosystem. I'm very firmly in the middle of a
lot of these things, in a

## For package authors

### Building pure-Python Packages

### Building Python Packages with extensions in other languages

## For package consumers

## How can you help?

In a lot of ways.

## There is a problem

In the spirit of "criticism is a

So... I'll be honest, as someone who has been involved in this ecosystem for
more than 5 years, this statement has been around since I got involved.

feels like it's a placeholder for saying "I can't do exactly what I want to do".

the statement is not untrue. There's a lot of moving pieces nearly all of those
pieces are exposed to the user and there's a lot of flexibility provided by this
for most users do not need this fix ability this flexibility is both the best
and the worst parts of Python a python

Let's look at what the workflow today looks like, and let's see how many times a
user needs to make a choice.

Let's start with a simple script that I want to ship to my users.

## Conclusions

Well, I've been fairly harsh through this post. Perhaps unfairly harsh,
honestly. A lot of the folks who work on the other projects I've named are
friends, colleagues and fellow maintainers. I've helped design some of the major
features in some of the projects. Heck, I'm a maintainer on a few of the
projects I've called out.

[^1]:
    Well... it's feasible in some cases. You can try parsing the `setup.py` file
    of the project, if it uses setuptools. If the project has a `pyproject.toml`
    file and a `[project]` table within it, you can just read the `dependencies`
    from it (thanks to [PEP 621]).

[pep 621]: https://www.python.org/dev/peps/pep-0621/
