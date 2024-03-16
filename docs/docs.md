# GsDevKit_stones

- [Introduction](docs.md)
- [Getting Started](gettingStarted.md)
- [Using GsDevKit_stones](using.md)

# Introduction


#### Forward by Jupiter Jones

I wasn’t asked to write this forward, I do not work for GemTalk Systems, I’m confident in saying they probably share none of my opinions (which puts them in good company), and I’m using the payment-free-license version of GemStone. 

That said, GemStone is so good that I can't help feeling I owe them years of my life which would have been lost to \<insert almost any language other than Smalltalk here> and \<insert your favourite database here>.

Bottom line, this look at GsDevKit_stones is a token of appreciation to the team at GemTalk Systems, with a special callout to Dale Henrich for his unbounded generosity in helping the Open Source Community get their hands dirty with what is arguably the most powerful pure object virtual machine mankind has ever created.

Much love,

JJ


# Background
GemStone is an extremely powerful and flexible set of tools that can scale to handle many thousands of terrabytes of data and simultaneous users.

So, configuring, optimising and administering it can be an occupation all of its own.

That’s where GsDevKit_stones comes in. It will help you get up and running quickly, and simplify many of the day to day tasks.

## Some things GsDevKit_stones can do

- Download and Install versions of GemStone .
You can have many versions of GemStone installed and running at once which comes in really handy for testing out new code, upgrading systems to new versions, or supporting old projects that have been running for years
- Download and help manage git repositories for your projects.
- Create and delete “stones” (ahhh that’s why they call it that) More on stones later.
- Start and stop the processes that form a GemStone system.
- Provide an IDE for developers
- Run your tests
- Backup and restore
- Create snapshots
- Help upgrade your systems from one version of GemStone to the next
- Help with Continuous Integration (CI)

That covers about 95% of what we do as developers. So for most of us, GsDevKit_stones gives us the power and commercial advantage that GemStone offers, without the need for a bunch of highly skilled hardware, deployment, and database experts on hand.

That said, if you have complex systems with massive amounts of data and a huge user base, you’ll most definitely want to consult with all those skilled techs to get your production system design just right.

## Rowan
You can’t talk about GsDevKit_stones without talking about Rowan.

Smalltalk developers have been using a source code packaging system called Monticello for well over a decade, and a tool called Metacello for managing those packages. They did a great job, but as projects became more capable and complex, cracks started appearing that will likely never be resolved without a complete rethink of how Monticello works.

So the crazy kids at GemTalk Systems decided to action that rethink and start working on the first new packaging system that Smalltalk has seen since last century. It’s called Rowan, and no matter what version of Smalltalk you use, you’re likely to be hearing a lot more about it in the future.

All you need to know about Rowan right now, is that it encompasses your projects' metadata, and is a system to load your source code into GemStone, and save your changes back to disk.

## Stones
Lastly, I said I’d mention “stones” again, so here it is… 

GemStone is the name of the product, and with it you run “gems” which are essentially the virtual machines and “stones” which are essentially disk based memory images shared by the virtual machines. 

You can kinda think of a “stone” like you think of a database, although it’s far more powerful than that.

If you look at running processes for GemStone you will see things like:

```
88062   ??  S     17:50.36 gem
88060   ??  Ss     0:36.29 stoned
```

These processes are the gem virtual machine, and the stone daemon.

You can rest assured that once your machine is “stoned”, everything will be smooth sailing.

So let's [get started](gettingStarted.md)
