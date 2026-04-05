---
title: "Organising the Python Packaging Summit at PyCon US 2024"
tags: ["Python Packaging", "PyCon", "Organising"]
---

I've been involved with the Python Packaging Summit at PyCon US since it's intended inaugural year: the wonderful 2020. Working through my list from [Volunteer Responsibility Amnesty Day](https://www.volunteeramnestyday.net/), I'm writing down some of the things I've learned about organising this specific summit to help future organisers -- whether it's me or someone else.

For the bulk of this post, I'll use "we"/"us" refers to the organisers of the summit.

## The rough summary

### Preparation

As you might expect, this is where the bulk of the work for conducting the summit happens.

#### PyCon US announcement

The trigger for the packaging summit discussions tend to be PyCon US getting announced with specific dates. At that point, one of us goes "oh, we need to do the summit too" and starts that conversation somewhere relevant. For 2024, it started with a message on the "PyCon US 2023 Packaging Summit" chat:

![@pradyunsg on Discord asking "Ahoy mates! Interested in doing this again in 2024?" at 18/01/2024 18:48](./images/packaging-summit-24-start.png)

In previous, it started on discuss.python.org's Packaging Category. Once the relevant people are on board, a communication channel is established and... we start talking about the actual summit organising.

#### Figuring things out

One of the first steps is reaching out to the PyCon US staff/organisers and ask for the room and equipment we'll need. This is usually a straightforward process, because the PyCon US organisers are great.

##### What the summit room looks like

We've basically settled on what we need in the room that we request for:

- A room for ~30-50 people, round tables
- A projector for slides and a podium for speakers
- Two hand-held microphones for the discussions

We've also gotten a desk for the 3-4 organisers to sit at near the front, even though we didn't ask for it and it's been great to have it. We should probably explicitly ask for it in the future.

##### When the summit happens

When the summit should happen during the conference is something we've had to figure out each time. In 2023 and 2024, we've settled on doing the summit during talk days of PyCon US (the "main" conference days). This is because the relevant people are most likely to be at the event during those days. I expect that this will continue to be the case in the future.

There is a fun caveat that comes with this: we're not the only summit that came to this conclusion, so we've had to coordinate with other summits to not overlap the timings which can be tricky given that we end up with 10+ people involved in this often across separate communication channels and based on some established relationships/commonality. It helps that we end up with someone or the other having the same Slack with another summit's organiser or their Discord handle or (oh no, he's gonna say it) their email address. Alternatively, we can pre-empt all of this by being the first to announce our summit's timings but... we're usually the last to figure out our timings. :)

The specific timing is something that ends up being figured out over a few days of back-and-forth, and it's usually a bit stressful (it's time-sensitive since we want to communicate to people to make plans to be at PyCon but we can't announce until we know enough to provide details that won't change).

Once we have these details, we add a page to the PyCon US website with the summit's details.

As concrete lessons learnt around this:

- Reach out to the PyCon US organisers within a week.
- Figure out the summit's date+time as quickly as possible.
  - Make this predictable -- I like the idea of doing it on the same day and time every year as the 2024 summit (~4 hours in the afternoon of day 2 of talks)

#### Gathering interest and topics

One of the things we need to do once the PyCon US page is live is set up a couple of Google forms:

- A form for people to express interest in attending the summit
- A form for people to propose topics for discussion

These were modelled partially after PyCon US Language Summit's forms which are also split like this.

The first form is necessary since the goal of the summit is to have discussions amongst stakeholders. This inherently means that the organisers may have to make some difficult calls about who we want in the room later in the process and, pragmatically, we know we've had to say no to individuals because there isn't space in the room. Making the room bigger isn't an option because we want to keep the summit as a discussion-focused event and discussions get extremely unwieldy in large groups (we're already pushing limits with 30+ people discussions).

The second form is what sets the agenda for the summit. The organisers will have to go through the proposals and figure out what can fit into the available time. This can be a bit of a challenge because we have to balance the number of topics with the time we have, the need to have breaks (sorry about forgetting about this in the past) and the inherent limitations of a 20-ish minute discussion. This hasn't been particularly difficult for the past couple of years and it's something that we're mindful of.

The forms are basically solved problems at this point -- in 2023 and 2024, we've basically copied the previous year's forms, updated the details, and done minor touch-ups to phrasing of various bits.

#### Announcing the event

Once the PyCon US page is live, we publish a post that needs to go out on discuss.python.org's Packaging > Announcements category. The post serves two purposes: announcing the event and serving as a call to action to fill out our forms! Like the forms, we reuse the previous year's post with minor touch-ups.

One thing we've struggled with in 2023/2024 has been the getting this announcement out quickly. We've ended up announcing this somewhat later than we'd like because the organisers get busy with other things and we don't have a "hard" deadline to force us to get this done. It's usually been a single organiser who ends up pushing this forward (and it's usually not me).

As concrete lessons learnt around this:

- Announcing earlier is better.

#### Promoting the event

We tend to only signal boost the announcement in limited spaces. This tends to be organisers' personal social media accounts and the PyPA Discord.

The reasoning for this is that we want to this in as all the places that people engaged in the Python packaging ecosystem are likely to see it. Notably, we don't want to be posting about this from, for example, the PyCon US account because that's got a wrong audience for the event.

As concrete lessons learnt around this:

- It's important to not advertise in the wrong places.

#### Setting the event agenda and structure

This is usually the part where the event starts taking concrete shape. The organisers review the forms as they're being filled out and discuss a bit about the responses. Once their deadline has passed, we go through all the proposals and figure out what we can fit into the time we have.

Notably, this is when we have to figure out the exact structure of the summit along with the topics for discussion. In 2023, this ended up in the decision to have two 4 hour sessions over the course of two days with each session packed with topics (in part because we had a lot of topics!). In 2024, we decided to have a single 4-hour block -- ~2 hours for discussions and a ~2 hours for an unconference with a break in the middle.

There's a bunch of difficult judgement calls that the organisers have to make about what topics would be a good fit and which attendees would be a good fit. This is usually informed by the context that the organisers' have about the topics and the individuals -- both from the forms and from the organisers' experience as members of the community. It's a good idea for the organisers to prepare backup topics here as well -- we do not want to be dominating the agenda with our own topics but we should prepare for potential speakers saying no or being unable to attend for some reason.

We tend to do these asynchronously over text chat, discussing the trade-offs and making these decisions. This has worked well but can be a bit slow since we all get busy and we have slipped on the committed timeline for this in the past because of this.

Lessons learnt around this:

- Schedule some sort of specific time/meeting to discuss the forms' responses.
- Having backup topics for discussions is a good idea.
- Having a mix of structured and unstructured time is good.
- Humans need breaks and keeping focus for 4 hours is basically impossible with a group this big.

#### Respond to attendees, speakers and everyone who filled the forms

Once the agenda is set, we respond to everyone who filled out the forms.

This is usually a bunch of emails that goes out to specific audiences wherein all receivers are BCC'd and all organisers are CC'd:

- "you're in" style email to everyone we'll have space for.
- "sorry, we can't fit you in" style email to everyone we won't have space for.
- "your topic is in" style email to everyone who'll have to present their topic.

Once we have confirmations from the topic presenters, we update the PyCon US website with the summit's agenda.

As concrete lessons learnt around this:

- Respond to everyone who filled out the forms, including rejections within the same "session" of work.
- Communicate when the agenda is finalised.

At this point, we're basically done with the preparation for the summit.

### At PyCon US

#### Before the event

We tend to get people approaching the organisers at PyCon US to ask about the summit, with the question: "I forgot to fill out the form, can I still attend?". The answer is usually "yes, if we have room" for nearly everyone who asks. So far, we've not had a situation where there's two people competing for the last spot in the room but we're mindful that this might happen.

We tend to go look at the room before the summit starts. This is usually a quick check to make sure that we know the size and set up of the room.

#### Running the event

The event has a clear structure and a schedule at this point and it's mostly a case of running through the motions and actually engaging in the thing we've spent so much time preparing for.

There are two important things we do at this summit:

- One of the organisers serves as Master of Ceremonies (MC) during the summit. This person ends up being the person with the microphone, introducing speakers/topics, moderating discussions and keeping the summit running on time.
- There are extensive notes taken during the summit. This is usually done in a shared document that's open to all attendees. This is a great way to ensure that the discussions are captured and that people who couldn't attend can know has what happened -- something extremely important since this isn't a room for making final decisions. This is primarily championed by one of the organisers who isn't the MC.

I was the MC in 2023 and 2024 and have thoroughly enjoyed taking on that role.

As concrete lessons learnt around this:

- Continue taking extensive notes
- Have a prepared slide deck / index cards for the MC.
  - Include a QR code to the shared notes document.
  - Include a slide for each "planned" discussion topic.
- Announce the summit's date + time as quickly as possible (once details are finalized).

#### After the event

Immediately after the event, the organisers tend to do some sort of vibe-check with attendees and organisers also talk to each other about how they're feeling about the event. This is some immediate feedback and it'll be somewhere on the spectrum of "this was shit" to "this was amazing".

The summit is happening in the middle of PyCon US though, which means that there isn't really a lot of time after to take a breather -- there's a PyCon happening! For me personally, PyCon US is a major social event on my calendar where I get to talk to grab a meal with my friends, colleagues and cool people -- all of whom are coming from very different parts of the world.

As a concrete lesson learnt around this:

- Consider formally collecting event feedback (either a Google form or with something like https://www.mentimeter.com/ during the event).
  - Notably, about the discussion topics and the structure of the summit.

### After PyCon US

Usually after PyCon US, we put up a post on discuss.python.org with our thanks and notes. In 2024, this had to wait on a few edits to add data from various sources into the notes before sharing widely.

There's usually a bunch of excitement and activity around this time about things that were discussed in the summit so it's possible that some topics have already had additional discussions / topics created on discuss.python.org and we make an effort to cross-link them.

## A bundle of thoughts

[TODO]
