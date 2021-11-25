#' Uganda Time Series Database API
#'
#' An R API providing easy access to a relational database with macroeconomic,
#' financial and development related time series data for Uganda.
#' Overall more than 5000 series at varying frequency (daily, monthly,
#' quarterly, annual in fiscal or calendar years) can be accessed through
#' the API. The data is provided by the Bank of Uganda,
#' the Ugandan Ministry of Finance, Planning and Economic Development,
#' the IMF and the World Bank. The database is being updated once a month.
#'
#' @section Functions:
#' Functions to retrieve tables identifying the data
#'
#' \code{\link[=datasources]{datasources()}}\cr
#' \code{\link[=datasets]{datasets()}}\cr
#' \code{\link[=series]{series()}}\cr
#' % \code{\link[=times]{times()}}
#'
#' Function to retrieve the data from the database
#'
#' \code{\link[=get_data]{get_data()}}
#'
#' Functions to reshape data and add temporal identifiers
#'
#' \code{\link[=long2wide]{long2wide()}}\cr
#' \code{\link[=wide2long]{wide2long()}}\cr
#' \code{\link[=expand_date]{expand_date()}}
#'
#' Function to export wide format data to Excel
#'
#' \code{\link[=wide2excel]{wide2excel()}}\cr
#'
#' Helper functions (useful esp. for common Excel formats)
#'
#' \code{\link[=make_date]{make_date()}}\cr
#' \code{\link[=transpose_wide]{transpose_wide()}}\cr
#'
#' Global Macros with core ID variables in the database
#'
#' \code{\link{.IDvars}}\cr
#' \code{\link{.Tvars}}
#'
#' Function to renew database connection without reloading the package
#'
#' \code{\link[=ugatsdb_reconnect]{ugatsdb_reconnect()}}
#'
#' @examples \donttest{
#' library(ugatsdb)
#' library(magrittr) # Pipe %>% operators
#' library(xts)      # Time series class and pretty plots
#'
#' # Plotting daily IFEM Buying and Selling Rates from the Bank of Uganda
#' get_data("BOU_E", c("E_IFEM_B", "E_IFEM_S"), from = 2020) %>%
#'   as.xts %>% plot
#'
#' library(dygraphs)
#'
#' # Same generating a dynamic chart
#' get_data("BOU_E", c("E_IFEM_B", "E_IFEM_S"), from = 2020) %>%
#'   as.xts %>% dygraph
#'
#' # Static plot but with legend showing variable labels
#' get_data("BOU_E", c("E_IFEM_B", "E_IFEM_S"), from = 2020, wide = FALSE) %>%
#'   long2wide(names_from = "Label") %>% as.xts %>%
#'   plot(legend.loc = "topleft")
#' }
#' @docType package
#' @name ugatsdb-package
#' @aliases ugatsdb
#'
#' @importFrom utils packageVersion assignInMyNamespace
#' @importFrom stats as.formula setNames
#' @importFrom DBI dbConnect dbGetQuery dbDisconnect dbIsValid
#' @importFrom RMySQL MySQL
#' @importFrom collapse collapv ffirst fmedian funique get_vars get_vars<- date_vars add_vars add_vars<- cat_vars ss qF vlabels vlabels<- ckmatch qDT fnobs fnrow fncol unattrib namlab allNA
#' @importFrom data.table setDT fifelse melt dcast transpose setcolorder
#' @importFrom writexl write_xlsx
#'
NULL

# .onLoad <- function(libname, pkgname) {
#
#   assign(".ugatsdb_con", .connect(), envir = parent.env(environment()))
#
# }

.onAttach <- function(libname, pkgname) {

  # assign(".ugatsdb_con", .connect(), envir = parent.env(environment()))

  packageStartupMessage(paste0("ugatsdb ", packageVersion("ugatsdb"), ", see help(ugatsdb)"))

}

.onUnload <- function(libpath) {

  if(length(.ugatsdb_con)) tryCatch(dbDisconnect(.ugatsdb_con), error = function(e) cat(""))

}

.connect <- function() {
  tryCatch({

    if(isTRUE(getOption("ugatsdb_localhost"))) {
      dbConnect(MySQL(), user = 'MEPD_READ_LOCAL', password = 'C76T#pcQ',
                dbname = 'UGATSDB', host = 'localhost')
    } else {
      dbConnect(MySQL(), user = 'MEPD_READ', password = 'pFNCGG9Wq[!x*x)G',
                dbname = 'UGATSDB', port = 3306L, host = '154.72.200.20')
    }

  }, error = function(e) {
    message("Could not connect to database. Please make sure your internet connection is working, and your firewall does not block remote IP connections.")
    NULL})
}





