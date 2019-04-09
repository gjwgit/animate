Animate
=======

Animations can add considerable insight into the data we are
exploring. In this [MLHub](https://mlhub.ai) package we illustrate
animations created from our data.

The sports animation is based on Victor Yu's example code posted to
[Twitter](https://twitter.com/VictorYuEpi/status/1061012677907091457)
with the code shared also on
[Twitter](https://twitter.com/VictorYuEpi/status/1061681783920619521).
The data come from the International Association of Atheletics
Federations [IAAF](https://www.iaaf.org/results/olympic-games/2016/the-xxxi-olympic-games-5771/men/decathlon/1500-metres/points).

Animations are best run on your local server rather than from the
cloud where the experience will be quite jarring.

Visit the github repository for more details:
<https://github.com/gjwgit/animate>

Usage
-----

To install and run the pre-built model:

    $ pip3 install mlhub
    $ ml install   animate
    $ ml readme    animate
    $ ml configure animate
    $ ml commands  animate
    $ ml demo      animate

Demonstration
-------------

```console
=================
Animated Graphics
=================

We illustrate the use of animations to add more interest and insight
to the graphics we can produce in R. This adds to the narrative that
we are telling through the data and is a fundamental tool for the
Data Scientist to communicate that narrative.

Press Enter to continue on to a sports analytics example: 

================
Sports Analytics
================

This animation is based on code shared by Victor Yu on Twitter, 9 November 2018.
See the README on github for details. Credit to Victor for sharing this great
example. Please wait whilst we generate 100 frames for the animation.
Frame 100 (100%)
Finalizing encoding... done!

Press Enter to view the generated animation: 
```
![](animate_100.gif)

```console
Close the graphic window using Ctrl-w.
Press Enter to continue on to view a smoother animation: 

=================================
More Frames => Smoother Animation
=================================

This pre-built (large) image with more frames will generally deliver a
better experience. The animated gif will take longer to load, since it
is quite a bit larger. It was generated with 800 frames rather than the
100 above. The end result is a much smoother animation (at least on local
machines).

Press Enter to display the animation: 
```
![](animate_800.gif)

```console
Close the graphic window using Ctrl-w.
Press Enter to finish this demonstration: 

Thank you for exploring the 'animate' package.
```
