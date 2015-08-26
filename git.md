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

$ git remote -v

origin  https://github.com/aaronta/illinois.git (fetch)
origin  https://github.com/aaronta/illinois.git (push)

$ git pull origin gh-pages

$ git checkout gh-pages
~~~

Now you have the entire THW-IL code for the website!

###Have a look around:

~~~
$ ls

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
$ git push origin gh-pages

~~~

###Pull Request

Log on to Github account to see your repository and initiate a "**pull request**."

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
