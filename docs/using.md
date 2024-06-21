# GsDevKit_stones

- [Introduction](docs.md)
- [Getting Started](gettingStarted.md)
- [Using GsDevKit_stones](using.md)

# Using GsDevKit_stones

## Terminology & Usage

- [Registry](#registry)
- [Product Directory](#product-directory)
- [Project Directory](#project-directory)

### Registry
In the introduction I mentioned that you can teach GsDevKit_stones how you work with GemStone. By this I mean letting it know where you keep certain things including:
- where to install versions of GemStone
- where to install your stones
- where you store the git repos used by your projects

To keep track of this information, GsDevKit_stones uses one or more registries.

Each registry has a name so you can easily identify it in a way that makes sense to you. 

There is also the concept of a "default" registry which is named after your machines hostname. The hostname of my development machine is `jupiter.local` so my default registry will be named "jupiter.local"

The handy thing about using a default registry, is that you don't have to explicitly tell GsDevKit_stones commands which registry you're referring to each time. That saves a little typing.

You can tell GsDevKit_stones to use any of your named registries as the default, by setting the environment variable:
```
STONES_DEFAULT_REGISTRY=myRegistryName
```

If this environment variable is not set, then the registry named after your host machine will be the default.

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


### Project Directory

This is the equivalent of the old $ROWAN_PROJECTS_HOME.

The project directory is where Rowan stores cloned repos that may be cloned while installing your project. See [Project repo structure](#project-repo-structure) for one example of how to use Project Directory.



### Project repo structure

The following is just rough notes…

I hope what you get from this, is the idea that there's no __correct__ way to do this. Do it in exactly the way that suits your team and project requirements. This is just what I do with what I’ve learned so far. My focus is on “least amount of stuff to configure or remember”. I welcome any suggestions on how to simplify without losing flexibility. 

So the thinking goes like this…

You work on a bunch of different “**projects**”. Typically those projects are under git  management. You clone your project into $MYPROJECT

I create directories in $MYPROJECT, for code:

```	$MYPROJECT/src```

This includes a __BaselineOfMYPROJECT__ for loading into Pharo

The rowan spec:

```	$MYPROJECT/rowan/specs/MYPROJECT.ston``` for loading into gemstone

If I’m working on a seaside project I create the root for serving files to the web: ```	$MYPROJECT/www_root```

and for nginx config:

```	$MYPROJECT/nginx```

Then a bunch of configuration and other projects specific stuff.

I then create directories for stones (make sure /stones is included in .gitIgnore): ```$MYPROJECT/stones```

…for the versions of gemstone installed for this project (make sure /gemstone is included in .gitIgnore): ```$MYPROJECT/gemstone```

Having these here just gives the flexibility use .gitignore to choose to place project specific configurations (or anything) under git management.

Finally I create a directory to store other cloned repos that may be cloned by rowan while installing your project. This is the equivalent of the old $ROWAN_PROJECTS_HOME: ```$MYPROJECT/git```

It's the /git directory that the registry needs to know about in registry/projectsHome
