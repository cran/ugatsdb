# ugatsdb 0.2.3
- Package functions fail gracefully in case database is offline.

- Performance improvements to `long2wide`. 

# ugatsdb 0.2.2
- A connection to the database is only established when specific functions are called that require a database connection. 

- `make_date` can now also convert year-month strings of the form 'YYYYMNN' or 'YYYY-MNN' to R Date's. 

# ugatsdb 0.2.1
- Safer queries under unstable internet connections: each query is evaluated inside `tryCatch`, and, if it fails, 
`ugatsdb_reconnect` is called and the query is sent again. 

# ugatsdb 0.2.0
- Significant speed improvement to the `expand_date` function.

- Additional security: before each call, the database connection is checked using `DBI::dbIsValid` (inside `tryCatch`). If the connection is not valid, `ugatsdb_reconnect` is called before executing the query. 

- Fixed a bug in `transpose_wide` when data contains both numeric and categorical data (next to the date variable in the first column). In that case a list of two transposed datasets, one with the numeric data and the other with the categorical data, is returned. 

- The default date formatting for `transpose_wide` was changed from an American MM/DD/YYYY date to a British DD/MM/YYYY date, which is also the Ugandan convention of recording dates.

- Small changes and additions to the documentation. Notably, the package overview page is now called 'ugatsdb-package', with an alias 'ugatsdb'. 


# ugatsdb 0.1.7
- First release of the package in July 2021. 
