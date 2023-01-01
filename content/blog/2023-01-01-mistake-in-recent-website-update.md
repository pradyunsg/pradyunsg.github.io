---
title: A mistake in a recent website update
summary: "A false claim was made on the about page for a few days."
---

## What I messed up

On Dec 27th 2022 ~9pm UTC, I [published an update][bad-commit] to the "about"
page on this website that (wrongly) claimed:

> My work has been recognised by the Python Software Foundation, and I have been
> awarded the PSF Community Service Award in 2020.

I haven't received the [PSF Community Service Award]. It wasn't mentioned in the
listing below this sentence, of the various awards I've received and the
community work I've involved in.

This stayed up for roughly 4 days, until Dec 31st 2022 ~6pm UTC, when I [noticed
it and removed it][remove-commit][^footnote1].

[psf community service award]:
  https://www.python.org/community/awards/psf-awards/
[remove-commit]:
  https://github.com/pradyunsg/pradyunsg.github.io/commit/74cbf8659461221ee30dca6c133f0604b98695fa

## How this happened

I recently [updated][update-commit] various pages on this website. I also
updated the about page, to use a nicer design, data model and layout.

[update-commit]:
  https://github.com/pradyunsg/pradyunsg.github.io/commit/5d3577220759dcf9cbded1e5303ca0464abdd805

This sentence was a part of a multi-sentence suggestion I had created using [a
large language model][chatgpt], similarly to how I'd come up with sentences for
some of other other sections on the page. I had pasted this specific suggestion
into the document with the intent of removing this sentence and using the rest
of it. I, however, stepped away from the computer before doing so.

I came back to this a few days later and, without looking carefully, committed
the whole thing and published it before closing the editor window.

[bad-commit]:
  https://github.com/pradyunsg/pradyunsg.github.io/commit/0eabd336d0a47f7c5d969e19d6f7fcd2a6d01918

## What I'm doing about it

I don't think anyone noticed this mistake except for me, so this might've just
been [a "victimless crime"](https://en.wikipedia.org/wiki/Victimless_crime).
However, I tend to hold myself to a high standard when it comes representing my
own work accurately, and this doesn't hold up to that.

There isn't much I can do about this now, except to apologise for the mistake
and document the fact that I'd made this mistake -- which is what this post is.

[^footnote1]:
    The context around why my initial reaction was "LOL" is that I'd just read
    <https://arxiv.org/abs/2211.03622>.

[chatgpt]: https://openai.com/blog/chatgpt/
