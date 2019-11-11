## Header ----------------------------------------------------------------------
##
## Script name: gruendl-populism-dict.R
##
## Purpose of script: Load my populism dictionary and provide it as data
##                    for my popdictR package.
##
## Author: Johann Gründl
##
## Date created: 2019-11-05
##
## Email: mail@johanngruendl.at
##
## ***************************
##
## Notes:
##
##
## *****************************************************************************


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
gruendl_dictionary_complete <-
  read_ods("data-raw/gruendl-populism-dict.ods") %>%
  filter(!(Word == "")) %>%
  filter(!is.na(Word))

## Include full data set in package
usethis::use_data(gruendl_dictionary_complete, internal = FALSE,
                  overwrite = TRUE)

## Now without the old glob terms
gruendl_all_regex_terms <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  pull(Word)
usethis::use_data(gruendl_all_regex_terms, internal = FALSE, overwrite = TRUE)

## Now only the current dictionary terms
gruendl_terms <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  filter(Include == 1) %>%
  pull(Word)
usethis::use_data(gruendl_terms, internal = FALSE, overwrite = TRUE)

## Now only the current dictionary terms for news media
gruendl_terms_media_only <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  filter(Include == 1) %>%
  filter(Source_Politician != 1) %>%
  pull(Word)
usethis::use_data(gruendl_terms_media_only, internal = FALSE, overwrite = TRUE)

## Now only the current dictionary terms for conflictive messages
gruendl_terms_conflictive <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  filter(Include == 1) %>%
  filter(Type2 == "conflictive") %>%
  pull(Word)
usethis::use_data(gruendl_terms_conflictive, internal = FALSE, overwrite = TRUE)

## Now only the current dictionary terms for news media for conflictive messages
gruendl_terms_conflictive_media_only <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  filter(Include == 1) %>%
  filter(Source_Politician != 1) %>%
  filter(Type2 == "conflictive") %>%
  pull(Word)
usethis::use_data(gruendl_terms_conflictive_media_only,
                  internal = FALSE, overwrite = TRUE)

## Now only the current dictionary terms for advocative messages
gruendl_terms_advocative <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  filter(Include == 1) %>%
  filter(Type2 == "advocative") %>%
  pull(Word)
usethis::use_data(gruendl_terms_advocative, internal = FALSE, overwrite = TRUE)

## Now only the current dictionary terms for news media for advocative messages
gruendl_terms_advocative_media_only <- gruendl_dictionary_complete %>%
  filter(wildcard != "glob") %>%
  filter(Include == 1) %>%
  filter(Source_Politician != 1) %>%
  filter(Type2 == "advocative") %>%
  pull(Word)
usethis::use_data(gruendl_terms_advocative_media_only,
                  internal = FALSE, overwrite = TRUE)
