catalog <- list(
  filepath1 = list(
    list(
      label = "features",
      value = c("col1", "col2", "col3")
    ),
    list(
      label = "description",
      value = c("This is a datapull of col1, col2, and col3 across x tables in the y database")
    ),
    list(
      label = "countries",
      value = c("India", "Sri Lanka", "Indonesia")
    )
  ),
  filepath2 = list(
    list(
      label = "authors",
      value = c("Akash", "Sam", "John Doe")
    ),
    list(
      label = "countries",
      value = c("USA")
    )
  ),
  filepath3 = list(
    list(
      label = "description",
      value = c("This is a datapull for John Does, and contains the yearly summary from databases x and y")
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
          value = c("India", "Sri Lanka", "Indonesia")
        )
      ),
      filepath2 = list(
        list(
          label = "countries",
          value = c("USA")
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
          value = c("Akash", "Sam", "John Doe")
          )
        )
      )
  )

})
