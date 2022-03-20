test_that("", {
  expect_equal(
    read_catalog("testdir/catalogr.yaml"),
    list(`testdir/example_catalogr.R` = list(list(
      label = "Author", value = "akash"
    ), list(
      label = "Description",
      value = "This is a test file"
    )), `testdir/example_load_data.R` = list(
      list(label = "authors", value = c("\"akash\"", "\"Sam\"")),
      list(label = "database", value = c("\"staging\"", "\"live\""))
    ))
  )
})
