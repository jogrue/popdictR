# ------------------------------------------------------------------------------
#
# Script name: run-popdictr.R
#
# Purpose of script: Runs my German populism dictionary (and others as well)
#
# Author: Johann Gründl
# Email: mail@johanngruendl.at
#
# Date created: 2020-11-20
# Date updated: 2020-11-20
#
# ******************************************************************************

#' Run a German populism dictionary.
#'
#' This function runs a German populism dictionary (Gründl, 2020). It calls
#' multidictR::run_multidict. See there for more technical details. Internally,
#' the package uses stringr::str_replace_all to replace pattern
#' matches with a random string before then using quanteda to look this string
#' up in the corpus.
#'
#' @param corpus A quanteda corpus object or something that can be transformed
#' to a corpus by quanteda::corpus(), for example, a simple character vector
#' @param dict_version Defaults to "current" which is currently the only
#' supported version of the dictionary.
#' @param at_level At which level should patterns be applied. Possible values
#' are "documents", "sentences", or "paragraphs". Defaults to "sentences" as in
#' Gründl's (2020) paper.
#' @param return_value How should the value be returned? Possible values
#' include "count", "binary", "prop", "count_at_level", or "prop_at_level". You
#' get the results from the dictionary at the document level. "count"
#' gives the simple frequency of dictionary hits in each document.
#' "count_at_level" (the default) gives you the number of sentences or
#' paragraphs in a document where there was at least one pattern match (as in
#' Gründl, 2020). Together with the include_totals parameter "count" and
#' "count_at_level" give you the most flexibility to work with the results.
#' "binary" returns 0 or 1, depending on whether there was at least one pattern
#' match in the document. "prop" is the
#' proportion of pattern matches relative to the total number of tokens in the
#' document. "prop_at_level" gives you the proportion of sentences or
#' paragraphs (in a document) where a pattern match was found.
#' @param include_totals Should the number of sentences (as "n_sentences") and
#' number of tokens (as "n_tokens") per document also be returned? Defaults to
#' TRUE.
#' @param return_result_only If TRUE, a data.frame containing the results will
#' be returned. If FALSE (the default), you will get the provided corpus with
#' the results attached as new columns.
#' @param custom_replacement Internally, this function replaces pattern matches
#' with a random string (containing 40 random letters and 10 random numbers)
#' before running quanteda's dictionary lookup function on the corpus. The
#' random string should be unique and there is usually no need to set a custom
#' string.
#' @param remove Forwarded to quanteda's dfm function. A list of stopwords
#' which are removed from the dfm before running the dictionary.
#'
#' @return Returns the results of running the dictionary. If return_result_only
#' is set, you will get a data.frame with only the results. Otherwise, you the
#' results will be bound to the corpus as new columns. If you only provided
#' texts, the only other column will be these texts of course (variable x). If
#' you provided a quanteda corpus, the results will be stored as variables in
#' the docvars.
#'
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
#'
#' @export
run_popdict <- function(
  corpus,
  dict_version = "current",
  at_level = "sentences",
  return_value = "count_at_level",
  include_totals = TRUE,
  return_result_only = FALSE,
  custom_replacement,
  remove = NULL
) {
  dict <- switch (dict_version,
    "current" = popdictR::gruendl_terms
  )
  return(
    multidictR::run_multidict(
      corpus = corpus,
      dict = dict,
      at_level = at_level,
      return_value = return_value,
      include_totals = include_totals,
      return_result_only = return_result_only,
      pattern_type = "regex",
      case_insensitive = TRUE,
      regex_optimize = TRUE,
      regex_make_greedy = FALSE,
      regex_make_lazy = TRUE,
      dict_name = "dict_gruendl_2020",
      custom_replacement = custom_replacement,
      tolower = TRUE,
      stem = FALSE,
      remove = remove,
      what = "word",
      remove_punct = TRUE,
      remove_symbols = TRUE,
      remove_numbers = TRUE,
      remove_url = TRUE,
      remove_separators = TRUE,
      split_hyphens = FALSE,
      include_docvars = TRUE
    )
  )
}

#' Run other German populism dictionaries.
#'
#' This function runs a other, alternative, German populism dictionaries
#' (Pauwels, 2017; Rooduijn and Pauwels, 2011). To run the dictionary proposed
#' by Gründl in the paper from 2020, run popdictR::run_popdict instead.
#'
#' This function calls multidictR::run_non_multidict. See there for more
#' technical details.
#'
#' @param corpus A quanteda corpus object or something that can be transformed
#' to a corpus by quanteda::corpus(), for example, a simple character vector
#' @param dict Could be either "rooduijn_pauwels_2011" for Rooduijn and Pauwels'
#'  suggestion (2011) or "pauwels_2017" for Pauwels (2017). Defaults to "all"
#' which runs both available dictionaries.
#' @param at_level At which level should patterns be applied. Possible values
#' are "documents", "sentences", or "paragraphs". Defaults to "sentences" as in
#' Gründl's (2020) paper.
#' @param return_value How should the value be returned? Possible values
#' include "count", "binary", "prop", "count_at_level", or "prop_at_level". You
#' get the results from the dictionary at the document level. "count"
#' gives the simple frequency of dictionary hits in each document.
#' "count_at_level" (the default) gives you the number of sentences or
#' paragraphs in a document where there was at least one pattern match (as in
#' Gründl, 2020). Together with the include_totals parameter "count" and
#' "count_at_level" give you the most flexibility to work with the results.
#' "binary" returns 0 or 1, depending on whether there was at least one pattern
#' match in the document. "prop" is the
#' proportion of pattern matches relative to the total number of tokens in the
#' document. "prop_at_level" gives you the proportion of sentences or
#' paragraphs (in a document) where a pattern match was found.
#' @param include_totals Should the number of sentences (as "n_sentences") and
#' number of tokens (as "n_tokens") per document also be returned? Defaults to
#' TRUE.
#' @param return_result_only If TRUE, a data.frame containing the results will
#' be returned. If FALSE (the default), you will get the provided corpus with
#' the results attached as new columns.
#' @param remove Forwarded to quanteda's dfm function. A list of stopwords
#' which are removed from the dfm before running the dictionary.
#'
#' @return Returns the results of running the dictionary. If return_result_only
#' is set, you will get a data.frame with only the results. Otherwise, you the
#' results will be bound to the corpus as new columns. If you only provided
#' texts, the only other column will be these texts of course (variable x). If
#' you provided a quanteda corpus, the results will be stored as variables in
#' the docvars.
#'
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
#'
#' Pauwels, T. (2017). Measuring populism: A review of current approaches. In
#' R. Heinisch, C. Holtz-Bacha, & O. Mazzoleni (Eds.), \emph{Political
#' populism: A handbook} (pp. 123–136). Baden-Baden: Nomos.
#'
#' Rooduijn, M., & Pauwels, T. (2011). Measuring populism: Comparing two
#' methods of content analysis. \emph{West European Politics}, 34(6),
#' 1272–1283.
#' \href{https://doi.org/10.1080/01402382.2011.616665}{https://doi.org/10.1080/01402382.2011.616665}
#'
#' @export
run_other_popdicts <- function(
  corpus,
  dict = c("all", "rooduijn_pauwels_2011", "pauwels_2017"),
  at_level = "sentences",
  return_value = "count_at_level",
  include_totals = TRUE,
  return_result_only = FALSE,
  remove = NULL
) {
  # Check corpus
  if (missing(corpus)) {
    stop("You need to provide a text corpus.")
  }
  # Check dictionary
  if (!is.character(dict)) {
    stop("You have to provide the dictionary argument as a string.")
  }
  dict <- dict[1]
  if (!(dict %in% c("all", "rooduijn_pauwels_2011", "pauwels_2017"))) {
    stop(paste0('You have to select an included dictionary (currently either ',
                '"rooduijn_pauwels_2011" for the dictionary proposed by ',
                'Rooduijn & Pauwels (2011) or "pauwels_2017" for the ',
                'dictionary proposed by Pauwels (2017). Alternatively, you ',
                'could choose "all" for both dictionaries.'))
  }
  rooduijn2011 <- FALSE
  pauwels2017 <- FALSE
  if (dict == "rooduijn_pauwels_2011") {
    rooduijn2011 <- TRUE
    pauwels2017 <- FALSE
  }
  if (dict == "pauwels_2017") {
    rooduijn2011 <- FALSE
    pauwels2017 <- TRUE
  }
  if (dict == "all") {
    rooduijn2011 <- TRUE
    pauwels2017 <- TRUE
  }
  if (rooduijn2011 & !pauwels2017) {
    return(
      multidictR::run_non_multidict(
        corpus = corpus,
        dict = popdictR::rooduijn_2011_german_terms,
        at_level = at_level,
        return_value = return_value,
        include_totals = include_totals,
        return_result_only = return_result_only,
        pattern_type = "glob",
        case_insensitive = TRUE,
        regex_optimize = FALSE,
        regex_make_greedy = FALSE,
        regex_make_lazy = FALSE,
        dict_name = "dict_rooduijn_pauwels_2011",
        tolower = TRUE,
        stem = FALSE,
        remove = remove,
        what = "word",
        remove_punct = TRUE,
        remove_symbols = TRUE,
        remove_numbers = TRUE,
        remove_url = TRUE,
        remove_separators = TRUE,
        split_hyphens = FALSE,
        include_docvars = TRUE
      )
    )
  }
  if (!rooduijn2011 & pauwels2017) {
    return(
      multidictR::run_non_multidict(
        corpus = corpus,
        dict = popdictR::pauwels_2017_terms,
        at_level = at_level,
        return_value = return_value,
        include_totals = include_totals,
        return_result_only = return_result_only,
        pattern_type = "glob",
        case_insensitive = TRUE,
        regex_optimize = FALSE,
        regex_make_greedy = FALSE,
        regex_make_lazy = FALSE,
        dict_name = "dict_pauwels_2017",
        tolower = TRUE,
        stem = FALSE,
        remove = remove,
        what = "word",
        remove_punct = TRUE,
        remove_symbols = TRUE,
        remove_numbers = TRUE,
        remove_url = TRUE,
        remove_separators = TRUE,
        split_hyphens = FALSE,
        include_docvars = TRUE
      )
    )
  }
  if (rooduijn2011 & pauwels2017) {
    result1 <- multidictR::run_non_multidict(
      corpus = corpus,
      dict = popdictR::rooduijn_2011_german_terms,
      at_level = at_level,
      return_value = return_value,
      include_totals = include_totals,
      return_result_only = return_result_only,
      pattern_type = "glob",
      case_insensitive = TRUE,
      regex_optimize = FALSE,
      regex_make_greedy = FALSE,
      regex_make_lazy = FALSE,
      dict_name = "dict_rooduijn_pauwels_2011",
      tolower = TRUE,
      stem = FALSE,
      remove = remove,
      what = "word",
      remove_punct = TRUE,
      remove_symbols = TRUE,
      remove_numbers = TRUE,
      remove_url = TRUE,
      remove_separators = TRUE,
      split_hyphens = FALSE,
      include_docvars = TRUE
    )
    result2 <- multidictR::run_non_multidict(
      corpus = corpus,
      dict = popdictR::pauwels_2017_terms,
      at_level = at_level,
      return_value = return_value,
      include_totals = include_totals,
      return_result_only = TRUE,
      pattern_type = "glob",
      case_insensitive = TRUE,
      regex_optimize = FALSE,
      regex_make_greedy = FALSE,
      regex_make_lazy = FALSE,
      dict_name = "dict_pauwels_2017",
      tolower = TRUE,
      stem = FALSE,
      remove = remove,
      what = "word",
      remove_punct = TRUE,
      remove_symbols = TRUE,
      remove_numbers = TRUE,
      remove_url = TRUE,
      remove_separators = TRUE,
      split_hyphens = FALSE,
      include_docvars = TRUE
    )
    if (quanteda::is.corpus(result1)) {
      if (include_totals) {
        quanteda::docvars(result1, field = "n_sentences") <- NULL
        quanteda::docvars(result1, field = "n_tokens") <- NULL
      }
      quanteda::docvars(result1) <- dplyr::bind_cols(
        quanteda::docvars(result1),
        result2,
        .name_repair = "unique"
      )
    } else {
      if (include_totals) {
        result1[, "n_sentences"] <- NULL
        result1[, "n_tokens"] <- NULL
      }
      result1 <- dplyr::bind_cols(
        result1,
        result2,
        .name_repair = "unique"
      )
    }
    return(result1)
  }
  return(NULL)
}
