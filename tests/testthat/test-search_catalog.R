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

test_that("find_label", {
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


test_that("find_value", {
  expect_equal(
    find_value(catalog, "Akash")[1],
    "filepath2"
  )

  expect_equal(
    find_value(catalog, "india")[1],
    "filepath1"
  )
})

test_that("search_catalog", {
  expect_null(search_catalog(catalog, search_value = "countries", label = "India")) # NULL because
  expect_equal(
    search_catalog(catalog, search_value = "India", label = "countries"),
    c("filepath1", "filepath2")
  )
  expect_equal(
    search_catalog(catalog, search_value = "India"),
    c("filepath1", "filepath2", "filepath3")
  )
  expect_equal(
    search_catalog(catalog, "John Doe", "description"),
    c("filepath3", "filepath1")
  )
})

test_that("get_labels", {
  expect_equal(get_labels(catalog), c("authors", "countries", "description", "features"))
  expect_null(get_labels(list()))
})
