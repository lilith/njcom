Date: Apr 1 2013

# Setting up a new rMBP for Ruby development

I've had the same filesystem for roughly 7 years, copying it across 4 hard drives and 2 laptops, and installing 4 new OS versions along the way without a clean install. Both my Mid 2012 17" MBP and my new 15" rMBP have 512GB SDD drives, but according to BlackMagic, the rMBP is 2-4x faster on both reads and writes. 

Needless to say, my copy of OS X is thoroughly unique by this point, and not completely in a good way.

I've decided to document my steps for setting up a new OS X development environment, now that it's much simpler thanks to Homebrew, rbenv, npm, etc.

### 1. Make OS X capable of building software from source code

1. Install XCode from the App Store
2. Open XCode, go to `Preferences -> Downloads -> Components` and install "Command Line Tools". Now you can build from source.

### 2. Install Homebrew. Package managers are required!

	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	brew doctor

If `brew doctor` gives you a clean bill of health, you can continue.

### 3. Install git, awk, wget, and any other command-line tools you need

	brew install git awk wget 

Tip: Dotfiles and profile scripts are hidden by default. Make finder display all files by running 

	defaults write com.apple.Finder AppleShowAllFiles YES

Then alt-clicking the Finder icon and relaunching it. To undo, re-run with "NO" instead of "YES". 

### 4. Install rbenv and ruby

rbenv allows you to have multiple side-by-side installations of Ruby, and lets you set the preferred version via hint files or environment variables.

We'll install rbenv, tell it to run by default on all bash terminals, and then install `ruby-build` so we can install ruby versions through rbenv (although you're free to install ruby in any manner with rbenv, this is just the easiest).

	brew install rbenv
	echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
	brew install ruby-build

Now let's see what versions of ruby are available. As I write this, 2.0.0-p0 and 1.9.3-p392 are the main versions you'll need.

	rbenv install -l

	rbenv install 1.9.3-p392
	rbenv install 2.0.0-p0
	rbenv rehash


Now you can install bunder for both versions of ruby

	rbenv shell 1.9.3-p392
	gem install bundler

	rbenv shell 2.0.0-p0
	gem install bundler
	rbenv rehash

	rbenv shell --unset

To set a certain project to use a certain ruby version, change to that directory in Terminal and run


	rbenv versions # Show installed and active versions

	rbenv local 1.9.3-p327 # Set the ruby verson for this folder by creating a `.ruby-version` file.


Now you can run `bundle install` on your projects. Just remember to run `rbenv rehash` after any new package installation which includes binaries. Running `rbenv rehash` tells it to ensure binstubs are configured for all currently installed ruby versions.

**Unlike RVM, rbenv doesn't rewrite your shell commands, so you need to type 'bundle exec ' in front of any gem binaries you call from the command line. I suggest making an alias:**

	alias b='bundle exec'


### 5. Install Node and NPM (Node Package Manager)

	brew install node
	curl https://npmjs.org/install.sh | sh
	export NODE_PATH="/usr/local/lib/node"
	export PATH="/usr/local/share/npm/bin:$PATH"

Now you can install node packages, like bower (yet another package manager - but for assets):

	sudo npm install -g bower


### 6. Install Python


Homebrew can install Python2 and Python3 side-by-side

	brew install python

	brew install python3

They include `pip` and `pip3` respectively, so you're set to install all the packages you want; here's a few that are commonly needed:

	pip install numpy ipython scipy pil

Some (like wxWidgets, OpenCV, and PngCrush) are platform-level libraries with python bindings. These you install with `brew`.

	brew install --python wxmac --devel

	sudo ln -s /usr/local/Cellar/wxmac/2.9.4.0/lib/python2.7/site-packages/wx /Library/Python/2.7/site-packages/wx

	brew install opencv
	brew install pngcrush


Important: Do not use `brew install` from an active virtualenv environment; open a fresh terminal session first.



#### "Part 2: Apps" will arrive... when you see it.









