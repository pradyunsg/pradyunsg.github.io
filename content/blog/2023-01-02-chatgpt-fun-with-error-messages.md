---
title: Excellent error messages from command line tools, according to ChatGPT
tags: ["ChatGPT", "Quick ones"]
---

In late Dec 2022, I played around with [ChatGPT] in an evening.

Since it was on the top of my mind[^currently-working-on], I decided try to
nudge ChatGPT into the direction of giving me a useful answer about error
message design for command line tools.[^1]

> **Now, tell me what an excellent error message from a command line tool should
> contain.**
>
> An excellent error message from a command line tool should contain the
> following elements:
>
> 1. A clear and concise description of the error: The error message should
>    explain what went wrong and why the command failed.
>
> 1. A suggestion for how to fix the error: If possible, the error message
>    should provide a suggestion for how the user can fix the error and try the
>    command again.
>
> 1. The error code: It can be helpful to include an error code or other
>    identifier that can be used to look up more information about the error.
>
> 1. The context in which the error occurred: Providing information about the
>    context in which the error occurred (e.g., the command that was being run,
>    the arguments that were provided) can help the user understand the root
>    cause of the error and how to fix it.
>
> 1. A link to additional resources: If there are additional resources that can
>    help the user understand and fix the error (e.g., documentation, forums),
>    it can be helpful to include a link to these resources in the error
>    message.

I'll admit this was mildly impressive on the first skim-read. Looking closer, it
became clear that the response is actually flawed in multiple ways and the model
made some assumptions that are not _completely_ accurate.

Overall, this is amusing enough to me that I decided to document it here.

## Further reading

- https://abnormalsecurity.com/blog/double-edged-sword-of-chatgpt
- https://stackoverflow.com/help/gpt-policy
- https://twitter.com/emilymbender/status/1603039301864157184
- https://mastodon.social/@Gargron/109469945447325370 ;)

[^1]:
    I'm intentionally _not_ publishing the full context of the conversation --
    you'll have to wait until I release the library to read the final form of
    the blurb I used with ChatGPT as a prompt here. :)

[^currently-working-on]:
    I am currently working on a library to help achieve a great UX around errors
    (with a focus on command line tools), based off of my work around [`pip`'s
    error message improvements][pip-error-issue], [`sphinx-theme-builder` error
    message design][stb-errors] and all the reading/research I've been doing on
    this topic

[chatgpt]: https://openai.com/blog/chatgpt/
