---
title: "PDM does not implement PEP 582"
tags: ["Python Packaging", "PDM", "PEP 582", "Quick Ones"]
---

PDM [claims to implement PEP 582](https://github.com/pdm-project/pdm/tree/c0974672a17be965ddcb0e191d35df08ad0c4b6e#readme). However, if you look at what it implements, it is [something completely different](https://github.com/pdm-project/pdm/blob/c0974672a17be965ddcb0e191d35df08ad0c4b6e/src/pdm/pep582/sitecustomize.py#L11) from [the standard](https://peps.python.org/pep-0582/#example).

## PDM's file system structure

```text
<root>
    __pypackages__
        3.10
            bottle
    myscript.py
```

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

## Why does this matter?

Well, outside of the issues with implementing draft proposals in workflow tooling, I think this is reflective of the issues with the competitive nature of the Python packaging ecosystem's workflow tooling space.

I'm willing to trust that PDM's authors are well intentioned and didn't intentionally aim to end up with "false advertising" in the first feature the project lists in the README.

Besides, I only look closer look at this because I was talking to one of PEP 582's authors recently, and [LWN][lwn][^1] linked to someone on the internet was claiming that PDM is a solution to Python packaging.

[lwn]: https://lwn.net/SubscriberLink/920132/cb4d6c0f07b54952/

[^1]: Which... in case someone from LWN ends up reading this: I think that was a bad editorial choice.
