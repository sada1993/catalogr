test_that("read_files", {
  expect_equal(
    read_files("example_load_data.R"),
    c(
      "# This is an example file",
      "#' This is an ROxygen2 comment",
      "#> authors: [\"akash\", \"Sam\"]",
      "#> database: [\"staging\", \"live\"]",
      "",
      "my_fun <- function() {",
      "  println(\"Hello World\")",
      "}"
    )
  )
})
