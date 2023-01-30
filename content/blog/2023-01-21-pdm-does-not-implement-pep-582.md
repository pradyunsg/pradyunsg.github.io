---
title: "PDM does not implement PEP 582, at the time of writing"
tags: ["Python Packaging", "PDM", "PEP 582", "Quick Ones"]
modified: 2023-01-30T22:12:00-07:00
---

Note: I've updated this to reflect _how_ this happened, on recommendation from PDM's author.

PDM [claims to implement PEP 582](https://github.com/pdm-project/pdm/tree/c0974672a17be965ddcb0e191d35df08ad0c4b6e#highlights-of-features). However, if you look at what it implements, it is [something completely different](https://github.com/pdm-project/pdm/blob/c0974672a17be965ddcb0e191d35df08ad0c4b6e/src/pdm/pep582/sitecustomize.py#L11) from [the standard](https://peps.python.org/pep-0582/#example).

## PDM's file system structure

```text
<root>
    __pypackages__
        3.10
            bottle
    myscript.py
```

PDM will scan for the `__pypackages__` directory up to 5 folders above the "current" one.

## PEP 582's file system structure

```text
<root>
    __pypackages__
        lib
            python3.10
                site-packages
                    bottle
    myscript.py
```

PEP 582 says that the `__pypackages__` directory should be next to the script being executed, and there's no discovery logic "above" the script.

## How did this happen?

PDM implemented a draft PEP. Draft PEPs are not final, and are subject to changes. However, PDM cannot evolve with the PEP since that means frequent breakages to the user experience as the standard evolves.

This leads to a situation where PDM is advertising implementing a (draft) PEP, while not implementing that PEP since the draft has evolved.

## Why does this matter?

Well, outside of the issues with implementing draft proposals in workflow tooling, I think this is reflective of the issues with the competitive nature of the Python packaging ecosystem's workflow tooling space.

I'm willing to trust that PDM's authors are well intentioned and didn't intentionally aim to end up with "false advertising" in the first feature the project lists in the README.

Besides, I only took a closer look at this because I was talking to one of PEP 582's authors recently, and [LWN][lwn][^1] linked to someone on the internet was claiming that PDM is a solution to Python packaging.

[lwn]: https://lwn.net/SubscriberLink/920132/cb4d6c0f07b54952/

[^1]: Which... in case someone from LWN ends up reading this: I think that was a bad editorial choice.
