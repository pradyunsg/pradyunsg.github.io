# On automated code formatting

I've had the discussion about adopting code formatters in a project
quite a few times now. There's a bunch of thing I've learnt, so it's
likely valuable to put down my thoughts into words I can read later.

## It is not about the code

This was confusing to me at first, but the main benefits of having an
automated code formatter is not the fact that it formats code
consistently. There will always be cases where an automated code
formatter will produce code that will look worse than how a human would
format it.

That's actually expected. Using an automated code formatters is about
improving your workflows, and not about improving how the code looks.

## "Avoiding" code style debates

This seemed like an obvious point. If we adopt a code formatting tool,
we'll be able to avoid debates about code style!

The important word in the sentences above is "if". This is a trap, I've
fallen for a few times now. When someone proposed adopting a code
formatter, it will inevitably be a discussion about code style.

These discussions are opinion-based and take a *lot* of energy out of
everyone participating. Wasn't this all about avoiding discussions
about code formatting? It is, which is why it is important to avoid
going into a line-by-line review of how the code changes until *after*
everyone agrees on what the value of automating code style is.

## Offloading mental work to automation

Automated code formatting tools will always format a chunk of code in
the exact same way. This does enable you to write horribly formatted
code, and then depend on the tool to make it look significantly better.
It won't be perfect, but you can usually get 90% of the way there.

### Workflow improvements

As the name suggests, 

Because a lot of their value isn't something that shows up in git commits or the codebase, but rather in the workflows.

Automated code formatters are more for your workflows, and less about
the actual code.

> I'm really, really sick of having to argue against IMO bad choices like this, where no-one is even coming up with good counter-arguments to my points
> [snip]
> all that happens is that people argue more, but they argue about the rules the tool applies, and they don't even argue based on merit, but rather on the basis that "it's easier to do what the tool implements than to think about what's best".

Here's an attempted summary: 

I think what's happening is that, you're thinking that I'm arguing for what the tool does. I'm usually not.

I also disagree with some of the choices these tools make. Black has a laundry list here (like how it does function call containing a single list that's too long for the line) of things that annoy me a little bit every time I see them.

Yes, you do get slightly "worse" code; that in certain cases, everyone agrees is worse.


However, I'm OK with slightly worse code, because I've enjoyed the benefits that these tools bring to my workflows and thinking processes in exchange. It's a compromise, in exchange for something valuable: I won't have to think as much about writing/styling the code when I'm working on something with intense thought. I can trust that the tooling will catch my bad choices/missed opportunities and fix/flag them. This trust means that in those intense-thinking moments, I can convert my thoughts into the code without needing to worry about these things.

This assessment is, of course, different for different people and that's 100% OK.

I've genuinely enjoyed not having to worry about this stuff. There's code that no one else will ever look at where I used black, simply because I didn't want to be thinking too hard about how to format things. What did I get? Not spending time to get things to look _exactly_ like I wanted, but instead close-enough with no cognitive load due to it.

And that's without the part where you're getting consistent looking code from _everyone else_, which is super nice. IDK how to express it, but it is really really nice to not have to be pedantic about these things in code reviews, and have a tool do this unemotionally.

> equally we have the option to not user the tool.

Oh, 100%. To me, we should do this if _anyone_ of us thinks the "cost" substantially greater than the "value" provided by the tool.

Some of the newer languages have avoided this whole debate, by
having a standard code formatter, that ships with your compiler. These
are great!

## Shout outs

- [This answer][se-stackexchange] on the Software Engineering
  StackExchange website is where I originally picked up 2 of the points
  I've made here.
- [ThoughtWorks][thoughtworks-blip] has a well phrased "blip" about
  this topic.

[se-stackexchange]: https://softwareengineering.stackexchange.com/a/189323/83274
[thoughtworks-blip]: https://www.thoughtworks.com/radar/techniques/opinionated-and-automated-code-formatting
