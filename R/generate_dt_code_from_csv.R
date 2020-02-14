generateDfCodeFromCsv <- function(data_path = NULL, table_type = "data.frame") {
    if (is.null(data_path)) {
        data <- clipr::read_clip_tbl(
            x = clipr::read_clip(allow_non_interactive = TRUE)
        )
    } else {
        data <- read.csv(data_path, sep = ",")
    }

    col_names <- names(data)
    col_code <- lapply(col_names, function(x) generateVectorCodeFromOneColumn(x, data[[x]]))

    data_code_for_message <- paste0(
        table_type, "(\n    ",
            paste(col_code, collapse = ",\n    "),
        "\n)"
    )

    clipr::write_clip(data_code_for_message, allow_non_interactive = TRUE)
    message(data_code_for_message)

    data_code <- paste0(
        table_type, "(",
            paste(col_code, collapse = ", "),
        ")"
    )
    invisible(data_code)
}

# generateDfCodeFromCsv("inst/two_num_col.csv")
# generateDfCodeFromCsv()

generateVectorCodeFromOneColumn <- function(col_name, col_values) {
    paste0(col_name, " = c(", paste(col_values, collapse = ", "), ")")
}
