---
title: "Revamping my personal website"
tags: ["meta"]
summary: "Hopping onto the hype train and migrating to Hugo."
---

I made an impulse decision to rework my personal website, to port it
over to [Hugo], and away from [Jekyll]. This is now built using the
[recently-viral] [PaperMod] theme for Hugo.

I took the opportunity to refresh/revamp the site structure, which
worked out pretty well too.

Some notes from doing this transition:

- Hugo's separation of content vs templates is GREAT.
- Hugo's documentation is exceedingly beginner unfriendly. :(
- Hugo's support for `{date}-{slug}.md` files is... difficult to
  discover.
- `redirect_from` == `aliases`
- I couldn't search Hugo's changelog, which makes it difficult to figure
  out whether something you're reading from a 2018 issue was removed.
- "Why is this like this" and other variants were spoken 17 times, in
  the span of 5 hours.

[papermod]: https://adityatelange.github.io/hugo-PaperMod/
[recently-viral]: https://adityatelange.me/blog/papermod-went-viral/
[hugo]: https://gohugo.io/
[jekyll]: https://jekyllrb.com/
