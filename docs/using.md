# GsDevKit_stones

- [Introduction](docs.md)
- [Getting Started](gettingStarted.md)
- [Using GsDevKit_stones](using.md)

# Using GsDevKit_stones

## Housekeeping
Regardless of whether you install GemStone with or without GsDevKit_stones, it will need a place to store its lock files. So let's start by setting that up.

In a terminal...
```shell
sudo mkdir -p /opt/gemstone
sudo chmod oug+rwx /opt/gemstone
sudo mkdir /opt/gemstone/locks
sudo chmod oug+rwx /opt/gemstone/locks

```
Note: This shouldn't have to be done by us. Pull request submitted.

## Terminology & Usage

### Registry
In the introduction I mentioned that you can teach GsDevKit_stones how you work with GemStone. By this I mean letting it know where you keep certain things including:
- where to install versions of GemStone
- where to install your stones
- where your projects keep their git repos

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

To achieve this, it needs to know some stuff like where find and install things.

Once it knows how you work, GsDevKit_stones can perform complex tasks for you with simple commands.

**How should I use the registry?**

You may put your setup into one registry, or create a registry per project, or maybe per type of project. Once you become familiar with the registry, you'll find your preferred method of working with it.

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
...only with your hostname. You'll probably notice this looks like a .json file and you'd be almost right. It's a .ston file. STON stands for Smalltalk Object Notation and is an extension of the JSON format that brings some useful Smalltalk additions. I won't go into STON here beyond this brief description. More information is [here](https://github.com/svenvc/ston/blob/master/ston-paper.md).

You'll also notice that next to your hostname is a path to another .ston file. That's where your registry is located. Each command that alters the registry typically outputs the registry .ston file to the screen. You would have seen this when your ran `createRegistry.solo`

Let's create another registry and give it the name "myProject". In a terminal...
```
createRegistry.solo myProject
```
You'll see the new registry .ston file output in the terminal. Let's look at the report again. In a terminal...
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
To see all the information in your registry .ston file, use the registryReport.solo script and tell it which registry you want the report on. In a terminal... (Remember to change the hostname to match yours)
```
registryReport.solo --registry=jupiter.local
```

For now, let's delete the "myProject" registry and work with the default. In a terminal...
```
deleteRegistry.solo myProject
```

To see all the information in a registry, use the registryReport.solo script and tell it which registry you're interested in. In a terminal... (Remember to change the hostname to match yours)
```
registryReport.solo --registry=jupiter.local
```

### Product Directory

This is the directory where versions of GemStone are installed. You may have 10 projects you are working on that all use the same version of GemStone. You only want to install the GemStone product once.

In the [create the install location](gettingStarted.md#create-the-install-location) section of getting started, I planned to put all my GsDevKit_stones related stuff in `/opt/GsDevKit` so I will continue that here by installing my versions of GemStone in the directory `/opt/GsDevKit/gemstone`

So let's tell the registry where we want to install GemStone. In a terminal...
```
registerProductDirectory.solo /opt/GsDevKit/gemstone
```
We haven't specified a registry using `--registry=myRegistryName` so it will use the default registry.

Again, you'll see your registry .ston file and you'll see that the product directory has been added.

Let's install a version of GemStone. In this case we will install version 3.7.1. 
In a terminal...
```
downloadGemStone.solo 3.7.1
```
We haven't specified a registry using `--registry=myRegistryName` so it will use the default registry.

You will now have version 3.7.1 of GemStone installed in the product directory you specified.

