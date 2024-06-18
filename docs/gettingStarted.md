# GsDevKit_stones

- [Introduction](docs.md)
- [Getting Started](gettingStarted.md)
- [Using GsDevKit_stones](using.md)

# Getting started

If you’re here, it means you're a developer planning to deploy projects using a GemStone server.

## Prerequisites 

1. You are running a unix based system like macOS 12 or later, or Ubuntu 20 or later.
2. You have git installed and your credentials set up for ssh access.  [Follow this guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

Note: It's also possible to run GemStone on Windows via [WSL](https://ubuntu.com/desktop/wsl) with ubuntu.

## Installing GsDevKit_stones

### Summary / TLDR;
1. [Create the install location](#create-the-install-location)
2. [Clone the project from GitHub](#clone-the-project-from-github)
3. [Run the install script](#run-the-install-script)
4. [Add environment variables to your profile](#add-environment-variables-to-your-profile)

Commands used in this section (for those who don't like to read)

```
export STONES_HOME=/opt/GsDevKit
sudo mkdir -p $STONES_HOME/git
sudo chown -R $USER $STONES_HOME
cd $STONES_HOME/git
git clone git@github.com:GsDevKit/GsDevKit_stones.git
cd $STONES_HOME/git/GsDevKit_stones/bin
./install.sh
```
NOTE: The above commands don't include how to [add environment variables to your profile](#add-environment-variables-to-your-profile)

## Step by Step / RTFM

### Create the install location

Decide where you are going to install GsDevKit_stones.

When you install GsDevKit_stones, it will also install another project called superDoit. For those familiar with Smalltalk, "DoIt" is typically how you tell your Smalltalk IDE to execute code. superDoit extends this concept to the command line allowing you to write and run shell scripts in GemStone Smalltalk… amazing.

I like to install projects in the same location on my development machine as they will be installed on my production server. This consistency ensures my production machines work  the same as my development machine. Also, just in case I’m lazy and hard code path names into code, they wont break when moved into production.

Since the GsDevKit_stones and superDoit projects will be cloned from Github, we need a place to put them. I like to put them in a “git” directory. Naming the directory “git” directory reminds me that everything in it is a git project.

For these reasons, I typically install all things GsDevKit in the directory `/opt/GsDevKit`, and clone GsDevKit_stones in the directory `/opt/GsDevKit/git`

In a terminal...
```
export STONES_HOME=/opt/GsDevKit

sudo mkdir -p $STONES_HOME/git
sudo chown -R $USER $STONES_HOME
```
### Clone the project from GitHub

In the same terminal...
```
cd $STONES_HOME/git
git clone git@github.com:GsDevKit/GsDevKit_stones.git
```

### Run the install script
In the same terminal...
```
cd $STONES_HOME/git/GsDevKit_stones/bin
./install.sh

```

### Add environment variables to your profile

- For Bash (common on Ubuntu and macOS 13 or earlier), use ~/.bash_profile.
- For Zsh (common on macOS 14 or later), use ~/.zprofile.

In the same terminal...
```
export MY_PROFILE=~/.zprofile
touch $MY_PROFILE
cat - >> $MY_PROFILE << EOF
# GsDevKit_stones
export STONES_HOME="$STONES_HOME"
export STONES_DATA_HOME="\$STONES_HOME/data"
export PATH="\$STONES_HOME/git/superDoit/bin:\$STONES_HOME/git/GsDevKit_stones/bin:\$PATH"
EOF
```
You may have noticed that we snuck in another environment variable `STONES_DATA_HOME`. This is where GsDevKit_stones will keep it's registry information (more on the registry later). You can put it anywhere you like, but as I mentioned, I'm putting ALL GsDevKit_stones related stuff in one place. Once you have a better understanding of the [Registry](using.md#registry), it may make more sense to you to locate `STONES_DATA_HOME` somewhere else.

Close your terminal and open a new one. Enter...
```
versionReport.solo
```

You should get back something like...
```
--------------------
Gem Version Report for 'gs64stone'
--------------------
nodeName
	 = jupiter.local
osName
	 = Darwin
processId
	 = 5196
processorCount
	 = 16
gsBuildSerialNum
	 = 2023-08-24T14:12:58-07:00 87d4894f48fb88b6589e392e200ea1a60e1a143b
gsRelease
	 = 3.7.0
osRelease
	 = 23.4.0
cpuKind
	 = arm64
gsBuildArchitecture
	 = Darwin (macOS)
gsVersion
	 = 3.7.0
osVersion
	 = Darwin Kernel Version 23.4.0: Wed Feb 21 21:44:54 PST 2024; root:xnu-10063.101.15~2/RELEASE_ARM64_T6031
gsBuildDate
	 = Thu Aug 24 14:21:20 2023 (branch 3.7.0)
gsBuildType
	 = FAST
cpuArchitecture
	 = arm64
rowanVersion
	 = 2.5.0
rowanLoadedCommitId
	 = 2997fe3fc
--------------------
```

Everything is up and running! If you don't get this, review the steps to identify any missed actions.

It's time to start [using GsDevKit_stones](using.md)
