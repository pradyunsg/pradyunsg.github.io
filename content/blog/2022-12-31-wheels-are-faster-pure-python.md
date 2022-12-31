---
title: Wheels are faster, even for pure Python packages
tags: ["Python packaging", "Quick ones"]
---

When installing with pip (or from PyPI in general), wheels are _much_ faster
than source distributions, _even_ for pure-Python projects.

Packages with native code are a clearer win, because the wheel file will contain
pre-compiled binaries for the platform you're installing on. This means that you
don't need to have a compiler and non-Python build dependencies installed, and
you don't need to wait for the compiler to do its thing.

## The quick answer

Installing from a wheel is analogous to unpacking a zip file. When installing
from a source distribution, pip will actually build a wheel _from_ the source
distribution and then install using that wheel. It's the same operation at the
end of the day, but there's a bunch of extra "work" involved in building a wheel
from a source distribution (which contributes to making things slower).

## The picture answer

```goat
.---------------------.
| pip install package +-------------------.
'---------+-----------'                   |
          | from                          | from
          | wheel                         | source
          |                               v
          |                     .---------------------.
          |                     |  Unpack source code |
          |                     |  to temporary dir   |
          |                     '---------+-----------'
          |                               |
          |                               v
          |                     .-----------------------.
          |                     | (for isolated builds) |
          |                     |   Create build env    |
          |                     '---------+-------------'
          |                               |
          |                               v
          |                     .-----------------------.
          |                     | (for isolated builds) |
          |                     |   Populate build env  |
          |                     '---------+-------------'
          |                               |
          |                               v
          |                     .---------------------.
          |                     |  Call build-backend |
          |                     |  to generate wheel  |
          |                     '---------+-----------'
          |                               |
          |                               v
          |                     .---------------------.
          |                     |  Delete build env   |
          |                     |  and unpacked code  |
          |                     '---------+-----------'
          v                               |
.--------------------------.              |
|  Install from wheel file |<-------------'
'---------+----------------'
          |
          v
.---------------------.
| Unpack wheel file   |
'---------+-----------'
          |
          v
.---------------------.
|  Installed package  |
'---------------------'
```

## The wordy answer

When installing from a wheel, pip will fetch the wheel file, and then unpack it.
That's it. There's nothing else to do.

When installing from a source distribution, pip will fetch the source
distribution, unpack it to a temporary directory, (potentially) a build
environment to be created and install build-dependencies in that environment,
make a subprocess call (or multiple) to the build-backend to get it to generate
a wheel file. The build environment and unpacked sources are then deleted. We
now have a wheel file which will then be handled like any other wheel file.

## Further reading

- [How pip builds packages from source](https://pip.pypa.io/en/stable/reference/build-system/)
- [Specification of the wheel format](https://packaging.python.org/en/latest/specifications/binary-distribution-format/)
- [Installer]'s source code, if you're inclined that way
- [pypackaging-native]: "a collection of content about key Python packaging
  topics and issues for projects using native code"

[pip]: https://pip.pypa.io/
[installer]: https://installer.pypa.io/
[pypackaging-native]: https://pypackaging-native.github.io/

[^1]:
    Yea, those are different. Source distribution files are `.tar.gz` files with
    the source code _and_ metadata about the package in a standard location.
    Source tarballs are just the source code, without the metadata.
