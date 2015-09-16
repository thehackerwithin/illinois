---
layout: post
title: Git Workflow
author: Aaron Anderson
category: upcoming
tags: meeting 
---

## Meeting Info

* Date: Sept 16, 2015
* Time: 12:00 PM
* Location: [1030 NCSA][ncsa_map]
* Topic: Git Workflow

## Technical: "Git Workflow"
[Aaron T. Anderson][aarona]

Git is version control software best understood in by using it in the context of a workflow for collaborating on a code base. Attendees will get a better understanding of git by looking at the theoretical workflow, a practical example, and how to recover from a conflict.

Last meeting's *fixed* example: [Git tutorial -- "add new post"][git-tutorial]

**External Resources** (in order of complexity):

1. [Try git live in your browser][git-live] - great tutorial!
2. [Git Reference][git-ref] - favorite reference
3. [Git Cheatsheet][git-cs]
4. [Simple workflow][workflow]
5. [Collaborating workflow][workflow-colab]

**THW Community resources:**

- THW-Berkeley Intro
  - [Intro to Git I][git1]
  - [Intro to Git II][git2]

- THW-Berkeley Fall 2015 
  - [Git Intro][thw-b-intro]
  - [Git Advanced][thw-b-advanced]


## Lightning Research Talk: "Error Catastrophe — HIV like melting ice"
   Gregory R. Hart

HIV is a rapidly evolving virus which makes it difficult to treat or cure. By drawing comparisons between between the viral quasispecies and statistical physics we can calculate the "thermodynamic" properties of the virus, finding a "phase transition". This phase transition is reveals novel drug treats and new treatment strategies.

## Prez Tip \#2

### Git + LaTeX

LaTeX is a popular typesetting system in academia because it's focus on the simple construction of mathematical formulas. Since LaTeX is like any other coding language, it is well suited to be tracked by git.  

**List of (suggested) branches:**

- *master* -- most publishable version
- *advisor* -- track *suggestions* for edits
- sections -- branch for each, to make tracking changes easier
  - *abstract*
  - *introduction*
  - *methods*
  - *results*
  - *discussion*
  - *conclusion*

When someone suggests edits, create a new branch (or update *advisor* branch) and save two versions of the paper, e.g. paper.tex and paper_advisor.tex, then run latexdiff:

    $ latexdiff paper.tex paper_advisor.tex > paper_advisor_highlighted.tex
    $ pdflatex paper_advisor_highlighted.tex

The `pdflatex` command will output a marked-up version of the paper (removed words = crossed out red; added words = blue and underlined squiggle).

More tips and suggestions can be found on the StackOverflow question titled ["Git + LaTeX workflow"][git-latex].


## Attendance

- <++>


[ncsa_map]: http://illinois.edu/map/view?skinId=0&ACTION=MAP&buildingId=564
[aarona]: {{site.url}}/_people/Aaron_Anderson.html
[git-tutorial]: https://github.com/thehackerwithin/illinois/blob/master/git.md
[git-ref]: http://gitref.org/index.html
[git-live]: https://try.github.io/levels/1/challenges/1
[git-cs]: https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf
[workflow]: https://guides.github.com/introduction/flow/index.html
[workflow-colab]: http://nvie.com/posts/a-successful-git-branching-model/
[thw-b-intro]: http://thehackerwithin.github.io/berkeley/posts/git-intro-fall-2015/
[thw-b-advanced]: http://thehackerwithin.github.io/berkeley/posts/advanced-git-fall-2015/
[git1]: https://github.com/thehackerwithin/berkeley/tree/master/git/partI
[git2]: https://github.com/thehackerwithin/berkeley/tree/master/git/partII
[git-latex]: http://stackoverflow.com/questions/6188780/git-latex-workflow
