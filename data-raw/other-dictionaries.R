## ---------------------------
##
## Script name: other-dictionaries.R
##
## Purpose of script: Load other populism dictionaries and provide it as data
##                    for my popdictR package.
##
## Author: Johann Gründl
##
## Date created: 2019-11-05
##
## Email: mail@johanngruendl.at
##
## ---------------------------
##
## Notes:
##
##
## ---------------------------

## Load (and install if necessary) packages
required_packages <- c("readODS",
                       "usethis",
                       "quanteda",
                       "tidyverse")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos = "http://cran.rstudio.com")
    library(pkg, character.only = TRUE)
  }
}
rm(required_packages, pkg)

## Read ODS
other_dictionaries <- read_ods("data-raw/other-dictionaries.ods")

## Include full data set in package
usethis::use_data(other_dictionaries, internal = FALSE, overwrite = TRUE)

## Include German dictionary terms in dataset
rooduijn_2011_german_terms <- other_dictionaries[, "rooduijn-2011-german"]
rooduijn_2011_german_terms <-
  rooduijn_2011_german_terms[!(rooduijn_2011_german_terms == "" |
                                 is.na(rooduijn_2011_german_terms))]
pauwels_2017_terms <- other_dictionaries[, "pauwels-2017"]
pauwels_2017_terms <-
  pauwels_2017_terms[!(pauwels_2017_terms == "" | is.na(pauwels_2017_terms))]
use_data(rooduijn_2011_german_terms, internal = FALSE, overwrite = TRUE)
use_data(pauwels_2017_terms, internal = FALSE, overwrite = TRUE)
