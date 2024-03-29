% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ugatsdb.R
\docType{package}
\name{ugatsdb-package}
\alias{ugatsdb-package}
\alias{ugatsdb}
\title{Uganda Time Series Database API}
\description{
An R API providing easy access to a relational database with macroeconomic,
financial and development related time series data for Uganda.
Overall more than 5000 series at varying frequency (daily, monthly,
quarterly, annual in fiscal or calendar years) can be accessed through
the API. The data is provided by the Bank of Uganda,
the Ugandan Ministry of Finance, Planning and Economic Development,
the IMF and the World Bank. The database is being updated once a month.
}
\section{Functions}{

Functions to retrieve tables identifying the data

\code{\link[=datasources]{datasources()}}\cr
\code{\link[=datasets]{datasets()}}\cr
\code{\link[=series]{series()}}\cr
% \code{\link[=times]{times()}}

Function to retrieve the data from the database

\code{\link[=get_data]{get_data()}}

Functions to reshape data and add temporal identifiers

\code{\link[=long2wide]{long2wide()}}\cr
\code{\link[=wide2long]{wide2long()}}\cr
\code{\link[=expand_date]{expand_date()}}

Function to export wide format data to Excel

\code{\link[=wide2excel]{wide2excel()}}\cr

Helper functions (useful esp. for common Excel formats)

\code{\link[=make_date]{make_date()}}\cr
\code{\link[=transpose_wide]{transpose_wide()}}\cr

Global Macros with core ID variables in the database

\code{\link{.IDvars}}\cr
\code{\link{.Tvars}}

Function to renew database connection without reloading the package

\code{\link[=ugatsdb_reconnect]{ugatsdb_reconnect()}}
}

\examples{
\donttest{
library(ugatsdb)
library(magrittr) # Pipe \%>\% operators
library(xts)      # Time series class and pretty plots

# Plotting daily IFEM Buying and Selling Rates from the Bank of Uganda
get_data("BOU_E", c("E_IFEM_B", "E_IFEM_S"), from = 2020) \%>\%
  as.xts \%>\% plot

library(dygraphs)

# Same generating a dynamic chart
get_data("BOU_E", c("E_IFEM_B", "E_IFEM_S"), from = 2020) \%>\%
  as.xts \%>\% dygraph

# Static plot but with legend showing variable labels
get_data("BOU_E", c("E_IFEM_B", "E_IFEM_S"), from = 2020, wide = FALSE) \%>\%
  long2wide(names_from = "Label") \%>\% as.xts \%>\%
  plot(legend.loc = "topleft")
}
}
