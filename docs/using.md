# GsDevKit_stones

- [Introduction](docs.md)
- [Getting Started](gettingStarted.md)
- [Using GsDevKit_stones](using.md)

# Using GsDevKit_stones

## Housekeeping
Regardless of whether you install GemStone with out without GsDevKit_stones, it will need a place to store its lock files. So let's start by setting that up.

In a terminal...
```
sudo mkdir -p /opt/gemstone
sudo chmod oug+rwx /opt/gemstone
sudo mkdir /opt/gemstone/locks
sudo chmod oug+rwx /opt/gemstone/locks

```
Note: This shouldn't have to be done by us. Pull request submitted.

## Terminology & Usage

### Registry
In the introduction I mentioned that you can teach GsDevKit_stones how you work with GemStone. By this I mean letting it know where on disk you keep certain things including:
- where to install versions of GemStone
- where to install your stones
- where your projects keep their git repos
- the set of git repos used by your projects

So GsDevKit_stones can keep track of this information, it maintains registries.

You give each registry a name so you can easily identify it in a way that makes sense to you. 

There is also the concept of a "default" registry which is named after your machines hostname. The hostname of my development machine is `jupiter.local` so my default registry will be named "jupiter.local"

You can tell GsDevKit_stones to use any of your named registries as the default by setting the environment variable:
```
STONES_DEFAULT_REGISTRY=myRegistryName
```

The handy thing about using a default registry, is that you don't have to explicitly tell GsDevKit_stones commands which registry you're referring to each time. That saves a little typing.

**So, why do I want a registry?**

Developing for complex systems is well... complex. Everyone has their own opinion on how to setup their development environment that makes sense to them. GsDevKit_stones didn't want to prescribe a fixed set of rules, rather it wanted to honour each developer's reasoning and "go with the flow."

To achieve this, it needed to know some stuff like where find and install things – that's part of what the Registry does.

Once you've told the registry how you work, GsDevKit_stones can perform complex tasks for you with simple commands.

**How should I use the registry?**

You may put all your configuration into one registry, or create a registry per project, or maybe per type of project. Once you become familiar with the registry, you'll find your preferred method of working with it.

For me, I'm typically working on a few projects at once, some professionally and some personally. I like to create a registry per project. I do this so I can easily separate in my mind what I'm working on at any particular time.

This may seem like overkill, since I install all versions of GemStone in the same location, and in some cases, the git repos I'm using between projects are also stored in one location. So many of my registries have duplicated information. I'm ok with this.

In any case, we always start with one registry, and only add another when we see an advantage.

Let's have a play with registries. In a terminal...
```
createRegistry.solo
```
This creates the default registry. Let's see what was created. In a terminal...
```
registryReport.solo
```
It will answer something like...
```
{
	#jupiter.local : '$STONES_DATA_HOME/gsdevkit_stones/registry/jupiter.local.ston'
}
```
...only with your hostname.

Let's create another registry and give it the name "myProject". In a terminal...
```
createRegistry.solo myProject
```
...and run the report...
```
registryReport.solo
```
It will answer something like...
```
{
	#jupiter.local : '$STONES_DATA_HOME/gsdevkit_stones/registry/jupiter.local.ston'
	#myProject : '$STONES_DATA_HOME/gsdevkit_stones/registry/myProject.ston'
}
```



### Product Directory

This is the directory where versions of GemStone are installed. You may have 10 projects you are working on that all use the same version of GemStone, You only want to install the GemStone product once

