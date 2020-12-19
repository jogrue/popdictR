# popdictR

This package contains a German-language populism dictionary and functions to 
apply the dictionary to text. It includes the dictionary as published in the the
paper ["Populist ideas on social media" in _New Media & Society_](https://doi.org/10.1177/1461444820976970).


## Install

This package requires my packages [multidictR](https://github.com/jogrue/multidictR) and
[regexhelpeR](https://github.com/jogrue/regexhelpeR) which should be installed 
before this package.

You can install everything from within R using 
[devtools](https://github.com/hadley/devtools):

```R
library(devtools)

# Install the dependency regexhelpeR from GitHub
devtools::install_github("jogrue/regexhelpeR")

# Install the multidictR package from GitHub
devtools::install_github("jogrue/multidictR")

# Install the popdictR package from GitHub
devtools::install_github("jogrue/popdictR")
```


## Example
 
```R
# My dictionary
popdictR::gruendl_terms

# All terms (also available as .ods/.csv under /data-raw)
popdictR::gruendl_dictionary_complete

# Similar to what was done in the paper ----------------------------------------

# Load packages
library(popdictR)
library(lubridate)
library(quanteda)
library(tidyverse)

# Prepare data
fbcorp <- readRDS("data/facebook.rds") %>%
  filter(date >= date("2014-01-01") & date < date("2020-02-29")) %>%
  rename(doc_id = id, text = message) %>%
fbcorp <- corpus(fbcorp)

# Run the populism dictionary on the corpus
fbresult1 <- run_popdict(fbcorp)

# Run other dictionaries on the corpus
fbresult2 <- run_other_popdicts(fbcorp, include_totals = FALSE)

# Results are the number of sentences per document that had at least one match
# with a dictionary pattern (are, supposedly, populist). Also, the total number 
# of sentences is returned in "n_sentences"

# Combine results
fbresult1 <- convert(fbresult1, to = "data.frame")
fbresult2 <- convert(fbresult2, to = "data.frame")
fbresult <- bind_cols(
  fbresult1,
  select(fbresult2, dict_rooduijn_pauwels_2011, dict_pauwels_2017)
)

# This summary groups results by country and party and then gives us the
# percentage of populist sentences per party.
summary <- fbresult %>%
  group_by(actor_country, party) %>%
  summarize(
    sentences   = sum(n_sentences),
    gruendl     = sum(dict_gruendl_2020) / sentences * 100,
    pauwels     = sum(dict_pauwels_2017) / sentences * 100,
    rooduijn    = sum(dict_rooduijn_pauwels_2011) / sentences * 100,
    popu_list   = first(popu_list)
  ) %>%
  ungroup
summary
```


## Status

The package includes the dictionary as published and worked well for my 
particular use case (see example above). All functions are documented already.
However, the package has not been tested extensively. Thus, I am glad for any 
feedback or issues you encounter. A new version (1.0) is planned for the end of 
March 2021. Some of the issues I plan on addressing:

* More thorough testing
* Better documentation
* Highlighting use cases for this package


## Cite

Gründl, J. (2020). Populist ideas on social media: A dictionary-based 
measurement of populist communication. _New Media & Society_. Advance online 
publication. 
[https://doi.org/10.1177/1461444820976970](https://doi.org/10.1177/1461444820976970)

Gründl, J. (2020). _popdictR_ (R package). 
[https://github.com/jogrue/popdictR](https://github.com/jogrue/popdictR)
