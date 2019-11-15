# Header -----------------------------------------------------------------------
#
# Script name:
#
# Purpose of script:
#
# Author: Johann Gründl
# Email: mail@johanngruendl.at
#
# Date created: 2019-11-11
#
# ******************************************************************************



# Replace separator (before, default " ") with concatenator (after, default "_") in a text
make_compound <- function(compound, before = " ", after = "_") {
  library(stringr)
  compound <- str_replace_all(compound, before, after)
  return(compound)
}

# Replace the separator (before, default " ") with the concatenator (after, default "_") in all occurences of a regex pattern in a text.
make_compound_text <- function(text, pattern, before = " ", after = "_", lazy = TRUE, case_insensitive = TRUE) {
  library(stringr)
  if (lazy) {
    pattern <- switch_regex_greedy_lazy(pattern)
  }
  matchindices <- str_locate_all(text, regex(pattern, ignore_case = case_insensitive))
  if (length(matchindices) == 1) {
    matchindices <- matchindices[[1]]
  } else {
    stop("Not a single text provided for make_compound_text.")
  }
  if (nrow(matchindices) < 1) {return(text)}
  for (i in 1:nrow(matchindices)) {
    ind <- matchindices[i, ]
    str_sub(text, ind[1], ind[2]) <- make_compound(str_sub(text, ind[1], ind[2]), before, after)
  }
  return(text)
}

# A list of patterns (regular expressions) is applied to a single text. In pattern matches the regular separator (before, default " ") is replaced by a concatenator (after, default "_"). Only multi-word regular expressions (including the before character, default " ") are used, patterns are sorted by length and alphabet before looking them up.
make_compounds_text <- function(text, patterns, before = " ", after = "_", lazy = TRUE, case_insensitive = TRUE) {
  library(quanteda)
  library(stringr)
  if (is.dictionary(patterns)) {
    patterns <- unlist(patterns)
  }
  if (length(patterns) < 1) {
    message("No pattern was provided.")
    return(text)
  }
  patterns <- patterns[order(str_length(patterns), patterns)]
  patterns <- patterns[str_detect(patterns, before)]
  patterns <- unique(patterns)
  if (length(patterns) < 1) {
    message("No multi-word pattern was provided.")
    return(text)
  }
  for (i in patterns) {
    text <- make_compound_text(text = text, pattern = i, before = before, after = after,
                               lazy = lazy, case_insensitive = case_insensitive)
  }
  return(text)
}

# Make compounds for the whole corpus. In this function, a list of multi-word regex patterns (provided as a quanteda dictionary or list) is looked up in a corpus. The patterns are applied at a certain level (default is sentences). Separators (before, default " ") are replaced with concatenators (after, default "_") in the pattern matches.
make_compounds_corpus <- function(corpus, patterns, before = " ", after = "_",
                                  at_level = "sentences", glob = FALSE, lazy = TRUE, case_insensitive = TRUE,
                                  optimized_regex = FALSE) {
  library(quanteda)
  library(stringr)

  # Prepare patterns
  if (is.dictionary(patterns)) {
    patterns <- unlist(patterns)
  }
  if (glob) {
    message("Provided glob patterns are replaced with regex patterns.")
    patterns <- glob2rx(patterns, trim.head = TRUE, trim.tail = TRUE) %>%
      str_replace_all("^\\^", "\b") %>%
      str_replace_all("\\$$", "\b")
  }
  if (!optimized_regex) {
    patterns <- optimize_regex(patterns)
  }
  if (length(patterns) < 1) {
    warning("No pattern was provided.")
    return(corpus)
  }
  patterns <- patterns[order(str_length(patterns), patterns)]
  patterns <- patterns[str_detect(patterns, before)]
  patterns <- unique(patterns)
  if (length(patterns) < 1) {
    warning("No multi-word pattern was provided.")
    return(corpus)
  }

  # Reshape corpus to apply patterns at specified level
  old_level <- settings(corpus, "units")
  if (at_level != old_level) {
    message(paste0("Corpus is reshaped to level ", at_level))
    corpus <- corpus_reshape(corpus, to = at_level)
  }

  # Make compounds for the whole corpus for every pattern
  patterntimes <- rep(NA_real_, length(patterns))
  names(patterntimes) <- patterns
  for (i in 1:length(patterns)) {
    time <- Sys.time()
    message(paste0("Run compound generation for whole corpus with pattern: ", i, "/", length(patterns)))
    texts(corpus) <- sapply(texts(corpus), make_compound_text, pattern = patterns[i], before = before,
                            after = after, lazy = lazy,
                            case_insensitive = case_insensitive)
    time <- Sys.time() - time
    patterntimes[i] <- time
    message(paste0(patterns[i], " took ", time, " to complete. ",
                   "The average time for a pattern is now: ", mean(patterntimes, na.rm = TRUE),
                   " The remaining ", length(patterns) - i, " patterns should complete in ",
                   mean(patterntimes, na.rm = TRUE)*(length(patterns) - i)))
  }
  print(patterntimes)
  # Return corpus to original shape
  if (old_level != at_level) {
    message(paste0("Corpus is returned to level ", old_level))
    corpus <- corpus_reshape(corpus, to = old_level)
  }

  # Return finished corpus
  return(corpus)
}


# Creates tokens from a corpus, using this function makes sure that the same
# settings are applied all the time.
# The dictionary is used to create compound tokens (n-grams).
get_pop_tokens <- function(corpus, full_dict = NULL, corpus_with_compounds = FALSE, at_level = "sentences", regex = FALSE) {
  library(quanteda)
  library(dplyr)

  if (!corpus_with_compounds & is.null(full_dict)) {
    warning("The corpus does not include compounds, but no dictionary for compound creation has been provided.")
  }

  # Only generate compounds in corpus (again) if corpus_with_compounds == FALSE
  if (!corpus_with_compounds & !is.null(full_dict)) {
    # Compounds are created
    corpus <- make_compounds_corpus(corpus = corpus, patterns = full_dict, before = " ", after = "_",
                                    at_level = at_level, glob = !regex, lazy = TRUE, case_insensitive = TRUE)
  }

  ### Here settings for the tokenizer should be made ###
  toks <- tokens(corpus,
                 remove_numbers = TRUE,
                 remove_punct = TRUE,
                 remove_symbols = TRUE,
                 remove_separators = TRUE,
                 remove_twitter = TRUE,
                 remove_hyphens = FALSE,
                 remove_url = TRUE,
                 verbose = TRUE) %>%
    tokens_tolower()
  return(toks)
}

# # OLD VERSION
# # Creates tokens from a corpus, using this function makes sure that the same
# # settings are applied all the time.
# # The dictionary is used to create compound tokens (n-grams).
# get_pop_tokens <- function(corpus, full_dict, regex = FALSE) {
#   library(quanteda)
#   library(dplyr)
#
#   if (regex) { valuetype = "regex" } else { valuetype = "glob" }
#
#   # If dictionary is a Quanteda dictionary it is unlisted.
#   if (is.dictionary(full_dict)) {
#     full_dict <- unlist(full_dict)
#   }
#
#   # Only keep multi-word terms
#   dict_compounds <- full_dict[str_detect(full_dict, " ")] %>%
#     unique() %>%
#     list(comp = .) %>%
#     dictionary()
#
#   # # Regular expressions should stop at sentences
#   # if (regex) {
#   #   corpus <- corpus_reshape(to = "sentences")
#   # }
#
#   ### Here settings for the tokenizer should be made ###
#   toks <- tokens(corpus,
#                  remove_numbers = TRUE,
#                  remove_punct = TRUE,
#                  remove_symbols = TRUE,
#                  remove_separators = TRUE,
#                  remove_twitter = TRUE,
#                  remove_hyphens = FALSE,
#                  remove_url = TRUE,
#                  verbose = TRUE) %>%
#     tokens_tolower()
#
#
#   # DEBUG single compounds
#   # dict_comp_full <- unlist(dict_compounds)
#   # for(i in dict_comp_full) {
#   #   print(i)
#   #   tmp <- toks[1:200]
#   #   tokens_compound(tmp, pattern = dictionary(list(comp = i)),
#   #                   concatenator = "_",
#   #                   # case_insensitive = TRUE,
#   #                   valuetype = valuetype,
#   #                   join = FALSE)
#   # }
#
#
#
#   # Compound tokens are created in a loop
#   max <- length(toks)
#   step <- 500
#   first <- 1 - step
#   comp_toks <- NULL
#   repeat {
#     first <- first + step
#     last <- first + step - 1
#     if (last > max) {
#       last <- max
#     }
#     tmp <- toks[first:last]
#     print(paste0("Creating compounds for elements ", first, " to ", last, "."))
#     tmp <- tokens_compound(tmp, pattern = dict_compounds,
#                            concatenator = "_",
#                            # case_insensitive = TRUE,
#                            valuetype = valuetype,
#                            join = FALSE)
#     if (is.null(comp_toks)) {
#       comp_toks <- tmp
#     } else {
#       comp_toks <- c(comp_toks, tmp)
#     }
#     if (last == max) {
#       break
#     }
#   }
#   docvars(comp_toks) <- docvars(corpus)
#   return(comp_toks)
# }

# Creates a dfm from a corpus, using this function makes sure that the same
# settings are applied all the time.
# The dictionary is used to create compound tokens (n-grams).
get_pop_dfm <- function(corpus, full_dict = NULL, corpus_with_compounds = FALSE, stopwords = NULL,
                        at_level = "sentences", regex = FALSE) {
  library(quanteda)
  library(dplyr)
  get_pop_tokens(corpus = corpus, full_dict = full_dict,
                 corpus_with_compounds = corpus_with_compounds,
                 at_level = at_level, regex = regex) %>%
    pop_tokens_to_dfm(stopwords = stopwords) %>%
    return()
}

pop_tokens_to_dfm <- function(tokens, stopwords = NULL) {
  library(quanteda)
  library(dplyr)
  ### Here settings for dfm creation could be changed ###
  dfm(x = tokens,
      tolower = TRUE,
      remove = stopwords,
      verbose = TRUE) %>%
    return()
}

get_pop_kwic <- function(tokens, pattern, window = 25, regex = FALSE, step = 10000, ...) {
  if (regex) { valuetype = "regex" } else { valuetype = "glob" }

  # kwic are created in a loop
  max <- length(tokens)
  # step <- 10000
  first <- 1 - step
  kwic <- NULL
  repeat {
    first <- first + step
    last <- first + step - 1
    if (last > max) {
      last <- max
    }
    tmp <- tokens[first:last]
    print(paste0("Creating kwic for elements ", first, " to ", last, "."))
    tmp <- quanteda::kwic(tmp,
                          pattern = pattern,
                          window = window,
                          valuetype = valuetype)
    if (is.null(kwic)) {
      kwic <- tmp
    } else {
      kwic <- dplyr::bind_rows(kwic, tmp)
    }
    if (last == max) {
      break
    }
  }

  return(kwic)
}

# Transforms a dictionary so that each search term is its own dictionary
every_term_a_dict <- function(dict) {
  tmp <- unlist(dict)
  names(tmp) <- tmp
  tmp <- sapply(tmp, list)
  return(dictionary(tmp))
}
