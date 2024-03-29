% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accessdb.R
\name{datasets}
\alias{datasets}
\title{Retrieve Datasets Table}
\usage{
datasets(ordered = TRUE)
}
\arguments{
\item{ordered}{logical. \code{TRUE} orders the result in the order data was entered into the database, while \code{FALSE} returns the result in a random order, to the benefit of faster query execution.}
}
\value{
A \code{\link[data.table]{data.table}} with information about the available datasets in the database.
}
\description{
This function pulls and return a table called 'DATASET' from the database.
}
\details{
The 'DATASET' table gives information about the different datasets read into the database from various sources. It provides a unique id for each dataset, the frequency of data, the minimum and maximum time coverage, when the dataset was last updated, a description, the source (matching the 'Source' column in the 'DATASOURCE' table), and an (optional) url providing direct access to the raw data.
}
\examples{
\donttest{
datasets()
}
}
\seealso{
\code{\link{datasources}}, \code{\link{series}}, \code{\link{ugatsdb}}
}
