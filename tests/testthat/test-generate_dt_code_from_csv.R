context("test-generate_dt_code_from_csv")

describe("generateDfCodeFromCsv()", {
    it("returns code for two numeric columns", {
        csv_path <- here::here("inst", "two_num_col.csv")
        csv_df <- read.csv(csv_path)

        expect_equal(
            eval(parse(text = generateDfCodeFromCsv(csv_path))),
            csv_df
        )
    })

    it("can read the csv data from the clipboard", {
        csv_path <- here::here("inst", "two_num_col.csv")
        csv_df <- read.csv(csv_path)
        clipr::write_clip(csv_df, allow_non_interactive = TRUE)

        expect_equal(
            eval(parse(text = generateDfCodeFromCsv())),
            csv_df
        )
    })

    it("can generate data.table too", {
        csv_path <- here::here("inst", "two_num_col.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path, object_type = "data.table")

        expect_equal(
            class(eval(parse(text = paste0("data.table::", csv_code))))[1],
            "data.table"
        )
    })

    it("returns a nicely formatted message", {
        csv_path <- here::here("inst", "two_num_col.csv")
        csv_df <- read.csv(csv_path)

        expected_csv_code_message <- (
            "data.frame(\n    foo = c(1, 2, 3),\n    bar = c(4, 5, 6)\n)"
        )

        expect_message(
            generateDfCodeFromCsv(csv_path),
            message(expected_csv_code_message)
        )
    })

    it("returns unformatted return value", {
        csv_path <- here::here("inst", "two_num_col.csv")
        csv_df <- read.csv(csv_path)

        expected_csv_code <- "data.frame(foo = c(1, 2, 3), bar = c(4, 5, 6))"

        expect_equal(
            generateDfCodeFromCsv(csv_path),
            expected_csv_code
        )
    })

    it("returns code for simple text columns", {
        csv_path <- here::here("inst", "simple_text_and_num_col.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path)

        expect_equal(
            eval(parse(text = csv_code)),
            csv_df
        )
    })

    it("returns code for complex text columns", {
        csv_path <- here::here("inst", "complex_text_and_num_col.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path)

        expect_equal(
            eval(parse(text = csv_code)),
            csv_df
        )
    })

    it("represents missing values as NAs for num cols", {
        csv_path <- here::here("inst", "complex_text_and_num_col_w_missing_num_value.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path)

        expect_equal(
            eval(parse(text = csv_code)),
            csv_df
        )
    })

    it("represents missing values as empty string for string cols", {
        csv_path <- here::here("inst", "complex_text_and_num_col_w_missing_char_value.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path)

        expect_equal(
            eval(parse(text = csv_code)),
            csv_df
        )
    })
})
