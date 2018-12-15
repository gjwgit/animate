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

INC_BASE    = $(HOME)/.local/share/make
INC_PANDOC  = $(INC_BASE)/pandoc.mk
INC_GIT     = $(INC_BASE)/git.mk
INC_MLHUB   = $(INC_BASE)/mlhub.mk
INC_CLEAN   = $(INC_BASE)/clean.mk

ifneq ("$(wildcard $(INC_PANDOC))","")
  include $(INC_PANDOC)
endif
ifneq ("$(wildcard $(INC_GIT))","")
  include $(INC_GIT)
endif
ifneq ("$(wildcard $(INC_MLHUB))","")
  include $(INC_MLHUB)
endif
ifneq ("$(wildcard $(INC_CLEAN))","")
  include $(INC_CLEAN)
endif

$(MODEL)_rpart_model.RData: train.R $(MODEL).csv
	Rscript $<

iaaf.csv: iaaf.R
	Rscript $<

clean::
	rm -f 	README.txt

realclean:: clean
	rm -f 	$(MODEL)_*.mlm	\
		$(MODEL).gif	\
