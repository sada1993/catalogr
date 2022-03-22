catalog <- list(
  filepath1 = list(
    list(
      label = "features",
      values = c("col1", "col2", "col3")
    ),
    list(
      label = "desciption",
      values = c("This is a datapull of col1, col2, and col3 across x tables in the y database")
    ),
    list(
      label = "countries",
      values = c("India", "Sri Lanka", "Indonesia")
    )
  ),
  filepath2 = list(
    list(
      label = "authors",
      values = c("Akash", "Sam", "John Doe")
    ),
    list(
      label = "countries",
      values = c("USA")
    )
  )
)

test_that("find_label",{
  expect_equal(
    find_label(catalog, "countries"),
    list(
      filepath1 = list(
        list(
          label = "countries",
          values = c("India", "Sri Lanka", "Indonesia")
        )
      ),
      filepath2 = list(
        list(
          label = "countries",
          values = c("USA")
        )
      )
    )
  )

  expect_equal(
    find_label(catalog, "authors"),
    list(
      filepath2 = list(
        list(
          label = "authors",
          values = c("Akash", "Sam", "John Doe")
          )
        )
      )
  )

})
