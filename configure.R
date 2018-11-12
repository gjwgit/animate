# Install and configure Ubuntu system dependencies for the pre-built model.
#
# We choose to install user local packages using install.packages()
# rather than OS supplied packages to minimise the need for sys admin
# access from within mlhub. R itself is often operating system
# installed though not necessarily.

# Install OS required pacakgeds

cat("Install system dependencies if needed (please wait as some can take a while)...\n cargo\n\n")
system("sudo apt-get install -y cargo", ignore.stderr=TRUE, ignore.stdout=TRUE)

# Identify the required R packages for this model.

packages <- c("tidyverse", "RColorBrewer", "remotes", "devtools")

# Determine which packages need to be installed.

install  <- packages[!(packages %in% installed.packages()[,"Package"])]

# Report on what is already installed.

already <- setdiff(packages, install)
if (length(already))
{
    cat("The following required R packages are already installed:\n",
        paste(already, collapse=" "))
}

# Install into the package local R library.

lib <- file.path("./R")

# Ensure the library exists.

dir.create(lib, showWarnings=FALSE, recursive=TRUE)

# Install packages into the local R library.

if (length(install))
{
  cat(sprintf("\n\nInstalling '%s' into '%s'...", paste(install, collapse="', '"), lib))
  install.packages(install, lib=lib)
}
cat("\n")

cat("We also need to install these package from github...\n")

pkgs <- c("thomasp85/gganimate", "ellisp/ggflags")
for (pkg in pkgs)
{
  cat(" ", dirname(pkg), "'s ", basename(pkg), " package\n", sep="")
  suppressMessages(devtools::install_github(pkg, lib=lib))
}
