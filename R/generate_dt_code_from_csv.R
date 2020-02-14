#' Generate data.frame code from CSV
#'
#' @param csv_file_path character, file path to the .csv file
#' @param object_type character, the object type for which to create the code.
#'   Possible values are either "data.frame" (default) or "data.table"
#'
#' @return a character, which can be used to define a `data.frame` or `data.table`.
#'   Also prints the return value as a formatted string.
#'   This message is also copied to the user's clipboard.
#'
#' @examples \dontrun{
#'    csv_path <- tempfile("foo.csv")
#'    write.csv(
#'        data.frame(foo = c(1, 2, 3), bar = c("four", 5, "six")),
#'        csv_path, row.names = FALSE
#'    )
#'    generateDfCodeFromCsv(csv_path)
#'
#'    unlink(csv_path)
#' }
#'
#' @export
generateDfCodeFromCsv <- function(csv_file_path = NULL,
                                  object_type = c("data.frame", "data.table")) {
    if (is.null(csv_file_path)) {
        data <- clipr::read_clip_tbl(
            x = clipr::read_clip(allow_non_interactive = TRUE),
            stringsAsFactors = FALSE
        )
    } else {
        data <- read.csv(csv_file_path, sep = ",", stringsAsFactors = FALSE)
    }

    object_type <- match.arg(object_type)

    col_names <- names(data)
    col_code <- lapply(col_names, function(x) generateVectorCodeFromOneColumn(x, data[[x]]))

    data_code_for_message <- paste0(
        object_type, "(\n    ",
            paste(col_code, collapse = ",\n    "),
        "\n)"
    )

    clipr::write_clip(data_code_for_message, allow_non_interactive = TRUE)
    message("The below is also on your clipboard:")
    message(data_code_for_message)


    data_code <- paste0(
        object_type, "(",
            paste(col_code, collapse = ", "),
        ")"
    )
    invisible(data_code)
}

generateVectorCodeFromOneColumn <- function(col_name, col_values) {
    paste0(
        col_name,
        " = c(",
        paste(addQuotationAroundCharacterVector(col_values), collapse = ", "),
        ")"
    )
}

addQuotationAroundCharacterVector <- function(x) {
    sapply(
        x, function(y) ifelse(is.character(y), paste0('"', y, '"'), y),
        USE.NAMES = FALSE
    )
}

# generateDfCodeFromCsv("inst/simple_text_and_num_col.csv")
# generateDfCodeFromCsv()
