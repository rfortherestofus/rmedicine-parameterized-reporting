# Load packages
library(tidyverse)
library(NHSRdatasets)
library(quarto)

# Create a vector of all locations
locations <- ae_attendances %>%
  distinct(org_code) %>% 
  mutate(org_code = as.character(org_code)) %>% 
  pull(org_code) 

# Create a tibble with information on the:
# input R Markdown document
# output HTML file
# parameters needed to knit the document
reports <- tibble(
  input = "report.qmd",
  output_file = str_glue("reports/{locations}.html"),
  execute_params = map(locations, ~list(location = .))
)

# Use the tibble to generate all of our reports
pwalk(reports, quarto_render)
