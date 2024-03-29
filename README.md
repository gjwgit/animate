# Visualise Data Through Animations

Animations can add considerable insight to any data analysis and can
communicate quite effectively the story that the data is telling. This
[MLHub](https://mlhub.ai) package illustrates animations that
demonstrate the effectiveness of dynamic visual communications.

The sports animation used here is based on Victor Yu's example code
posted to Twitter with data from the International Association of
Athletics Federations
([IAAF](https://www.iaaf.org/results/olympic-games/2016/the-xxxi-olympic-games-5771/men/decathlon/1500-metres/points)).

Visit the github repository for more details:
<https://github.com/gjwgit/animate>

## Quick Start Command Line Examples

```console
$ ml demo animate
```

## Usage

- To install mlhub (Ubuntu)

```console
$ pip3 install mlhub
```

- To install, configure, and run the demo:

```console
$ ml install   animate
$ ml configure animate
$ ml readme    animate
$ ml commands  animate
$ ml demo      animate
```

## Demonstration

```console
$ ml demo animate
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
