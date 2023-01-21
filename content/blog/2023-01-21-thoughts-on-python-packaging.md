---
title: "Thoughts on the Python packaging ecosystem"
tags: ["Python Packaging"]
modified: 2021-01-21
---

My response to the discussion topic posed in [Python Packaging Strategy Discussion Part 1][motivating-topic] had become quite long, so I decided to move it to write a blog post instead. This post then started absorbing various draft posts I've had on this topic since this blog was started, morphing to include my broader thoughts on where we are today.

_Note_: I've updated this to cover an aspect of the recent LWN article on the topic as well.

## TL;DR

This post is a bit long, so here's the key points I'm making:

- The Python packaging ecosystem _unintentionally_ became the type of competitive space that it is today.
- The community needs to make an explicit decision if it should continue operating under the model that led to status quo.
- Pick from N different tools that do N different things is a good model.
- Pick from N ~equivalent choices is a _really bad_ user experience.
- Picking a default doesn't make other approaches illegal.
- Communication about the Python packaging ecosystem is fragmented, and we should improve that.

---

<details>

<summary>My experience around Python Packaging</summary>

At the time of writing:

- I'm a maintainer on pip, installer, resolvelib, packaging, flit, Spack (allegedly), sphinx-theme-builder, pyproject-hooks, and more.
- I'm a moderator on PyPI.
- I've contributed in varying manners to setuptools, wheel, warehouse (i.e. PyPI), pipenv, Poetry, packaging.python.org, build, and more.
- As a maintainer on pip, I'm a member of the Python Packaging Authority (PyPA).
- I've co-authored multiple [Packaging PEPs](https://peps.python.org/topic/packaging/), including the [PyPA's Governance Model](https://www.python.org/dev/peps/pep-0609/).
- I've been the PEP-Delegate on multiple Packaging PEPs, trusted to make decisions on behalf of the community.

</details>

<!-- Python packaging has quite a reputation of being ridiculously difficult to get right, understand and work with. It would not be a stretch to say that the packaging and distribution story for Python is one of the main sources of pain for many users. -->

## Python users are _not_ software engineers

Many of the users who write Python code are _not_ primarily full-time software engineers or "developers". They are not particularly interested in this aspect of their job. They're using Python as a tool to get their job done. They're not interested in the details of how the tool works, or even how complicated things are under the hood.

As Thea (Stargirl) Flowers [said recently](https://hachyderm.io/@stargirl/109697057391904145):

> The reason there are so many tools for managing Python dependencies is because Python is not a monoculture and different folks need different things.

## User expectations for a "default" workflow

A class of users expect a packaging tool that provides a cohesive experience (like npm (NodeJS), cargo (Rust), gem (Ruby), pub (Dart), dotnet (C#/.NET), etc) -- a single tool that provides a build system, dependency manager, publishing, running project-specific tasks/scripts, etc. I've referred to this as "workflow tool" in this post.

Certain other ecosystems have this in their "default" tool, providing a much more streamlined experience for users. I have first hand experience of this for NodeJS and Rust, where they have a single tool that users invoke to do the majority of their work:

- create a new project.
- install/manage dependencies.
- run their project w/ those dependencies.
- test their project.
- publish their project.
- more?!

Today, each of these pieces is a separate tool for Python and doesn't have a strict 1:1 mapping to the "best practices"/"secure" workflows. This is at odds with the expectations that these users have. This class of users, by and large, want consolidation and a single-tool experience.

We know that this class of users exists because we have:

- a number of popular tools that are attempting to provide this experience.
- results from user surveys we've done[^i-asked-for-packaging-in-surveys] [clearly indicate this](https://drive.google.com/file/d/1U5d5SiXLVkzDpS0i1dJIA4Hu5Qg704T9/view) as well.
- had multiple community members say this in multiple ways, across multiple channels.

## Flexibility leads to complexity

Brian Skinn [said recently](https://discuss.python.org/t/packaging-vision-and-strategy-next-steps/21513/8?u=pradyunsg):

> You can package darn near anything in Python, even though it may take figuring out a complicated three-step-and-a-hop process to get there… and I suspect that this has been part of what’s enabled Python to grow into its “second best programming language for every task” aphorism.

I think there's some truth to that. ["An Overview of Packaging for Python"][pypug-overview] on packaging.python.org expresses a similar tone as well:

> Packaging in Python has a bit of a reputation for being a bumpy ride. This impression is mostly a byproduct of Python’s versatility.

I do want to contrast this with the fact that the overview page takes over 3000 words, to provide the "high-level" overview for how one can approach packaging a Python project. It doesn't even touch the specifics of configuration or provide any specific workflow guidance with that much digital ink.

The bumpy ride reputation is not misplaced, and is the most frequent user complaint (more on this later). There are consequences to the degree of flexibility afforded to users by the Python packaging ecosystem:

- every Python project has to make multiple decisions about how they want to do certain things
- every Python user has to make choices for how they wanna manage their Python installation and workflow tools
- it leads to multiple ways to achieve the same thing when trying to use Python packaging tools, with some of these ways being subtly wrong
- it leads to a larger surface area of behaviours of existing/established tools that users rely upon.
- it makes it much more likely that new users hit edge cases and paper-cuts, that more-experienced developers won't hit because they have adapted their workflow to avoid certain failure modes over time.

The flexibility is _great_ to have when you need it but, without a "default" workflow, it serves to create more user confusion than it resolves. It contributes to the bumpy ride reputation and to the perceived complexity.

## Placing the Python packaging ecosystem on the community spectrum

When I was reading ["The community spectrum: caring to combative" - Insight From Alex Bayley][community-spectrum] on [Sumana Harihareswara's blog](https://www.harihareswara.net/), it flagged something amusing to me. I recommend reading the article, but I'll quote a portion that provides sufficient context for the rest of this post.

> The Competitive Spectrum describes communities as being:
>
> - **Caring**: members are motivated by helping each other.
> - **Collaborative**: members share goals and help each other to achieve them.
> - **Cordial**: members have their own goals which do not conflict with each other.
> - **Competitive**: members share the same goals, and compete against each other to achieve them.
> - **Combative**: members must achieve their goals by preventing others from being doing so.

### PyPA and Conda

Within this spectrum, I think the relationship between Conda and PyPA projects is definitely collaborative.

The two groups of maintainers have worked together to solve problems that affect both groups. Conda packages are often built up from Python packages that are built with PyPA tools. Heck, at the time of writing, [one of](https://github.com/jezdez/) the [founders of the PyPA](https://gist.github.com/jezdez/6222d1ba8b10d734d003492e58041687) currently [sits on the Conda Steering Council](https://github.com/conda-incubator/governance/blob/0fa0e84f690e628fe7a232bb52938409b2fbc1e3/steering.csv?plain=1#L14).

### Python build-backends

The goal of enabling pyproject.toml-based builds[^pyproject-toml-builds] was to move Python packaging from a collaborative (or at least, cordial) model, to a competitive model for the build mechanisms.

The stated goal of PEP 517 is:

> The goal of this PEP is get distutils-sig out of the business of being a gatekeeper for Python build systems. If you want to use distutils, great; if you want to use something else, then that should be easy to do using standardized methods.

Moving to a competitive model for build mechanisms was intended to enable the ecosystem to move away from the "only one way" of building Python packages (the quote is from the Zen of Python) _because_ the [implementation we had of "only one way" was exceedingly difficult to evolve](https://peps.python.org/pep-0517/#abstract).

### Poetry / PDM / Hatch / PyFlow / etc

These tools are firmly in a competitive model. They're competing for users. They're competing to be the "best" solution to the "workflow" problem. They're, arguably, even competing for contributors.

Other than the obvious sign that these tools can't be used together on the same codebase (mostly), this can be seen in other aspects of these projects:

- the way they're marketed/documented -- they have an incentive to invest in this, because they're competing for users and good-looking/flashy documentation is a good way to attract users.
- the way they do community management: some have dedicated community Discord servers, mention $tool-specific ecosystems, have their own $tool plugin ecosystems, etc.
- the way their users advocate for them as the one-true-solution on the internet :)

This competition also leads to incentives for projects to do things like implementing [draft standards that are not accepted or settled](https://github.com/pypa/hatch/commit/fea611be96f79559ecf227d2a68b6dfbf3b3c2ec) and [claims that standards are implemented, even when the implementation does not match the standard][pdm-pep582].

## Unintended competition

In my opinion, ending up with multiple competing workflow tools in the Python ecosystem was not an intentional choice by any individual or group.

While providing alternatives to distutils/setuptools was the intent of pyproject.toml-based build systems, I don't think it was intended nor was there ever consensus that we wanted to end up with an ecosystem of competing tools which _use_ the pyproject.toml-based build system _and_ provide an end-to-end workflow.

I don't see any discussion of such tooling in the corresponding mailing list discussions and the PEPs certainly don't talk about trying to enable building alternative _workflow_-related tooling. There's extensive discussion about the technical design of the final solution and on many aspects of "how to build distribution files", but there's no discussion about how competing workflow tools would be enabled.

Another reason is... well... let's dig into some "history". The Python Packaging Authority has [publicly written goals](https://www.pypa.io/en/latest/future/) for them:

> - Although it’s still being defined, to work towards a “Meta-Packaging” system that:
>   - Clearly delineates the phases of distribution
>   - Allows for multiple interacting tools vs one monolithic tool
>   - Specifically allows for alternative build systems, i.e. a “MetaBuild” system.

These goals were [written in a different "era" of Python packaging](https://github.com/pypa/pypa.io/blob/2ddc43fa4871e83365b8f43da19b7dc573b67ebd/source/future.rst), before PEP 516/517/518 were being debated, when the ecosystem was still in an entirely collaborative/cordial model (on the other side of a combative era[^combative-packaging]), and when the "Python ecosystem" was much smaller than it is today[^stackoverflow-survey].[^pypa-goals-have-not-been-updated]

The intent was to enable the ecosystem to build multiple tools that interacted with each other and allow for alternative build tooling to solve problems that were difficult to solve with distutils/setuptools.

A competitive ecosystem for workflow tooling is an unintended consequence of the pyproject.toml-based build system. The PyPA's focus on standardisation made it easier to build workflow tooling that interacted with other packages, with no mechanisms to check whether these tools are reciprocating on interoperability.

## On existing workflow tools

I expect the most relevant people already know this, but I'll state it explicitly: I have a lot of respect for the work done by the authors and/or maintainers of tooling like Poetry, PDM, Hatch, Pipenv, PyFlow, etc. I think they each, individually, contribute meaningfully and positively to the ecosystem.

The most popular workflow tools for Python handle the underlying details for the user and give them a single unified tool that has `install` / `publish` / `run` commands. They also provide functionality that the "default" tools do not (eg: environment-agnostic lockfiles, automated environment management etc). Serving as an end-to-end tool enables them to trim the scope and define it as they deem appropriate.

Conda also does this to a certain extent, by tying the [environment management and package management together](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) into a single tool, but it also operates on a different level than these tools -- packaging "everything" rather than just Python packages.

### The reasons for the existence of workflow tools

Some/all of the "workflow tools" that exist today because the "default" tooling did not cover more of the user's workflow with a single piece.

- Pipenv's `Pipfile` was [created with the express goal of being for pip](https://github.com/pypa/pip/issues/1795#issuecomment-261661124)[^pipenv-kr].
- Poetry was [created to provide a single config file with a single tool experience, and a better dependency resolution model](https://github.com/python-poetry/poetry/blob/a5d6333f27f261458ba5abe3e30cbf452fa7a10f/README.md#why).
- Hatch was [created as "a productivity tool designed to make your workflow easier and more efficient, while also reducing the number of other tools you need to know."](https://github.com/pypa/hatch/blob/4202965f4a4b1d86e6c7de1224a359217df45314/README.rst).
- PDM was [created as a "Python package manager with PEP 582 support"](https://github.com/pdm-project/pdm/commit/06391eca0bed7b879af1bc84c1c737c99646741e) (which is notable, given that [PDM does not implement PEP 582][pdm-pep582]).

These tools have _all_ now dropped that language from their documentation (or at least evolved it) to reflect that they're now focused on providing a complete and unified experience for the user. This can be seen by the fact that they've all gone ahead and invented their own build-backends, since providing a complete and unified experience requires that the tool also controls how projects are built.

Now, to state the obvious, the folks who created these tools are not fools who like to create work for themselves or enjoy reinventing the wheel. They created because they felt that the existing tooling wasn't meeting their needs _and_ that there was no clear path to improving the pre-existing tooling to meet those needs. Each of these tools solves the problem by making different calls for what the right trade-offs are.

I am certain that it is not possible to create a single "workflow" tool for Python software. What we have today, an ecosystem of tooling where each makes different design choices and technical trade-offs, is a part of why Python is as widespread as it is today. This flexibility and availability of choice is, however, both a blessing and a curse. That's actually a great segue to talk about...

## pip: A privileged player

Today, `pip` is uniquely positioned within in the Python packaging ecosystem. It is the only[^setuptools-is-gonna-stop-shipping] piece of the Python packaging tooling that ships with Python, and is guaranteed[^pip-is-guaranteed] to be installed in every environment. Nearly every Python user[^2022-packaging-survey-pip] who wishes to share code (or use shared code) uses it today, directly or indirectly.

The fact that I've added 3 footnotes in the last paragraph is a symptom of _something_ and I'm not sure if it's a good thing or a bad thing.

## pip: A disadvantaged player

This point is easier to make with an example, let's take lockfiles: it's technically feasible to implement an arbitrary lockfile format in pip, that evolves with pip, in lock-step with it (something of this sort is implemented already in the form of pip-tools).

Given the privileged position that pip has within the ecosystem (i.e. ships with the language), whatever it does would become the de-facto standard and commercial tools/IDEs will add support for that model much quicker (eg: requirements.txt) than something similar from PDM, Poetry, Pipenv etc.

Now, on the face of it, this is a completely different direction from PyPA's model of "interoperability standards through concensus" because, effectively, whatever pip implements would become a de-facto standard for what the ecosystem and tooling supports.

On the other hand, if we focus on designing an interoperability through concensus before implementing functionality in pip, implementing vital workflow improvements is now blocked on an exhaustingly long process of a non-iterative, waterfall-style design process. Further, an interoperable lockfile format also has to try to satisfy needs to tools that use completely different resolution models _even_ semantically incorrect ones[^poetry-resolver].

Taking a slightly iterative approach of "we'll cover the more complicated case later" caused [the last proposal for a lockfile format standard](https://peps.python.org/pep-0665/) to be rejected after months of discussion.

We're in a state where the process for adding new functionality to our default "out of the box" experience is designed to be both very difficult and very "energy" intensive -- leading to it being pretty slow. The reason the default tooling doesn't improve is that making meaningful improvements to it is blocked on trying to cater to all workflows; in ways that alternative tooling is not.

The effect of this is that our "out of the box" experience is always going to be worse than the experience with other tools in the ecosystem. In a competitive ecosystem, is that what we want? Heck, at that point, do we even want to be in a competitive ecosystem?

## On build-backends tied to workflow tools

Hatchling, pdm-backend and poetry-core are all examples of this. Flit/flit-core is another slightly-weaker example of this[^flit-weaker-example]. They each have build-backends that are either (a) tied to a particular workflow tool in some way or (b) promoted along with a workflow tool.

The build backends are all solving the "build a wheel from Python code" problem, but with different user experiences tacked onto them. Building multiple tools that solve the same problem is duplicated effort.

Part of the problem here is that these tools (with the exception of PDM) are not built with interoperability in their design, and these tools have basically little to no incentive to take on the complexities of providing interoperability.

Flit can only be used with flit_core, and `flit build` doesn't build the same artifacts as `python -m build` would.

Hatch is tied to hatchling, and ["it would be an extraordinary amount of effort"][hatchling-coupling] to support using a different build-backend for your project when using Hatch.[^hatchling-hatch]

Poetry has its own dependency specification format, and the corresponding build-backend enables it to build packages that use that format.

PDM is better on this front, in that it has greater backend-agnostic behaviours to it. However, pdm-backend is undergoing a rewrite to ["provide a similar extensible interface to hatchling"][pdm-rewrite].

These were all made possible by the explicit focus of the PyPA on designing an interoperability model -- i.e. Unix-like approach -- which these tools have used to create tool-specific build-backends. :)

While we trying to enforce that one way of building packages/managing dependencies for all Python users is not feasible... having 4 build-backends that all handle pure-Python packages with the same file holding their configuration, while providing slightly different user experiences is _also_ not a good place to be in IMO.

## Pick from N ~equivalent choices is really bad UX

When you package Python software, a user has to make a lot of choices. There are a _lot_, and I do mean a _lot_, of "A vs B" comparisons that you can make when it comes to figuring out the scaffolding for packaging and distributing Python software.

The problem with not making a default recommendation for these largely-inconsequential choices is that it means that _every_ user has to make these choices. Instead of making a choice once and then being able to build upon that as an ecosystem, we keep moving in circles on these topics because we've got two groups now and picking either choice means that the other group is unhappy.

This also leads to the same problems being solved twice -- there's duplicated effort and duplicated documentation. Each project will design their own approach and there's incentive for projects to try to "out-compete" each other by providing more features or by providing better documentation, rather than contributing to improving a common corpus.

This is how, for example, we end up with [packaging.python.org](https://packaging.python.org) not having [a standard structure for declaring metadata that is implemented by ~every build-backend][pyproject-metadata] documented, even though there was _extensive_ documentation for the same in multiple tools' own documentation for months. Each of those tools' authors have had incentives to document it for their users and it was easier to do so in their own documentation where they don't have to worry about the concerns of other tools or "being generic enough".

## "not a PyPA project"

The _only_ reason various Python packaging projects (notably, Poetry and PDM) are not PyPA projects is because they've never asked to become one.

As it stands, the PyPA views itself as a big umbrella. Basically "any established Python packaging project" that asks to be included, will be accepted. If Poetry and PDM ever asked to join, as it stands, there's no version of this timeline where the existing PyPA members say no.

From the discussions I've had, the reasons have ranged from some sense of maintaining control (which doesn't really have [good precedence](https://github.com/pypa/pipenv/issues/607#issuecomment-330878876)), to logistical issues like GitHub Actions queues, as well as a sense of being able to "be successful without the tag".

Also, to say that these tools are "are not participating in the PyPA"[^lwn] is grossly incorrect. PDM's whole [pitch _today_](https://github.com/pdm-project/pdm/blob/c0974672a17be965ddcb0e191d35df08ad0c4b6e/README.md?plain=1#L5) is that it is "A modern Python package and dependency manager supporting the latest PEP standards". Poetry's authors somewhat regularly interact with the interoperability discussions and its original author has even co-authored a PEP.

## On the Python Packaging Authority

I think there's a need to reconsider what the Python Packaging Authority should be trying to do and what it even is. We've been cruising on the premise that we're maintaining foundational tools and designing for interoperability is the "right" model for the Python packaging ecosystem. I'm not sure that's the case.

Between the user surveys, having a $work role where I'm directly influencing user workflows beyond the installer, spending time helping out with scientific Python tooling and with [pyOpenSci](https://www.pyopensci.org/), and the discussions in the strategy thread... I'm starting to think that our current approach is not working and is harmful[^unintentionally] unintentionally. Each projects' maintainers effectively decides on different aspects of the the overall UX for. Each project acts as its own project. There is no broader guiding "roadmap". Making decisions about how the default tooling of the ecosystem works is "not appropriate" for our process to hashing out technical design proposals. There is no "blessed" tool and yet there are defaults, things that ship with the Python standard library and PyPA recommendations.

I'm not sure what the right answer is, but I don't think we're in a good place right now. Here's where we are:

- even co-operating tools are viewed as being in competition with each other
- interoperability standards that are written but are not enforced
  - on the principle of "consenting adults" or "be permissive in what you accept"
  - for backwards compatibility reasons
  - because "we should trust the XYZ authors to do the right thing"
  - difficult to answer basic questions like "what can a source distribution file be named" because the standard says one thing while the tools do something else because "the author prefers that"
  - implemented and publicized as features in tools, despite not being something that is "accepted"
  - absolutely ignored by tool authors "because it's not a priority"
- duplicated effort because multiple tools are competing
- users are confused about what to use, what is deprecated, what is the "right" way to do things etc and there is no authoritative answer
- say that PEPs are not documentation but, also, go read this PEP for the details on how this feature works because that's the only place we wrote it.
- no clear answer for step 0 questions like where should I put by .py files relative to my pyproject.toml file
- a lack of willingness to draw a line in the sand and say "this is the way things are done" because "what if someone finds a better way in the future"
- we don't pick one of two ~equivalent choices because "they're both valid workflows"
- there is **no** agreed upon direction for the ecosystem

## We don't need _more_ "generic" build-backends today

With [setuptools gaining pyproject.toml configuration support][setuptools-pyproject] and [a standard structure for declaring metadata that is implemented by ~every build-backend][pyproject-metadata], there isn't a significant difference between the various tools.

There are only so many ways to construct a `.zip` file containing a bunch of pure-Python files + metadata. The only real difference is in the user experience, and the user experience is largely determined by the tooling that invokes the build-backend.

Building more build-backends that are intended to be extended (beyond what we already have, between `hatchling`, `pdm-backend` and `setuptools`) feels unnecessary to me; and we might already have one too many options for this.

## On pip as a workflow tool

Donald Stufft has [said](https://github.com/pypa/pip/issues/6041#issuecomment-516470124) on pip's issue tracker:

> All that being said, I think trying to follow the "unix philosophy" is a mistake and is actually a pretty poor UX. Yea a lot of nerds grok it because we've caused enough collective brain damage by being forced to use it over time and it works better for the typical unix tools because they generally just come preinstalled. I think it would just add additional complexity to an already confusing landscape of tools for our end users.

And, Paul Moore has [said](https://discuss.python.org/t/adding-a-non-metadata-installer-only-dev-dependencies-table-to-pyproject-toml/20106/10?u=pradyunsg):

> At some point, I do think that pip needs to make a firm decision on whether it’s a development workflow tool or just an installer

And, I think that now is the time to make that decision.

The [recent strategy discussion][motivating-topic] is sprawling and has largely operated with the assumption that pip is not something that can become a "workflow tool". I think that's an incorrect assumption.

Personally, I've wanted pip to cover more aspects of the user's workflow [since before PEP 517 was implemented](https://github.com/pypa/pip/issues/5407#issuecomment-389621303), which was around the time [I started getting involved in Python](http://pradyunsg.me/gsoc-2017/05/05/green-light/)[^dsa-lol]. Improving the "base" tool to cover more use cases is **not** a bad idea -- it's helpful for most user personas. Outside of blessing another tool, this is the path of least resistance that we can take to getting to a better state.

Do I think there's a significant amount of work needed for making pip into a workflow tool?

Yes.

Do I think that the amount of collective energy that's gone into Poetry/Hatch/Pipenv/PDM development, collectively, would have made more than a meaningful dent at this issue?

Yes.

Do I think that, at this point, blessing another tool is a good idea?

Maybe. We've built a competitive ecosystem, and I don't think we can just "pick one" of the "new things" and expect that to be the end of it.

Did we ever have sufficient buy-in + capacity to do this with pip, along with contributor experiences that would facilitate this?

No. That's been a part of the problem -- we've made it fairly tractable to "build your own" in a sandbox that lets you ignore the need to support entire swaths of workflows, and that's something you can't compete with easily for contributor experience. And, when the alternative is "spend a few months trying to implement something in a 'legacy' codebase, while catering to needs that you don't have, also convince a bunch of people with limited availability that your idea is a good one and wait for them to review what you wrote", it's not surprising that we end up with a bunch of "new things" and have multiple groups building multiple workflow tools.

We _still_ don't have agreement that this is the direction that we, as a community, want pip to go.

## Centralized user-facing communication channel

There's no single place where users can go to get information about the Python packaging ecosystem -- either on how it's evolving or what the functional best-practices are _today_. We either (a) don't have them documented or (b) don't have a good approach to communicating about this to end users.

There's a cost to this.

LWN [recently](https://lwn.net/SubscriberLink/920132/cb4d6c0f07b54952/) directed readers to a blog post that claims that the strategy discussion is evidence for that, implies that there's "ivory towers of packaging tool maintainers", that "half of the discussion participants did not even bother reading what the people think" based on a misunderstanding of how the discussions have occurred[^discourse-link-counts] and that the Python Packaging User survey happened in a vaccum (it was [extensively](https://discuss.python.org/t/rfc-survey-to-help-define-a-python-packaging-vision-and-strategy/15658) [discussed](https://discuss.python.org/t/your-feedback-required-python-packaging-user-survey/18070) before the strategy discussion even started).

That blog post has captured the current discourse around Python packaging and set the tone: one painting the volunteers who currently maintain the tooling as being "vs reality".

This is exactly the sort of thing that happens when there's no authoritative voice in the space: the vacuum will be filled by someone else on the internet, who will likely be making sensational claims that aren't being validated.

## On formal UX analysis

This has been mentioned in multiple places and has come up in the past in other contexts around Python Packaging.

I think doing "full UX analysis" is going to be forbiddingly difficult. Don't get me wrong: a complete UX review of the Python Packaging ecosystem would be _awesome_ as part of a coordinated effort to make progress on the fundamental problems here.

Something like this is unlikely to happen because there's a _really_ motivated UX expert with a _lot_ of volunteer time to donate. We'd basically need an enormous cheque for work that's... "understand Python packaging really well and figure out a path to making it better". That's a difficult thing to tell a funder to throw money at.

Notably, there's a lot of stakeholders here: the easiest "persona" to identify is the maintainers of the tools themselves. After that, it starts to become fuzzy quickly. There's redistributors, end users, Linux OS distros, Linux-specific non-OS package managers, cross-platform distributions, direct users, corporate users who have their own internal packaging systems, or like astronomers, students, statisticians, business analysts, and more.

Breaking the UX problem into a smaller piece, like a single point from the [dimensions we could unify][dimensions], makes this a much more meaningfully sized piece for seeking funding toward. Even then, it'll still probably only be available to be funded by the larger wallets and likely need to be a part of a project that has some other deliverables.

## Acknowledgements

I'd like to thank the following people for reviewing drafts of this post at various stages and providing valuable feedback: Donald Stufft, Kushal Das, and Pavithra Eswaramoorthy.

Also, I would've appreciated if the discourse on this wasn't moving along at the speed that it's been moving after [I publicly committed to writing this][my-interjecting-comment]. And, yes, I'm aware that some of the things I've said here are conclusions that been reached by the broader group on that thread.

Finally, I do have more thoughts; especially on how to get to a better place, but ~6k words is about as long as I want to go here.

[my-interjecting-comment]: https://discuss.python.org/t/python-packaging-strategy-discussion-part-1/22420/16?u=pradyunsg
[dimensions]: https://discuss.python.org/t/python-packaging-strategy-discussion-part-1/22420/16?u=pradyunsg
[motivating-topic]: https://discuss.python.org/t/python-packaging-strategy-discussion-part-1/22420?u=pradyunsg
[community-spectrum]: https://www.harihareswara.net/posts/2022/the-community-spectrum-caring-to-combative-insight-from-alex-bayley/
[pyproject-metadata]: https://packaging.python.org/en/latest/specifications/declaring-project-metadata/
[hatchling-coupling]: https://github.com/pypa/hatch/issues/507
[setuptools-pyproject]: https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html
[pypug-overview]: https://packaging.python.org/en/latest/overview/
[pdm-rewrite]: https://discuss.python.org/t/python-packaging-strategy-discussion-part-1/22420/141?u=pradyunsg
[pdm-pep582]: https://pradyunsg.me/blog/2023/01/21/pdm-does-not-implement-pep-582/
[packaging-in-2021-py-dev-survey]: https://lp.jetbrains.com/python-developers-survey-2021/#PythonPackaging
[2022-py-pack-survey]: https://drive.google.com/file/d/1U5d5SiXLVkzDpS0i1dJIA4Hu5Qg704T9/view

[^setuptools-is-gonna-stop-shipping]: [Setuptools is not gonna installed by default in a `venv`, starting with Python 3.12](https://github.com/python/cpython/pull/101039) and only shipped with Python because it was needed by pip, prior to pyproject.toml-based builds being a thing.
[^pyproject-toml-builds]: That's what the cool kids say now -- it's a bit of a mouthful, but it's more accurate than PEP 517, and better than PEP 517/518/621/660-based build systems. ;)
[^stackoverflow-survey]: [The 2013/2014/2015 StackOverflow survey results](https://insights.stackoverflow.com/survey/2015#tech-lang) are a fun trip down technology history. PHP is more popular than Python. "Node.js and AngularJS are busting out". "Java is still the #1 server side language".
[^dsa-lol]: If you clicked the link and think like me: yes, I checked, I did reasonably well in my Data Structures and Algorithms course.
[^flit-weaker-example]: I [may be biased](https://pradyunsg.me/about/#flit) but it's worth noting that Flit is part of _why_ PEP 517 happened.
[^i-asked-for-packaging-in-surveys]: I'm _very_ happy that we have done this.

    I'd initially discussed the idea of surveying Python Packaging users to Shamika, [the Python Packaging Project Manager](https://pyfound.blogspot.com/2021/04/the-psf-is-hiring-python-packaging.html), in late 2021, in an video call with her.

    I'm very grateful for the work that Shamika and many others have put toward this; the 2021 Python Developer Survey included a [full section on Python Packaging][packaging-in-2021-py-dev-survey] (some are questions that I'd suggested!) and there's been a dedicated [2022 Python Packaging Survey][2022-py-pack-survey] which has some extremely valuable data.

[^hatchling-hatch]:
    Clarified on the [PyPA Discord](https://discord.com/channels/803025117553754132/964878415914213436/1063852982459957248) as:

    > "basically adding a dependency on the PEP 517 library and having a conditional that if the build backend is not Hatchling then use that"

    That doesn't seem like an "extraordinary" amount of work to me, but I'm not familiar with the Hatch codebase and I am willing to trust @ofek's judgement here.

[^2022-packaging-survey-pip]: ["90% of developers report they use pip to install Python packages"](https://lp.jetbrains.com/python-developers-survey-2021/#text-530) and even those who just use Conda/Poetry/PDM etc will end up using pip under the hood.
[^pypa-goals-have-not-been-updated]: The PyPA goals should really be updated, once the dust has settled around the whole strategy discussion.
[^pip-is-guaranteed]: Yes, I know about Linux distros that break things. Yes, I know that you have a `--without-pip` (or equivalent) flag on venv/virtualenv. They're both edge cases in this context, _not_ the norm.
[^poetry-resolver]:
    Poetry's dependency resolver and lockfile operates under the assumption that _all_ files for a package + version are going to have the exact same metadata. While it is a choice that Poetry can make, because it's "opinionated", it's not something that other tools can do.

    Notably, it's an incorrect assumption; baked in because PyPI's rough-draft-became-production implementation of metadata handling treated metadata from the first wheel uploaded to PyPI as the releases' metadata.

[^unintentionally]: unintentionally. I don't think anyone came out thinking "We should design for a bad UX" but here we are.
[^pipenv-kr]: Before an individual with a [controlling attitude](https://github.com/pypa/pipenv/issues/607#issuecomment-330878876) got involved and made some [overzealous marketing claims](https://github.com/pypa/pipfile/pull/138), and... [then this was published](https://vorpus.org/blog/why-im-not-collaborating-with-kenneth-reitz/).
[^combative-packaging]: I'm referring to distutils2 / setuptools / distribute.
[^lwn]: I'm absolutely looking at LWN's summary here. More on this later. In case someone from LWN ends up reading this: I think that was a bad editorial choice.
[^discourse-link-counts]: Those links are in "Summary of discussions" -- discussions that most participants have already participated in. Plus, I'm pretty sure Discourse doesn't count middle-clicks.
