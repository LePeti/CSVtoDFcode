# CSVtoDFcode

Simply create test data by generating data frame R code from a CSV: Use your preferred visual tabular data manipulation app (e.g. Excel, Numbers, etc.) and/or your clipboard to simply generate data frame or data.table code for tests or examples.

## What problem does this package solve?
  
  + Tables are hard to create in a text editor
  + Test cases and test data are hard to think about when represented as code
  + Test data generator packages don't provide you with the table generating code (coming soon)

## How does this package solve it?

  + Create test data in Excel (or other editor)
  + Save it as CSV or put it on the clipboard
  + Run `generateDfCodeFromCsv` to generate the code which re-creates the data frame you've just put together in Excel
  + Copy it into your test

## How to install
  
  + Install from github: `devtools::install_github("https://github.com/LePeti/CSVtoDFcode")`
