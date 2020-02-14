context("test-generate_dt_code_from_csv")

describe("generateDfCodeFromCsv()", {

    it("returns code for a single numeric column", {
        csv_path <- here::here("inst", "one_num_col.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path)

        expect_equal(
            eval(parse(text = csv_code)),
            csv_df
        )
    })

    it("returns code for two numeric columns", {
        csv_path <- here::here("inst", "two_num_col.csv")
        csv_df <- read.csv(csv_path)

        csv_code <- generateDfCodeFromCsv(csv_path)

        expect_equal(
            eval(parse(text = csv_code)),
            csv_df
        )
    })
})
