# Install and configure Ubuntu system dependencies for the pre-built model.
#
# We choose to install user local packages using install.packages()
# rather than OS supplied packages to minimise the need for sys admin
# access from within mlhub. R itself is often operating system
# installed though not necessarily.

########################################################################
# Identify missing OS required packages.

install <- c("eom", "cargo")
already <- NULL
for (p in install)
{
  if (system(paste("dpkg -s", p), ignore.stdout=TRUE, ignore.stderr=TRUE) == 0)
    already <- c(already, p)
}
install <- setdiff(install, already)
if (length(already))
{
  cat("The following required system packages are already installed:\n ",
      paste(already, collapse=" "), "\n\n")
}
if (length(install))
{

  cat("Installing the following system dependencies:\n ", paste(install, collapse=" "), "\n\n")
  system(paste("sudo apt-get install --yes", paste(install, collapse=" ")),
         ignore.stdout=TRUE, ignore.stderr=TRUE)
}

########################################################################
# Identify the required R packages for this model.

packages <- c("progress", "png", "tidyverse", "RColorBrewer", "devtools")

# Determine which packages need to be installed.

install  <- packages[!(packages %in% installed.packages()[,"Package"])]

# Report on what is already installed.

already <- setdiff(packages, install)
if (length(already))
{
    cat("The following required R packages are already installed:\n",
        paste(already, collapse=" "), "\n\n")
}

# Install into the package local R library.

lib <- file.path("./R")

# Ensure the library exists.

dir.create(lib, showWarnings=FALSE, recursive=TRUE)

# Install packages into the local R library.

if (length(install))
{
  cat(sprintf("Installing '%s' into '%s'...\n", paste(install, collapse="', '"), lib))
  install.packages(install, lib=lib)
  cat("\n")
}

########################################################################
# Specific extensions by URL

if (TRUE)
{
  cat("We also need to install these specific packages...\n")

  # This is because on the DSVM R is a little out of date.
  
  pkgs <- c("https://cran.r-project.org/src/contrib/gifski_0.8.6.tar.gz",
            "https://cran.r-project.org/src/contrib/farver_1.1.0.tar.gz",
            "https://cran.r-project.org/src/contrib/tweenr_1.0.1.tar.gz",
            "gganimate.tar.gz",
            "ggflags.tar.gz")
  for (pkg in pkgs)
  {
    cat("", basename(pkg), "\n")
    install.packages(pkg, repos=NULL, lib=lib)
  }
}

########################################################################
# Github extensions

if (FALSE) # Could not get this to work on DLVM? So download and install tar.gz.
{
  cat("We also need to install these updated packages from github...\n")

  pkgs <- c("thomasp85/gganimate", "ellisp/ggflags")
  for (pkg in pkgs)
  {
    cat(" ", dirname(pkg), "'s ", basename(pkg), " package\n", sep="")
    devtools::install_github(pkg, lib=lib)
  }
}
