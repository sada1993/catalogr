test_that("remove starting spaces", {
  expect_equal(remove_starting_spaces("Hello World"), "Hello World")
  expect_equal(remove_starting_spaces(" Hello World"), "Hello World")
  expect_equal(remove_starting_spaces("     Hello World"), "Hello World")
})

test_that("remove ending spaces", {
  expect_equal(remove_ending_spaces("Hello World"), "Hello World")
  expect_equal(remove_ending_spaces("Hello World  "), "Hello World")
  expect_equal(remove_ending_spaces("  Hello World  "), "  Hello World")
})

test_that("detect token", {
  expect_true(does_token_exist("#> Test", "#>"))
  expect_false(does_token_exist(" #> Test", "#>"))
  expect_false(does_token_exist("#> Test", ">"))
})

test_that("detect malformed line", {
  expect_true(is_line_format_correct("#> my_label: [test]", "#>"))
  expect_false(is_line_format_correct("#> my_label: [test]", "#'"))
  expect_false(is_line_format_correct("#> my_label [test]", "#'"))
  expect_false(is_line_format_correct("#> my_label:: [[test]]", "#>"))
  expect_true(is_line_format_correct("#>     my label:     [test,    test2]", "#>"))
})


test_that("parse label", {
  expect_equal(parse_label("#> my_label: [test]", "#>"), "my_label")
  expect_equal(parse_label("#>     my label:     [test,    test2]", "#>"), "my label")
})

test_that("parse value", {
  expect_equal(parse_value("#> my_label: [test]", "#>"), "test")
  expect_equal(parse_value("#>     my label:     [test,    test2]", "#>"), "test,    test2")
})

test_that("tokenize", {
  expect_equal(
    tokenize(c("#>   authors   :    [   test  ]   ", "#> my_label: [  test1  ,  test2   ]", "#This is not a token"), "#>"),
    list(list(label = "authors", value = "test"), list(label = "my_label", value = c("test1", "test2")))
  )
})
