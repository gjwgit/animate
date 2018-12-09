########################################################################
#
# Makefile for animate pre-built ML model
#
########################################################################

# List the files to be included in the .mlm package.

MODEL_FILES = 			\
	configure.R 		\
	demo.R 			\
	README.txt		\
	MLHUB.yaml		\
	iaaf.R			\
	iaaf.csv		\
	animate_800.gif		\
	gganimate.tar.gz	\
	ggflags.tar.gz		\

# Include standard Makefile templates.

include ../git.mk
include ../pandoc.mk
include ../clean.mk
include ../mlhub.mk

$(MODEL)_rpart_model.RData: train.R $(MODEL).csv
	Rscript $<

iaaf.csv: iaaf.R
	Rscript $<

clean::
	rm -f 	README.txt

realclean:: clean
	rm -f 	$(MODEL)_*.mlm	\
		$(MODEL).gif	\
