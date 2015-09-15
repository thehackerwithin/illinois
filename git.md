Git Version Control Overview
=========================

A primer on using git version control by creating an upcoming meeting post.

## Install Git

###Mac/Windows/Linux
[Download](https://git-scm.com/downloads)

###Ubuntu

~~~
$ sudo apt-get install git
~~~

## Create account on Github

[Github](https://github.com/)

###Fork the THW-Illinois code on Github:

[THW-Illinois](https://github.com/thehackerwithin/illinois)

---

## Get code from Github

Grab your forked version

~~~
$ git clone https://github.com/aaronta/illinois.git

$ cd illinois
~~~

In order to access the "gh-pages," where the website files are located, you need to make the branch with the content visible:

~~~
$ git branch

* master
~~~

This only shows the "master" branch but the "-a" flag shows all available. The only one we are interested in is the "remotes/origin/gh-pages"

~~~
$ git branch -a

* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/gh-pages
  remotes/origin/master
~~~

Now add it to the visible branches and *checkout* gh-pages:

~~~
$ git checkout -b gh-pages origin/gh-pages

$ git branch

* gh-pages
  master

~~~

Now you have the entire THW-IL code for the website!

###Have a look around:

~~~
$ ls

404.md		README.md		_config_dev.yml		_includes
_people		atom.xml		favicon.ico			index.md
people.md	sitemap.xml		upcoming.md			LICENSE
_config.yml	_drafts			_layouts			_posts
css			images			js					previous.md
tags.md

$ ls _posts/
~~~

###Create a post

Copy a draft for a post for your up-coming talk:

~~~
$ cp _drafts/2999-12-31-template-upcoming.md _posts/2015-09-09-git-part-2.md
~~~

###Edit the post

~~~
$ vim _posts/2015-09-09-git-part-2.md

$ git status

On branch gh-pages
Your branch is up-to-date with 'origin/gh-pages'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        _posts/2015-09-09-git-part-2.md

nothing added to commit but untracked files present (use "git add" to track)
~~~

The output from git is verbose but can be shorted

~~~
$ git status -s
?? _posts/2015-09-09-git-part-2.md
~~~

Now commit the changes locally:

~~~
$ git add _posts/2015-09-09-git-part-2.md

$ git status -s

$ git commit -m "Sept 9: Git part 2"
~~~

If it's your first time running a commit, you will get something like:

~~~
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
~~~

Follow the instructions to update your information:

~~~
$ git config --global user.name "Aaron Anderson"
$ git config --global user.email "aandrsn3@illinois.edu"
$ git commit --amend --reset-author
~~~

The last command will open an editor for you to confirm the update.

###Send to the clouds

Now you can send your changes:

~~~
$ git remote -v

origin  https://github.com/aaronta/illinois.git (fetch)
origin  https://github.com/aaronta/illinois.git (push)

$ git push origin gh-pages

~~~

###Pull Request

Log on to Github account to see your repository and initiate a "**pull request**."

###Get updates

To keep your local repository up-to-date with the main repository you will need to add the main repository to your remote targets:

~~~
$ git remote add thw-il https://github.com/thehackerwithin/illinois.git

$ git remote -v

origin  https://github.com/aaronta/illinois.git (fetch)
origin  https://github.com/aaronta/illinois.git (push)
thw-il  https://github.com/thehackerwithin/illinois.git (fetch)
thw-il  https://github.com/thehackerwithin/illinois.git (push)
~~~

To retrieve the newest updates to the gh-pages branch, first make sure you are on the gh-pages branch:

~~~
$ git branch

  gh-pages
* master

$ git checkout gh-pages

$ git pull thw-il gh-pages
~~~


---

#Challenge

Create a personal page for yourself to add to the group's website.

~~~
$ ls _people

$ cp _people/Aaron-Anderson.md _people/Steve-Wozniak.md

$ vim _people/Steve-Wozniak.md
~~~

Edit, commit, and push!

##Congratulations!

You just contributed to an open source project!
