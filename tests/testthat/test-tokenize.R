test_that("remove starting spaces", {
  expect_equal(remove_starting_spaces("Hello World"), "Hello World")
  expect_equal(remove_starting_spaces(" Hello World"), "Hello World")
  expect_equal(remove_starting_spaces("     Hello World"), "Hello World")
})

test_that("detect malformed line",{
  expect_true(is_line_format_correct("#> my_label: [test]", "#>"))
  expect_false(is_line_format_correct("#> my_label: [test]", "#'"))
  expect_false(is_line_format_correct("#> my_label:: [[test]]", "#>"))
  expect_true(is_line_format_correct("#>     my label:     [test,    test2]", "#>"))
})


test_that("parse label",{
  expect_equal(parse_label("#> my_label: [test]", "#>"), "my_label")
  expect_equal(parse_label("#>     my label:     [test,    test2]", "#>"), "my label")
})
