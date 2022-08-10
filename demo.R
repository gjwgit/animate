###########################################################################
# Introduce the concept of animated graphics for data science through MLHub
#
# See https://github.com/thomasp85/gganimate
#

library(mlhub)

mlcat("Animated Graphics",
"We illustrate the use of animations to add more interest and insight
to the graphics we can produce in R. This adds to the narrative that
we are telling through the data and is a fundamental tool for the
Data Scientist to communicate that narrative.")

# Load required packages.

suppressMessages(
{
  library(tidyverse)
  library(RColorBrewer)
  library(gganimate)
  library(ggflags)
})

# TODO Examples from the gganimate package.

mlask()

# This example is based on Victor Yu's very nice example as posted to
# Twitter 2018-11-09,
# https://twitter.com/VictorYuEpi/status/1061012677907091457, and
# Victor later shared the code at
# https://twitter.com/VictorYuEpi/status/1061681783920619521.

mlcat("Sports Analytics",
"This animation is based on code shared by Victor Yu on Twitter, 9 November 2018.
See the README on github for details. Please wait whilst we generate 100 frames
for the animation.", end="\n\n")

suppressMessages(rio_df <- read_csv("iaaf.csv"))

ds <- rio_df

# Victor says: create dummy rows for the athletes to begin at "Start"
# event (event = 0), before they gain points in the first event
# (100m). Also, sets the median of the total number of athletes/ranks
# for the animation to "Start" at. For example, if you make rank = 1,
# the animation will burst from Rank 1. However I'm doing this for a
# lot of subsets so I made it an automated process.
#
# Victor says about the second mutate: Below is credit of Jon Spring,
# who answers a lot of gganimate questions on stack. This method takes
# inspiration from his answer here:
# https://stackoverflow.com/questions/53092216/
# any-way-to-pause-at-specific-frames-time-points-with-transition-reveal-in-gganim
#
# Victor syas about the second mutate: the rhs number of the mutate is
# the 'ratio' or quantity of frames to create. I say ratio as the
# number of frames is technically determined by the fps/nframes
# arguments in animate()
#
# Note that uncount() is a tidyr function which copies each line 'n'
# times.

ds %<>%
  filter(event == 1) %>%
  mutate(event=0, rank=median(seq(nrow(.)))) %>%
  bind_rows(ds) %>%
  mutate(show_time=case_when(event %in% c(10)  ~ 5,
                             event %in% c(1:9) ~ 3,
                             TRUE              ~ 1)) %>%
  uncount(show_time) %>% 
  group_by(Athlete) %>%
  mutate(reveal_time = row_number()) %>%
  ungroup()

# Victor: Create reference vectors for convenience.

ds %>%
  select(Athlete) %>%
  unique() %>%
  nrow() ->
n_athletes 

events_vector_ordered_v2 <- c("Start", "100m", "Long Jump", "Shotput",
                              "High Jump", "400m", "110m Hurdles",
                              "Discus Throw", "Pole Vault",
                              "Javelin Throw", "1500m")

# Build the plot.

ds %>%
  ggplot(aes(event, rank, group=Athlete)) +

  # Victor: this geom_line() helps emphasize the colour of the
  # lines. It puts a default black line with some transparency behind
  # each coloured line you saw for the athletes.

  geom_line(size=1.75, colour="black", alpha=0.5) +

  # Victor: reorder the factor so the palette matches the line
  # colours where purple = top scorers and red = bottom scorers
  # after finishing the decathlon. 

  geom_line(aes(colour=fct_reorder(Athlete, finalscore)), size=1.5) +

  # Victor: some trial and error with getting the flags and the text
  # of the athletes in alignment together. The number after 'event'
  # in geom_flag and geom_text below shifts the geom in the x-direction
  # and I found this easier to control over using hjust arguments.
  
  geom_flag(aes(event + 0.175, country = cc_iso2c), size = 5) +
  
  geom_text(aes(event + 0.3, label=Athlete), size=5, family="Segoe UI", hjust=0) +
  
  scale_y_reverse(name="Rank",
                  breaks=seq(1, n_athletes, 1),
                  sec.axis=dup_axis(name = element_blank())) +

  ## Victor: in the below limits, expand the limits to account for
  ## athlete names, otherwise it will cross the boundaries of the
  ## graph. Again, some trial and error here, there's probably a
  ## better way to expand to a specific width based on the athlete
  ## with the longest name (here - Thomas van der Plaetsen).
  
  scale_x_continuous(name="Event",
                     breaks=0:10,
                     labels=events_vector_ordered_v2, 
                     limits=c(0,11.75), 
                     sec.axis = dup_axis(name=element_blank())) +
  
  labs(title = paste("Progression of the Ranking of Decathletes",
                     "who Finished the Decathlon in the 2016 Olympics")) +
  
  theme(panel.grid.minor.y=element_blank(),
        panel.grid.minor.x=element_blank(),
        text=element_text("Segoe UI"),
        axis.text=element_text(size=11),
        axis.title=element_text(size=20),
        axis.title.x=element_text(hjust=0.475, margin=margin(t=5)),
        plot.title=element_text(margin=margin(b=8), size=24)) +

  # Victor: interpolate Spectral colour values for n number of
  # athletes
  
  scale_color_manual(values=colorRampPalette(brewer.pal(11, "Spectral"))(n_athletes),
                     guide=FALSE) + 

#  transition_reveal(Athlete, ds$reveal_time) ->
  transition_reveal(reveal_time) ->

my_anim

# Victor's Warning: this takes a while to generate. Depending on how
# good your cpu is, probably anywhere from 15 minutes to an hour. I
# have an i5-3470 and it takes me around 40 mins. So it's best to run
# this with nframes = 100 first to check you're happy with the font
# layout/formatting/sizing before generating the full animation. In my
# full animation I set nframes=800.
#
# The use of type="cairo-png" fails on DSVM for some reason.
#
# tmp <- animate(my_anim, nframes=100, fps=25, width=1200, height=600, type="cairo-png")

tmp <- animate(my_anim, nframes=100, fps=25, width=1200, height=600)

cat("
Press Enter to view the generated animation: ")
invisible(readChar("stdin", 1))

fname <- "animate.gif"
anim_save(fname)
mlpreview(fname)
mlask(end="")

cat("
=================================
More Frames => Smoother Animation
=================================

This pre-built (large) image with more frames will generally deliver a
better experience. The animated gif will take longer to load, since it
is quite a bit larger. It was generated with 800 frames rather than the
100 above. The end result is a much smoother animation (at least on local
machines).

Press Enter to display the animation: ")
invisible(readChar("stdin", 1))

# TODO Consider adding this 37MB file to the cache store on MLHub.ai

mlpreview("animate_800.gif",
          msg="Please wait for the animation display.
Close it using Ctrl-w.
Then press Enter to exit.",
          end="")
mlask("", end="")
