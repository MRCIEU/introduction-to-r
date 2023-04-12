library(rmarkdown)
library(bookdown)
library(knitr)

render("paper.rmd", output_format="bookdown::html_document2")

render("paper.rmd", output_format="bookdown::pdf_document2")

