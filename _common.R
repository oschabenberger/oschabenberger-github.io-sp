
knitr::opts_chunk$set(
    message = FALSE,
    warning = FALSE,
    cache = FALSE,
    fig.align = 'center',
    out.width = "90%"
)


duckload <- function(tableName, whereClause=NULL, dbName="ads.ddb") {
    if (!is.null(tableName)) {
        if (!("duckdb" %in% (.packages()))) {
            suppressWarnings(library("duckdb"))
            message("duckdb library was loaded to execute duckload().")
        }
        con <- dbConnect(duckdb(), dbdir=dbName, read_only=TRUE)
        query_string <- paste("SELECT * from ", tableName)
        if (!is.null(whereClause)) {
            query_string <- paste(query_string, " WHERE ", whereClause)
        }
        df_ <- dbGetQuery(con, query_string)
        dbDisconnect(con)
        return (df_)
    } else {
        return (NULL)
    }
}

