# Lab 0: Installs or Flight Checklist

# Task

Download tools for automation and DevOps with AWS (AWS CLI, Python) as well as tools for development (Node, Python) and containerization (Docker).

# Walk-Through

If you would like to attempt the task, then skip the walk-through and go for the task directly. However, if you need a little bit more hand holding or you would like to look up some of the commands or code or settings, then follow the walk-through.

## AWS CLI Installation

Check for Python. Make sure you have 2.6+ or 3.6+. You can use pip (Python package manager) to install AWS CLI.

```bash
phyton --version
pip --version
pip install awscli
```

Python at least 2.6.5 or 3.x (recommended), see here: <http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html>. At <https://www.python.org/downloads/> you can download Python for your OS.


## Other AWS CLI Installations

* [Install the AWS CLI with Homebrew](http://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html#awscli-install-osx-homebrew) - for macOS
* [Install the AWS CLI Using the Bundled Installer (Linux, macOS, or Unix)](http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-bundle.html) - just download, unzip and execute

## Verify AWS CLI

Run the following command to verify AWS CLI installation and its version (1+ is ok):

```bash
aws --version
```

## Node and npm Installations

Simply go to <https://nodejs.org>, find version 6 (or 8 - LTS which is long-term support) and download it. npm comes with Node—no extra needed.

## Other tools

Open the links to download and install other tools:

* [Docker](https://www.docker.com) deamon/engine - advanced if we have time ([instructions](https://docs.docker.com/engine/installation))

Article on [Node.js in Containers Using Docker](https://webapplog.com/node-docker).

## Good to have tools

* [Git](https://git-scm.com) mostly for code deploys and Elastic Beanstalk
* Code editor [Atom](https://atom.io) or [VS code](https://code.visualstudio.com)
* [CURL](https://curl.haxx.se/download.html) and [PuTTY](http://www.putty.org) (for Windows)
