+++
title = "What's up with bugs.python.org?"
tags = ["CPython", "b.p.o"]
+++

bugs.python.org is the issue tracker for CPython. "bpo", as it is commonly referenced, is where implementation bugs, smaller feature requests, and documentation issues are tracked as part of Python's development.

[PEP 581] proposes sunsetting bugs.python.org, in favor of GitHub issues. "Why not focus on improving Roundup / bpo?" section made me wonder: What is needed to improve Roundup / bpo? This blog post is my attempt at summarizing the state of bpo and how it could be improving in the future, based on a discussion with folks maintaining bpo.

I won't go into whether PEP 581 or PEP 595 is a better idea -- that's something for the CPython core developers to decide on.

## What is that tracker?

Broadly, bpo is an instance of [Roundup], that is hosted by the PSF.

> Roundup is a simple-to-use and -install issue-tracking system with command-line, web and e-mail interfaces. It is based on the winning design from Ka-Ping Yee in the Software Carpentry “Track” design competition.

By design, it is an extremely customizable platform. Roundup has a "core" that can run multiple issue trackers. Each of these issue trackers can contain customizations in the HTML/CSS and extensions for functionality that are specific to them.

When CPython moved to using Roundup, both projects were using subversion for version control. Since then, CPython moved to Mercurial (Roundup followed soon) and now CPython is on Git.

## How is it all working?

The PSF-hosted Roundup, is actually a fork of Roundup maintained by a few folks. The fork was created for adding functionality that made it better for bpo, when the initial transition what made. There are still some functionality improvement patches today (more on this further below).

PSF-hosted Roundup, runs 3 issue trackers:

- https://bugs.python.org (or b.p.o)
- https://bugs.jython.org
- https://issues.roundup-tracker.org

[All the relevant repositories of the PSF][psf-bpo-bitbucket] are in Mercurial, and hosted on BitBucket currently.

## Where are we headed?

The maintainers of bpo want to switch to using upstream Roundup, instead of our PSF fork. To that end, most of the functionality improvement patches made in the fork have been ported upstream. There is only one major thing that's not been integrated upstream (yet!) -- GitHub integrations built as part of the GitHub migration of CPython source code.

There's an upcoming Roundup 2 release (_maybe_ Q1 2020) -- adding a new REST API, Python 3 support, a responsive UI and more. These would address some of the major concerns with Roundup powering bpo today. There is a plan to host a read-only test instance of Roundup 2 alpha/beta/rcs "soon", for exploring new functionality and usability.

Broadly, from what I can tell, the plan of action is:

1. Finalize the GitHub login patch for Roundup.
2. Port the GitHub integrations to upstream Roundup.
3. Set up the test tracker, for bugs.python.org on Roundup 2.
4. Wait for Roundup 2 release.
5. Start running bpo on a regular Roundup 2. (AKA get rid of the PSF's fork)
6. Move the instance code and templates, to GitHub.

Steps 3 and 6 aren't strictly blocked on the steps before them, but this is probably the easiest order if we're doing things sequentially. Given that Step 6 has to happen before 1 June 2020 [^1], it is reasonable to assume this would all get done by then.

Once the Roundup 2 transition is completed, the documentation of the bpo instance would be improved (how it works, what the various files/folders in the repository do and so on). Along with Roundup 2's REST API, this should significantly reduce the barrier to contribute to bpo or to build enhancements around it.

Many thanks to Ezio Melotti for indulging in a very insightful conversation and for helping me write this post.

[roundup]: https://roundup-tracker.org/
[pep 581]: https://www.python.org/dev/peps/pep-0581/
[psf-bpo-bitbucket]: https://bitbucket.org/account/user/python/projects/BPO
[bitbucket-hg-sunset]: https://bitbucket.org/blog/sunsetting-mercurial-support-in-bitbucket

[^1]: BitBucket will [sunset Mercurial support][bitbucket-hg-sunset] and remove Mercurial repositories on June 1, 2020.
