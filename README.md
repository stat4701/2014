EDAV Repo
===========

You might want the fancy gh-pages Jekyll-ized version: [malecki.github.io/edav/](http://malecki.github.io/edav)

However, if you want to look at more source-like files, you're in the right place!

# Some handy tips and tricks #

`_drafts/post-template.md` is a post template. Here's how I would start a new post.

```{bash}
git checkout gh-pages
git fetch upstream
git merge upstream/gh-pages
git checkout -b my-new-blogpost
cp _drafts/post-template.md _posts/2014-14-14-is-not-a-valid-date.md
```

(Then add the correct filename to a new commit on your new branch which will be the basis of the request.)

Turn a post into fun reveal.js slides by using the 'pres' layout. Slides then nest in `<section>` tags ([doc](http://lab.hakim.se/reveal-js/#/))

Other useful git tricks
------------

Add this or [something similar](http://stackoverflow.com/questions/1057564/pretty-git-branch-graphs) to your .gitconfig and then type `git tree` for a nice display in your 
```{bash}
[alias]
        tree = log --graph --decorate --pretty=oneline --abbrev-commit
        lg = log --graph --abbrev-commit --decorate --date=relative \
--format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
```
