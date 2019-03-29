## [JupyterLab](https://github.com/jupyterlab/jupyterlab) Demo

JupyterLab is an IDE for working with Jupyter Notebooks, code, and data. You can use text editors, terminals, file viewers, etc. all in the same tabbed work area.

Dev team plans for JupyterLab to eventually replace Jupyter Notebook

### Cool features
* Open and view many other file types
  * CSV
  * Images/GIFs
  * PDFs
  * Markdown
* Live Markdown editing
* Customizable keyboard shortcuts: use vim, emacs, Sublime, or your own
* Code console to run code interactively
* Open text file to code console
    * Edit python script and test bits of it interactively in a console
* Terminal
    * Same shell you have on your own machine
    * Can run anything in system shell with terminal, like `vim`, `top`, etc.
* Notebooks are the same, but with some more neat features

### [Extensions](https://jupyterlab.readthedocs.io/en/stable/user/extensions.html)

Extensions customize/enhance JupyterLab
* Themes
* File viewers
* Editors
* Renderers
* Menu items
* Keyboard shortcuts

Extensions are npm packages, many built or in development on GitHub. Lots of room for involvement!

#### Some cool extensions

[Live LaTeX editing](https://github.com/jupyterlab/jupyterlab-latex)

[Git](https://github.com/jupyterlab/jupyterlab-git)
* Easily see status of git files and stage/track/commit
* **Note**: Currently does not allow you to push changes to GitHub unless you have connected an SSH key to your account.

[GitHub](https://github.com/jupyterlab/jupyterlab-github)
* Browse repos and open files/notebooks

[Code formatter](https://github.com/ryantam626/jupyterlab_code_formatter)
* Black
* YAPF
* Autopep8
* Isort

[Google Drive](https://github.com/jupyterlab/jupyterlab-google-drive)
* Real-time collaborative editing

[JupyterHub](https://jupyterlab.readthedocs.io/en/stable/user/jupyterhub.html)

[More useful extensions](https://github.com/topics/jupyterlab-extension)

#### Installing extensions

Note: Need [Node.js](https://nodejs.org/en/) to install extensions
* `conda install -c conda-forge nodejs`

**Installing [table of contents extension](https://github.com/jupyterlab/jupyterlab-toc)**

* `jupyter labextension install @jupyterlab/toc`

### [Go read the docs](https://jupyterlab.readthedocs.io/en/stable/) and happy hacking :-)