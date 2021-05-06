LaTeXreview
===============================================================================

This project provides utilities and a workflow to make reviews of LaTeX
documents straight-forward, transparent, and reproducible.

Overview
-------------------------------------------------------------------------------

Installation
-------------------------------------------------------------------------------

Review process
-------------------------------------------------------------------------------

In the following, we describe a method to carry out a review process using
LaTeXreview between two actors `Alice` and `Bob`. In our scenario, Bob is the
first author of a text, and Alice is the reviewer. The review starts with Bob's
original draft, and is reviewed by Alice multiple times. With each review cycle,
the text is improved until Alice has no more complaints. Then, the draft becomes
final. The process is visualized below.

.. image:: docs/fig/protocol.png


Usage
-------------------------------------------------------------------------------

Bob's challenge is to write down the wolf, goat, and cabbage problem. He creates
a file ``main.tex`` with all the essential meta-information (title and author),
and drafts a first version to describe the problem (literally copied from
`Wikipeda <https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem>`__)::

   \documentclass[a4paper,twoside] {article}
   \title{The wolf, the goat and the cabbage }
   \author{Bob Doe}
   
   \usepackage{newtodo}
   \newtodo{alice}{purple}
   \newtodo{bob}{yellow}
   
   \begin{document}
   \maketitle
   
   Once upon a time a farmer went to a market and purchased a wolf, a goat, and
   a cabbage. On his way home, the farmer came to the bank of a river and rented
   a boat. But crossing the river by boat, the farmer could carry only himself
   and a single one of his purchases: the wolf, the goat, or the cabbage.
   
   If left unattended together, the wolf would eat the goat, or the goat would
   eat the cabbage.
   
   The farmer's challenge was to carry himself and his purchases to the far bank
   of the river, leaving each purchase intact. How did he do it?
   \end{document}

Bob builds his document using ``make``::

   make pdf

The result looks like this:

.. image:: docs/fig/orig-draft.png

Bob creates a git repository, adds his file ``main.tex``, and commits his
changes::

   git init
   git add main.tex
   git commit -m "Added original draft of 'test' document"

In addition, Bob tags the original draft::

   git tag -a -m "Orginal draft of 'main' document" orig-draft

Bob then pushes the repository to a remote place where Alice has access to it.

Now, Alice adds some review comments. She decides it would be more appropriate
to tell the story in present tense, and modifies the text accordingly. Also, she
thinks it would be enough to have one paragraph for this fair amount of text.
Besides other comments, she adds a comment at the top of the text, listing her
general remarks for the text::

   \documentclass[a4paper,twoside] {article}
   \title{The wolf, the goat,\alice{Adding the Oxford comma here} and the cabbage}
   \author{Bob Doe}
   
   \usepackage{newtodo}
   \newtodo{alice}{purple}
   \newtodo{bob}{yellow}
   
   \begin{document}
   \maketitle
   
   \alice[inline]{ \textbf{General remarks:}
       \begin{itemize}
           \item{Let's transform everything to present tense; I already did that.}
           \item{I think the text is short enough to have one paragraph instead of
               three paragraphs. I changed that.}
       \end{itemize}
   }
   
   \alicehl{A farmer}{Shall we give him a name?} goes to a market and purchases a
   wolf, a goat, and a cabbage. On his way home, the farmer comes to the bank of a
   river and rents a boat. But crossing the river by boat, the farmer could carry
   only himself and a single one of his purchases: the wolf, the goat, or the
   cabbage.
   %
   If left unattended together, the wolf would eat the goat, or the goat would eat
   the cabbage.
   %
   The farmer's challenge is to carry himself and his purchases to the far bank of
   the river, leaving each purchase intact. How does he do it?
   \end{document}

Alice has a look at the reviewed document by calling ``make``:: 

   make pdf

The result is:

.. image:: docs/fig/draft-reviewed-alice.png

Alice can see her comments, but she does not see the changes she made on the fly
in order to transform the text from past tense to present tense. Therefore,
Alice calls ``make`` again to generate a PDF that shows the differences she made
while editing Bob's text::

   make diff

The result is:

.. image:: docs/fig/diff-reviewed-alice.png

Alice commits her changes into a new branch, tags the commit, and pushes the new
branch to the remote repository::

   git checkout -b alice-bob
   git commit -m "Added review comments" main.tex
   git tag -a -m "Review 1 by Alice of orginal draft of 'main' document" alice-bob-review1
   git push origin alice-bob
   git push --tags


Bob pulls the repository, and checks out the branch created by Alice::

   git pull origin alice-bob
   git checkout alice-bob


Bob then looks at the reviewed document, and replies to one of
Alice's comments. He thinks that *Bob* would be a very good name for the farmer,
so he suggests that in a review comment::

   \documentclass[a4paper,twoside] {article}
   \title{The wolf, the goat,\alice{Adding the Oxford comma here} and the cabbage}
   \author{Bob Doe}
   
   \usepackage{newtodo}
   \newtodo{alice}{purple}
   \newtodo{bob}{yellow}
   
   \begin{document}
   \maketitle
   
   \alice[inline]{ \textbf{General remarks:}
       \begin{itemize}
           \item{Let's transform everything to present tense; I already did that.}
           \item{I think the text is short enough to have one paragraph instead of
               three paragraphs. I changed that.}
       \end{itemize}
   }
   
   \alicehl[inline]{A farmer}{Shall we give him a name?
       \bob[inline]{Good idea! I like `Bob' very much! Doesn't ``Farmer Bob'' sound
           cool?
       }
   }
   goes to a market and
   purchases a wolf, a goat, and a cabbage. On his way home, the farmer comes to
   the bank of a river and rents a boat. But crossing the river by boat, the farmer
   could carry only himself and a single one of his purchases: the wolf, the goat,
   or the cabbage.
   %
   If left unattended together, the wolf would eat the goat, or the goat would eat
   the cabbage.
   %
   The farmer's challenge is to carry himself and his purchases to the far bank of
   the river, leaving each purchase intact. How does he do it?
   \end{document}

Bob now reviews his changes that have happened since Alice's review::

   make diff

This results in the following PDF:

.. image:: docs/fig/diff-bob.png

To view all changes made since he submitted his original draft for Alice to
review, Bob sets the ``COMMIT`` variable to the tag he created at submission
time::

   make diff COMMIT=orig-draft

This results in the following PDF:

.. image:: docs/fig/diff-bob-all.png

Bob is satisfied, and he commits his reply to Alice's review. Again, he creates
a tag ``reply1`` and pushes the result to the remote repository::

   git commit -m "Reply to Alice's review 1" main.tex
   git tag -a -m "Reply to Alice's review1" alice-bob-reply1
   git push --tags
   git push origin alice-bob


Alice pulls the updated review branch, generates a PDF as well as a diffed
version of the PDF, and finds Bob's suggestion cool. She disables all review
comments which have been addressed, comments on Bob's suggestion::

   \documentclass[a4paper,twoside] {article}
   \title{The wolf, the goat,\alice[disable]{Adding the Oxford comma here} and the cabbage}
   \author{Bob Doe}

   \usepackage{newtodo}
   \newtodo{alice}{purple}
   \newtodo{bob}{yellow}
   
   \begin{document}
   \maketitle
   
   \alice[inline,disable]{ \textbf{General remarks:}
       \begin{itemize}%
           \item{Let's transform everything to present tense; I already did that.}%
           \item{I think the text is short enough to have one paragraph instead of
               three paragraphs. I changed that.}%
       \end{itemize}%
   }
   
   \alicehl[inline]{A farmer}{Shall we give him a name?
       \bob[inline]{Good idea! I like `Bob' very much! Doesn't ``Farmer Bob'' sound
           cool?
           \alice[inline]{I like that! Let's do so!}
       }
   }
   goes to a market and
   purchases a wolf, a goat, and a cabbage. On his way home, the farmer comes to
   the bank of a river and rents a boat. But crossing the river by boat, the farmer
   could carry only himself and a single one of his purchases: the wolf, the goat,
   or the cabbage.
   %
   If left unattended together, the wolf would eat the goat, or the goat would eat
   the cabbage.
   %
   The farmer's challenge is to carry himself and his purchases to the far bank of
   the river, leaving each purchase intact. How does he do it?
   \end{document}

Alice commits and pushes her changes::

   git commit -m "Review2 of main document" main.tex
   git tag -a -m "Review2 of main document" alice-bob-review2
   git push --tags
   git push origin alice-bob

Bob pulls the reviewed document, and applies the changes as suggested by Alice::

   \documentclass[a4paper,twoside] {article}
   \title{The wolf, the goat,\alice[disable]{Adding the Oxford comma here} and the cabbage}
   \author{Bob Doe}
   
   \usepackage{newtodo}
   \newtodo{alice}{purple}
   \newtodo{bob}{yellow}
   
   \begin{document}
   \maketitle
   
   \alice[inline,disable]{ \textbf{General remarks:}
       \begin{itemize}%
           \item{Let's transform everything to present tense; I already did that.}%
           \item{I think the text is short enough to have one paragraph instead of
               three paragraphs. I changed that.}%
       \end{itemize}%
   }
   
   \alicehl[inline]{A farmer}{Shall we give him a name?
       \bob[inline]{Good idea! I like `Bob' very much! Doesn't ``Farmer Bob'' sound
           cool?
           \alice[inline]{I like that! Let's do so!}
       }
   }
   named Bob goes to a market and
   purchases a wolf, a goat, and a cabbage. On his way home, Bob comes to
   the bank of a river and rents a boat. But crossing the river by boat, Bob
   could carry only himself and a single one of his purchases: the wolf, the goat,
   or the cabbage.
   %
   If left unattended together, the wolf would eat the goat, or the goat would eat
   the cabbage.
   %
   Bob's challenge is to carry himself and his purchases to the far bank of
   the river, leaving each purchase intact. How does he do it?
   \end{document}

The diff looks lite this:

.. image:: docs/fig/alice-bob-reply2.png

Bob commits, tags, and pushes the result::

   git commit -m "Reply 2 of main document" main.tex
   git tag -a -m "Reply 2 of main document" alice-bob-reply2
   git push --tags
   git push origin alice-bob

Alice pulls the changes, reviews them again, and finds all review comments
applied in Bob's text. She disables the last pending comment::


Then she commits the result, and tags the commit as final draft::

   git commit -m "Final review of main document" main.tex
   git tag -a -m "Final draft of main document" alice-bob-final-draft
   git push --tags
   git push origin alice-bob

The final diff looks like this:

.. image:: docs/fig/final-draft.png

Bob reviews all changes that have been applied to the original draft by calling
make with the COMMIT set to the tag name of the original draft::

   make diff COMMIT=orig-draft

This is the total diff:

.. image:: docs/fig/final-draft-all.png
