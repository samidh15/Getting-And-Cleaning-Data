# Getting-And-Cleaning-Data
The script assumes that it resides in the same level as the directory UCI HAR Dataset. The script can be run as :

Rscript run_analysis.R

from a linux prompt.

Or, from Rstudio or R prompt, source("run_analysis.R")

There are some warnings that result, but the NA for categorical variables have been taken care of subsequently by the script.

The result is saved in a file called "resultant_tidy_set.txt", which is uploaded in part 1 of the assignment.