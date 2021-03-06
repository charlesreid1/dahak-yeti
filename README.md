# dahak-yeti 

dahak-yeti is a repository containing dotfiles and initailization scripts for dahak worker nodes.

[dahak](https://github.com/dahak-metagenomics/dahak/) is a package for delivering workflows that use
open-source tools to identify organisms in complex non-clinical metagenomes.

yeti is a nickname for the beefy AWS nodes that are required to run dahak workflows. 

![Screen shot after installing](/img/screen.png)

## Cloud Deployment 

To use dahak-yeti on an AWS node, you can pass along the cloud init script
in `cloud_init/` to prepare the node for dahak workflows.

This script will:
* Install packages and run various system admin tasks
* Create a `dahak` user
* Install dotfiles and scripts for `dahak` user

## By Hand Deployment

Installing by hand is a three-step process:
* Install git
* Run sudo init script
* Run user init script

### Step 1: Install Git

To install git:

```
apt-get update && apt-get install -y git
```

Now you can check out a copy of the repo:

```
git clone https://github.com/charlesreid1/dahak-yeti.git
cd dahak-yeti/
```

### Step 2: Run Sudo Init Script

To run the sudo init script, which calls several other scripts, run:

```
# as the sudo user:
$PWD/tasks_sudo/sudo_init.sh
```

### Step 3: Run User Init Script

To run the user init script, run:

```
# as the regular dahak user, 
$PWD/tasks_user/user_init.sh

# or if you are still sudo,
sudo -H -i -u dahak $PWD/tasks_user/user_init.sh
```

## Using the Dotfiles

The dotfiles are installed for the regular user on  the yeti node.
These dotfiles make it easy to define an environment, either for 
all users (by changing the dotfiles in the repo) or for an individual
user (using site-specific dotfiles).

The `$PATH` is set in `.bash_profile`

The prompt is set in `.bash_prompt`

The aliases are set in `.aliases`

To set your own aliases, source your own dotfiles, or otherwise
insert steps into the dotfiles initialization process, use 
the `~/.extras` file.

To set your git credentials, add the following to the `~/.extras` file:

```
# Git credentials
# Not in the repository
# This prevents people from using incorrect github credentials
GIT_AUTHOR_NAME="<<< your name here >>>"
GIT_AUTHOR_EMAIL="<<< your email here >>>"

GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

Note that if you are pushing to Github, you should add the private key
from your AWS node (which is located at `$HOME/.ssh/id_rsa.pub`) to 
your list of authorized public keys in your Github account settings page.




