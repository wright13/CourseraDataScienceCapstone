# Clear the environment
rm(list = ls())

# Load packages and set working directory
library(data.table)
library(tidyverse)
library(quanteda)
setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")
data.filename <- "/allText.csv"

all.text <- fread(paste0(getwd(), data.filename), encoding = "UTF-8", header = FALSE, sep = "\n")
names(all.text) <- "text"

# Create a corpus using the quanteda package
corpus.all <- corpus(as.data.frame(all.text), text_field = "text")
rm(all.text)

# Tokenize the corpus
numbers <- c("one", "two", "three", "four", "five", "six")

for(i in 1:6) {
  n.grams <- tokens(corpus.all, what = "word", remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_url = TRUE, ngrams = i) %>%
    as.character() %>%
    as.data.table() %>%
    fwrite(file = paste0(getwd(), "/", numbers[i], "_grams.csv"), append = FALSE)
  rm(n.grams)
}

rm(corpus.all)
