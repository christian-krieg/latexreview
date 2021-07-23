Review process
==============

In the following, we describe a review process which has been very useful for us
in the past. We use git for managing the contributions of the different
reviewers, and for making changes visible in the `diffed` output.

Starting a review
-----------------

We create a branch::

   git checkout -b review/<reviewer>/<year>-<month>


Submitting a review
-------------------

The reviewer commits her changes::

   git add <file> ...
   git commit

And tags the commit, including the iteration number::

   git tag -a -m "Review comments for <document/chapter/etc.> (iteration X)" <reviewer>/<year>-<month>/<X>


Finishing a review
------------------

When the review cycle is finished, we tag the final commit::

   git tag -a -m "Final draft for <document/chapter/etc.> (iteration X)" <reviewer>/<year>-<month>/<X>-final

Finally, we merge the review branch into ``master``, and delete the review
branch::

   git checkout master
   git merge review/<reviewer>/<year>-<month>
   git branch -d review/<reviewer>/<year>-<month>
