Git basics + version control organization
=========================================
A short activity filling out a Mad Lib using Git

## Installation
__Option 1:__ Download [here](https://git-scm.com/downloads) directly from Git

__Option 2:__ Use ```sudo apt-get install git``` (Ubuntu)

Once you've finished installing, you should also [make an account](https://github.com) on Github.

## What is Git good for?

__Version control__

![organization](https://user-images.githubusercontent.com/15058514/45724076-15be5700-bb7a-11e8-958b-7b6f87aebcdf.png)

__Collaborative development__

![collab](https://user-images.githubusercontent.com/15058514/45724078-17881a80-bb7a-11e8-8d17-586ce919980d.png)

__Dumping your code to the cloud so that you can work from home__

![comic](https://user-images.githubusercontent.com/15058514/45724005-d0018e80-bb79-11e8-902d-9ab3d8dcc8ec.png)

## The basics
For the independent researcher, __sometimes just learning a few basic commands is sufficient for what you need to do__. In general, especially if you're doing large-scale software development, __you should also be aware of some good practices__ when it comes to __organization__ of your repository and how to best take advantage of Git for __collaboration__. Today we will simply cover some of the key functions, but there is also a great blog post [here](https://nvie.com/posts/a-successful-git-branching-model/) by Vincent Driessen discussing some organizational and branch management tips.

Note that since we already have [a nice tutorial](https://github.com/thehackerwithin/illinois/blob/master/git.md) by Aaron that has an example working with a forked repository, today's tutorial will instead attempt to simulate the experience of a new researcher who is just learning about Git.

__Setup__

1. Log into ```https://github.com```
2. Press the "+" button at the top-right of the page, and select "New repository"
3. Give your repository a name, I will call mine "mad_lib"
4. Select "Public" (unlimited private repositories are available to students for free)
5. Leave the "Initialize this repository with a README" unchecked

   README.md files are formatted using Markdown (see a cheatsheet [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#lists)) and automatically displayed at the bottom of the repository page

6. Leave "Add .gitignore: None" as is.
 
    a .gitignore file helps you to automatically decide what files to include when you are staging a commit. I would highly suggest using [gitignore.io](https://www.gitignore.io/) to automatically generate this file depending on your needs.

7. Create a local folder for your repository: ```mkdir <your_repository_name>```
8. Move into the new folder: ```cd <your_repository_name>```
9. Initialize the repository: ```git init```

   This will tell git to set up the repository by creating all of the necessary files in a hidden folder called ".git"
   ```
   $ ls -a
   . .. .git
   ```
   
10. Set up the connection to your remote repository: ```git remote add origin https://github.com/<your_username>/<your_repository_name>.git```
   
   This creates a remote called "origin", which is like an alias for the URL of the repository -- you could have named it anything 
   
__Make your first commit__ 

1. Create a file called "madlib.md": ```vim madlib.md```
2. Copy the following text into the file, update the blanks, and save it:

   ```
   As we have continued learning about software development, we have all at one point asked ourselves two fundamental questions: first, "what language should I learn next?" and second, "what text editor is best?". The first of these questions is quite difficult; Python, C++, Java, etc. are all acceptable and useful, so it can be difficult to choose -- in fact, the only truly repulsive choice would be to use [programming language]. As to the second question, the answer is quite simple -- [editor1] is quite clearly the superior choice, whereas anyone who uses [editor2] brings dishonor and shame upon themselves.
   ```
 
3. Note that git is aware that you created a new file:
   
  ```
  $ git status
  On branch master

  Initial commit

  Untracked files:
    (use "git add <file>..." to include in what will be committed)

          madlib.md

  nothing added to commit but untracked files present (use "git add" to track)
  ```
   
4. Stage the file to be commited and confirm that it was added:
  ```
  $ git add madlib.md
  $ git status
  On branch master

  Initial commit

  Changes to be committed:
    (use "git rm --cached <file>..." to unstage)

          new file:   madlib.md
  ```
  Note: if you have multiple files to add (and a proper .gitignore file), you can use ```git add *

5. Commit your new changes: ```git commit -m "Added Mad Lib template"```

  the ```-m``` denotes that you want to add a message to the commit, with the message following in quotes
 
6. Push the changes to the remote repository:

  ```
  $git push origin master
  
  Username for 'https://github.com': <your_username>
  Password for 'https://<your_username>@github.com':
  Counting objects: 3, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 592 bytes | 0 bytes/s, done.
  Total 3 (delta 0), reused 0 (delta 0)
  remote:
  remote: Create a pull request for 'master' on GitHub by visiting:
  remote:      https://github.com/<your_username>/<your_repository_name>/pull/new/master
  remote:
  To https://github.com/<your_username>/<your_repository_name>.git
   * [new branch]      master -> master
   
 7. Go check online that the change actually showed up: ```https://github.com/<your_username>/<your_repository_name>```
   
  ```
  
  __Now try modifying the file directly through Github__
  
  In order to simulate what would happen if you made changes on one machine and wanted to pull the changes to another machine, we will change the file remotely and then pull it back down.
  
1. From the repository's home page, click on the "madlib.md" file.
2. Click the pencil button (top-right) to edit the file. Press the "Commit changes" (bottom) to save the changes.
3. Back in the command line, pull down the edited version:

  ```
  $ git pull origin master
  
  remote: Counting objects: 3, done.
  remote: Compressing objects: 100% (2/2), done.
  remote: Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
  Unpacking objects: 100% (3/3), done.
  From https://github.com/<your_username>/<your_repository_name>
   * branch            master     -> FETCH_HEAD
     d361c13..cba77cb  master     -> origin/master
  Updating d361c13..cba77cb
  Fast-forward
   madlib.md | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)
  ```
  __Note__ if you accidentally started editing your files before pulling down the most recent version, you might run into merge conflicts (when the remote version has changes that conflict with your local version). If this happens, you might need to manually go through to decide which version to use. If you know that you want to overwrite the local file using the remote version, use ```git merge --strategy-option theirs```

__Often you will want to maintain multiple "branches" of your repository__

1. Notice that you are currently on the "master" branch
   
   ```
   $ git branch
   * master
   ```
   
2. In the command line, create a new branch in your local repository and "checkout" to it:

   ```
   $ git checkout -b my_new_branch
   $ git branch
   * master
     my_new_branch
   ```
   
3. Now make some changes, commit the changes, and push them (```git push origin my_new_branch```) to the remote repository.
4. Return to your repository homepage and notice that you can now navigate between branches using the "Branch" button (left).
5. Locally, you can navigate between branches with ```git checkout <branch_name>```.

## Conclusion

That's it! This was very much a bare-bones exercise intended to introduce beginners to Git. In the future if you have other questions, most everything that you would need can be found on good 'ol Stackoverflow.

## Resources

[Tutorial on branch organization](https://nvie.com/posts/a-successful-git-branching-model/)

[Github cheat sheet](https://education.github.com/git-cheat-sheet-education.pdf)

[Markdown cheat sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#lists)

[.gitignore generator](gitignore.io)
