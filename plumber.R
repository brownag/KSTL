library(plumber)

english.env <- new.env()
spanish.env <- new.env()

if (file.exists("soiltaxonomy_12th_db_HTML_EN.Rda"))
  load("soiltaxonomy_12th_db_HTML_EN.Rda", english.env)

if (file.exists("soiltaxonomy_12th_db_HTML_SP.Rda"))
  load("soiltaxonomy_12th_db_HTML_SP.Rda", spanish.env)

#* @apiTitle Keys to Soil Taxonomy Plumber API

#* Get criteria by taxon code and language
#* @param code Taxon code to query
#* @param language Language database to use
#* @get /kstl
function(code, language) {
 res <- NULL
 if (missing(code) || nchar(code) > 5) {
     code <- "A"
 }
 if (missing(language) || nchar(language) > 2) {
    language <- "EN"
 }
 if (toupper(language) %in% c("SP", "ES")) {
   res <- list(res = spanish.env$st_db12_html[[code]])
   names(res) <- code
 } else {
   res <- list(res = english.env$st_db12_html[[code]])
   names(res) <- code
 }
 return(res)
}

