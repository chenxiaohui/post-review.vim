post-review.vim
===============

A plugin to generate post-review script


Usage
===============

###install:

put post-review.vim to your $VIM/plugin 

add this to your vimrc

    nmap <leader>pr :call PostReview()<cr>

###process:

svndiff use vimdiff: see [link](http://www.ccvita.com/445.html "svndiff use vimdiff")

![](http://www.ccvita.com/usr/uploads/2011/svn_diff.png "svndiff")

gitdiff use vimdiff: see [link](http://cxh.me/2013/09/14/show-gitdiff-using-vimdiff/ "svn diff use vimdiff")

![](http://cxh.me/images/2013-9/git-vimdiff.png "gitdiff")

first use svn diff/git diff and open vimdiff to see the difference

secondly when you consider the changed file needs to be posted , use <leader>pr to add it to post-review.sh

if you has no post-review.sh on your base_dir( specified by the g:base_dir_mark), you need to input the review id or just enter for a new review.

after you added all files you need to review, chmod +x post-review.sh and execute it.

(if you set g:chmod_after_create to 1 you will not need to chmod +x)
