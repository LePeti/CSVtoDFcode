generateDfCodeFromCsv <- function(data_path = NULL) {
    if (is.null(data_path)) {
        data <- clipr::read_clip_tbl()
    } else {
        data <- read.csv(data_path, sep = ",")
    }

    col_names <- names(data)
    bar <- lapply(col_names, function(x) generateVectorDefinitionStringForOneColumn(x, data[[x]]))
    data_code <- paste0(
        "data.frame(",
            paste(bar, collapse = ", "),
        ")"
    )

    clipr::write_clip(data_code, allow_non_interactive = TRUE)
    cat(data_code)
    invisible(data_code)
}

# generateDfCodeFromCsv("inst/one_num_col.csv")
# generateDfCodeFromCsv()

foo <- function(col_name, col_values) {
    paste0(col_name, " = c(", paste(col_values, collapse = ", "), ")")
}
