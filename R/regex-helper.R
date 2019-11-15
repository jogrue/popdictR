# Header -----------------------------------------------------------------------
#
# Script name: regex-helper.R
#
# Purpose of script: Functions to help when working with regex dictionaries
#
# Author: Johann Gründl
# Email: mail@johanngruendl.at
#
# Date created: 2019-11-14
#
# ******************************************************************************

# Change a regex pattern to greedy behavior, the ? is removed in all instances
# of ??, +?, *?, {n,}?, {n,m}?
make_all_regex_greedy <- function(pattern) {
  stringr::str_replace_all(pattern,
                           "(?<!\\\\)([\\?\\*\\+\\}])\\?",
                           "\\1")
}

# Change a regex pattern to lazy behavior, repetition operators are replaced by
# their greedy versions: ??, +?, *?, {n,}?, {n,m}?
make_all_regex_lazy <- function(pattern) {
  pattern <-
    stringr::str_replace_all(pattern,
                             "(?<!\\\\)([\\*\\+\\}])(?!\\?)",
                             "\\1\\?")
  pattern <-
    stringr::str_replace_all(pattern,
                             "(?<![\\?\\*\\+\\}\\\\])(\\?)(?!\\?)",
                             "\\1\\?")
  return(pattern)
}

# Optimize regular expressions
optimize_regex <- function(patterns) {
  patterns <- stringr::str_replace_all(patterns, "(^|$)", "\\\\b")
  patterns <- stringr::str_replace_all(
    string = patterns,
    pattern = fixed("\\b(.*)"),
    replacement = ""
  )
  patterns <- stringr::str_replace_all(
    string = patterns,
    pattern = fixed("(.*)\\b"),
    replacement = ""
  )
  return(patterns)
}

# Greedy repetition operators are replaced by lazy ones and vice versa.
switch_regex_greedy_lazy <- function(pattern) {
  # replace lazy expressions' ? with _LAZZZY170605_
  pattern <- stringr::str_replace_all(pattern,
                                      "((?<!\\\\)[\\?\\*\\+\\}])(\\?)",
                                      "\\1_LAZZZY170605_")
  # replace greedy expressions with lazy version
  pattern <- stringr::str_replace_all(
    pattern,
    "((?<!\\\\)[\\?\\*\\+\\}])(?!_LAZZZY170605_)",
    "\\1?"
  )
  # remove the lazy marker
  pattern <- stringr::str_replace_all(string = pattern,
                                      pattern = fixed("_LAZZZY170605_",
                                                      ignore_case = FALSE),
                                      replacement = "")
  return(pattern)
}
