## Header ----------------------------------------------------------------------
##
## Script name: data.R
##
## Purpose of script: Documentation of included data
##
## Author: Johann Gründl
## Email: mail@johanngruendl.at
##
## Date created: 2019-11-05
##
## *****************************************************************************


# Existing dictionaries and terms ----------------------------------------------

#' Existing populism dictionaries.
#'
#' A dataset containing various populism dictionaries. Usually, you do not have
#' to load this dataset.
#'
#' @docType data
#'
#' @format A data frame with 56 rows and 6 variables:
#' \describe{
#'   \item{pauwels-2011}{terms used by Pauwels (2011)}
#'   \item{rooduijn-2011-german}{German terms used by Rooduijn and Pauwels (2011)}
#'   \item{rooduijn-2011-english}{English terms used by Rooduijn and Pauwels (2011)}
#'   \item{bonikowski-2016-american}{terms used by Bonikowski and Gidron (2016b)}
#'   \item{bonikowski-2016-european}{terms used by Bonikowski and Gidron (2016a)}
#'   \item{pauwels-2017}{terms used by Pauwels (2017)}
#' }
#' @references
#' Bonikowski, B., & Gidron, N. (2016a). Populism in legislative discourse: Evidence from the European Parliament, 1999–2004 [Working paper]. Retrieved from \href{https://scholar.harvard.edu/files/bonikowski/files/bonikowski_and_gidron_-_populist_claims-making_in_legislative_discourse.pdf}{https://scholar.harvard.edu/files/bonikowski/files/bonikowski_and_gidron_-_populist_claims-making_in_legislative_discourse.pdf}
#'
#' Bonikowski, B., & Gidron, N. (2016b). The Populist Style in American Politics: Presidential Campaign Discourse, 1952–1996. \emph{Social Forces}, 94(4), 1593–1621. \href{https://doi.org/10.1093/sf/sov120}{https://doi.org/10.1093/sf/sov120}
#'
#' Pauwels, T. (2011). Measuring populism: A quantitative text analysis of party literature in Belgium. \emph{Journal of Elections, Public Opinion and Parties}, 21(1), 97–119. \href{https://doi.org/10.1080/17457289.2011.539483}{https://doi.org/10.1080/17457289.2011.539483}
#'
#' Pauwels, T. (2017). Measuring populism: A review of current approaches. In R. Heinisch, C. Holtz-Bacha, & O. Mazzoleni (Eds.), \emph{Political populism: A handbook} (pp. 123–136). Baden-Baden: Nomos.
#'
#' Rooduijn, M., & Pauwels, T. (2011). Measuring populism: Comparing two methods of content analysis. \emph{West European Politics}, 34(6), 1272–1283. \href{https://doi.org/10.1080/01402382.2011.616665}{https://doi.org/10.1080/01402382.2011.616665}
"other_dictionaries"


#' Pauwels' (2017) dictionary terms.
#'
#' A character vector containing the terms suggested by Pauwels (2017).
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Pauwels, T. (2017). Measuring populism: A review of current approaches. In R. Heinisch, C. Holtz-Bacha, & O. Mazzoleni (Eds.), \emph{Political populism: A handbook} (pp. 123–136). Baden-Baden: Nomos.
"pauwels_2017_terms"


#' Rooduijn and Pauwels' (2011) dictionary terms.
#'
#' A character vector containing the terms suggested by Rooduijn and Pauwels
#' (2017).
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Rooduijn, M., & Pauwels, T. (2011). Measuring populism: Comparing two methods of content analysis. \emph{West European Politics}, 34(6), 1272–1283. \href{https://doi.org/10.1080/01402382.2011.616665}{https://doi.org/10.1080/01402382.2011.616665}
"rooduijn_2011_german_terms"


#' Pauwels' (2017) dictionary terms.
#'
#' A character vector containing the terms suggested by Pauwels (2017).
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Pauwels, T. (2017). Measuring populism: A review of current approaches. In R. Heinisch, C. Holtz-Bacha, & O. Mazzoleni (Eds.), \emph{Political populism: A handbook} (pp. 123–136). Baden-Baden: Nomos.
"pauwels_2017_terms"


# Gründl's dictionary and terms ------------------------------------------------

#' Complete dictionary dataset by Gründl.
#'
#' A dataset containing all terms ever considered for inclusion in Gründl's
#' German populism dictionary. This dataset also includes context information,
#' further classification of words, etc. You should never have to load this
#' dataset directly.
#'
#' @docType data
#'
#' @format A data frame.
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_dictionary_complete"


#' All regex terms by Gründl.
#'
#' A character vector containing all the terms (excluding glob-style wildcards)
#' ever considered for inclusion in Gründl's German populism dictionary. You
#' should never have to load this vector directly.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_all_regex_terms"


#' Current terms in Gründl's populism dictionary.
#'
#' A character vector containing all terms currently selected for inclusion in
#' Gründl's German populism dictionary.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_terms"


#' Current terms in Gründl's populism dictionary for news media.
#'
#' A character vector containing all terms currently selected for inclusion in
#' Gründl's German populism dictionary for news media. These terms do not
#' include some of the terms that only precisely hint at populist ideas if used
#' by politicians or parties. Warning: This version of the dictionary was never
#' tested or validated.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_terms_media_only"


#' Current terms in Gründl's dictionary for conflictive populism.
#'
#' A character vector containing all terms currently selected for inclusion in
#' Gründl's German populism dictionary that indicate conflictive (against the
#' elites) populist messages. Warning: This version of the dictionary was never
#' tested or validated.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_terms_conflictive"


#' Current terms in Gründl's dictionary for conflictive populism in news media.
#'
#' A character vector containing all terms currently selected for inclusion in
#' Gründl's German populism dictionary for news media that indicate conflictive
#' (against the elites) populist messages. These terms do not include some of
#' the terms that only precisely hint at populist ideas if used by politicians
#' or parties. Warning: This version of the dictionary was never
#' tested or validated.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_terms_conflictive_media_only"


#' Current terms in Gründl's dictionary for advocative populism.
#'
#' A character vector containing all terms currently selected for inclusion in
#' Gründl's German populism dictionary that indicate advocative (for the
#' people) populist messages. Warning: This version of the dictionary was never
#' tested or validated.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_terms_advocative"


#' Current terms in Gründl's dictionary for advocative populism in news media.
#'
#' A character vector containing all terms currently selected for inclusion in
#' Gründl's German populism dictionary for news media that indicate advocative
#' (for the people) populist messages. These terms do not include some of
#' the terms that only precisely hint at populist ideas if used by politicians
#' or parties. Warning: This version of the dictionary was never
#' tested or validated.
#'
#' @docType data
#'
#' @format A character vector
#' @references
#' Gründl, J. (2020). Populist ideas on social media: A dictionary-based
#' measurement of populist communication. \emph{New Media & Society}. Advance
#' online publication.
#' \href{https://doi.org/10.1177/1461444820976970}{https://doi.org/10.1177/1461444820976970}
"gruendl_terms_advocative_media_only"
