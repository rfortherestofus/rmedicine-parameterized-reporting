# Load packages
library(tidyverse)
library(NHSRdatasets)
library(quarto)

# Create a vector of all locations
locations <- ae_attendances %>%
  distinct(org_code) %>% 
  pull(org_code) 

# Create a tibble with information on the:
# input R Markdown document
# output HTML file
# parameters needed to knit the document
reports <- tibble(
  input = "report.qmd",
  output_file = str_glue("{locations}.html"),
  execute_params = map(locations, ~list(location = .))
)

# Generate all of our reports
reports %>% 
  walk(quarto_render)


library(pagedown)

chrome_print(input = "slides/slides.html",
             output = "slides/parameterized-reporting-slides.pdf",
             timeout = 180)
