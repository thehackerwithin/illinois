Git Version Control Overview
=========================

A primer on using git version control by creating an upcoming meeting post.

## Install Git

### Mac/Windows/Linux
[Download](https://git-scm.com/downloads)

### Ubuntu

~~~
$ sudo apt-get install git
~~~

## Create account on Github

[Github](https://github.com/)

### Fork the THW-Illinois code on Github:

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

### Have a look around:

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

### Create a post

Copy a draft for a post for your up-coming talk:

~~~
$ cp _drafts/2999-12-31-template-upcoming.md _posts/2015-09-09-git-part-2.md
~~~

### Edit the post

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

If you have the right dependencies installed you can inspect your web-site
change by running

~~~
jekyll serve
~~~

and navigating [here](http://localhost:4000/posts/git-part2)

If satisfied with your changes, commit the changes locally:

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

### Send to the clouds

Now you can send your changes:

~~~
$ git remote -v

origin  https://github.com/aaronta/illinois.git (fetch)
origin  https://github.com/aaronta/illinois.git (push)

$ git push origin gh-pages

~~~

### Pull Request

Log on to Github account to see your repository and initiate a "**pull request**."

Look at Github's help section on [comparing across branches](https://help.github.com/articles/comparing-commits-across-time/#comparing-across-forks).

### Get updates

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

# Challenge

Create a personal page for yourself to add to the group's website.

~~~
$ ls _people

$ cp _people/Aaron-Anderson.md _people/Steve-Wozniak.md

$ vim _people/Steve-Wozniak.md
~~~

Edit, commit, and push!

## Congratulations!

You just contributed to an open source project!

# Version control workflow

[Collaborating workflow](http://nvie.com/posts/a-successful-git-branching-model/)

## Example: Sympy development - Feature addition

Steps:

- Create issue on the [Sympy project repository](https://github.com/sympy/sympy)
  outlining desired feature
- Checkout local branch for feature development (may reference issue number, say
  issue #1234)

~~~
git checkout -b fancy_integration_routine_1234
~~~

- When finished, push to your Sympy fork, and then issue a pull request to the
  master branch of the Sympy project with a tag for the issue it addresses
    - An example PR title might be: "Added fancy integration routine (closes
      #1234)"

Note that this development workflow is essentially identical to the one we used
for the web-site. However, let's say that your feature development takes a long
time, during which the Sympy project is being continually developed. Perhaps
some changes were added to the master branch that you want to be able to use in
your feature. How to incorporate these additions? A couple of options:

~~~
git fetch upstream
git branch -f master upstream/master
git merge master
~~~

This is the "safe" development option. Commit history is always
preserved. However, if feature development goes on for a long time and many
upstream merge commits are made, the history becomes a bit polluted and it
becomes harder for final PR reviewers to navigate. The second option is:

~~~
git fetch upstream
git branch -f master upstream/master
git rebase -i master
~~~

This will make your development history look "nice" and linear; there are no
extraneous merge commits from upstream in your feature's development
history. However, there is some danger to performing a rebase. The rebased
commits will all be brand new commits with new commit hashes; essentially you
are re-writing history. If the commits to be rebased are already public and
there's a chance others are working off of them, rebase should be avoided. More
discussion of general merge and rebase concepts can be found
[here](https://www.atlassian.com/git/tutorials/merging-vs-rebasing/conceptual-overview)

Different projects have different policies regarding merge vs rebase. Even
different version control systems have varying levels of rebase
support. Out of the box, `Mercurial` does not have any rebase support, rather it
must be loaded as an extension. Additionally, for changing public history,
`Mercurial` doesn't have an analog for `git push -f`. (But as we stated earlier,
changing public history is generally a bad idea). In summary, before
contributing to an individual project, it's advisable to make yourself familiar
with that project's policy.

# Some final useful commands

If you ever do something disastrous to your git controlled repository, say some
bad invocation of `find -delete`, have no fear. Simply perform

~~~
git reset --hard HEAD
~~~

This will restore your repository to the state of it's last commit
message. Variations of the `git reset` command can also be useful for moving
around commits. For instance if you wanted to go back two commits, you could
perform:

~~~
git reset --hard HEAD~2
~~~

or

~~~
git reset --hard <commit-hash>
~~~

Git will warn you that you're in a detached HEAD state (e.g. there are no branch
pointers in-line with HEAD). Moving around commits in this way can be useful
when changes in one repository break functionality in a dependent repository,
and you want to quickly revert to a commit in the former repo that allows the
latter repo to function (with good testing and communication between repository
maintainers this should never happen...but it's happened to me).

For viewing commit and branch history, my favorite command is

~~~
git log --oneline --decorate --graph --all
~~~

Additionally, if you want to only know the commits that have touched a certain
file or sub-directory, you can add the `-- <file>` option at the end of
`git log`. For example, you can run this in the THW website repository (on
branch gh-pages):

~~~
git log --oneline --decorate --graph --all -- _posts
~~~

Now go out and conquer the world one open source repo at a time :smile:
