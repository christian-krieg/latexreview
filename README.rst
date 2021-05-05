LaTeXreview
===============================================================================

This project provides utilities and a workflow to make reviews of LaTeX
documents straight-forward, transparent, and reproducible.

Overview
-------------------------------------------------------------------------------

Installation
-------------------------------------------------------------------------------

Usage
-------------------------------------------------------------------------------

The body text of the original draft is (adapted from
`Wikipeda <https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem>`__)
as follows:

.. literalinclude:: test.tex
   :language: tex
   :linenos:


We commit our changes::

   git commit -m "Added original draft of 'test' document"

We tag the original draft::

   git tag -a -m "Orginal draft of 'test' document" orig-draft

Now, lets have a look at the resulting PDF file::

   make pdf

The resulting PDF file looks like this:

.. image:: docs/fig/orig-draft.png

Now, Alice adds some review comments::

   \alicehl{Lorem ipsum dolor}{Probably capitalize that part } sit amet,
   consectetuer adipiscing elit. Ut purus elit, vestibulum ut, placerat ac,
   adipiscing vitae, felis.
   
   \alice[inline]{I really like Latin.}
   
   Curabitur dictum gravida mauris. Nam arcu libero, nonummy eget, consectetuer
   id, vulputate a, magna.  Donec vehicula augue eu neque. Pellentesque habitant
   mobi\alice{use spell checker!} tristique senectus et netus et malesuada fames
   ac turpis egestas. Mauris ut leo. Cras viverra metus rhoncus sem. Nulla et
   lectus vestibulum urna fringilla ultrices. Phasellus eu tellus sit amet
   tortor gravida placerat. Integer sapien est, iaculis in, pretium quis,
   viverra ac, nunc.  Praesent eget sem vel leo ultrices bibendum. Aenean
   faucibus. Morbi dolor nulla, malesuada eu, pulvinar at, mollis ac, nulla.
   Curabitur auctor semper nulla.  Donec varius orci eget risus. Duis nibh mi,
   congue eu, accumsan eleifend, sagittis quis, diam. Duis eget orci sit amet
   orci dignissim rutrum.

... and build the draft again::

   make pdf


