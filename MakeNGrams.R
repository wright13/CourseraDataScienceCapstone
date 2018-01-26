# Load packages
library(data.table)
library(tidyverse)
library(quanteda)
library(readr)
library(R.utils)
library(readtext)

# Read texts into invididual corpus. readtext() works for twitter and blogs, and read_file() works for news.
train.paths <- paste0(getwd(), "/data/final/en_US/train_", 1:10, ".txt")
all.tokens <- data.table()
profanity.filter <- unlist(fread("profanity_list_for_filter.txt", header = FALSE))

for (file.path in train.paths) {
    print(file.path)
    corp <- corpus(readtext(file.path))
    toks <- tokens(corp, what = "word", remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_url = TRUE, remove_twitter = TRUE, ngrams = 2:5) %>%
        tokens_tolower() %>%
        unlist(use.names = FALSE) %>%
        as.data.table()
    names(toks) <- "n.gram"
    all.tokens <- rbind(all.tokens, toks[, list(count = .N), by = list(n.gram)])
}

all.tokens <- all.tokens[, list(count = sum(count)), by = list(n.gram)]
all.tokens <- all.tokens[, list(prefix = sub("_[^_]+$", "", n.gram), word = sub("^([^_]+_)+", "", n.gram), count)]

all.tokens <- all.tokens[!(word %in% profanity.filter)]
fwrite(all.tokens, file = paste0(getwd(), "/", "n_grams.txt"), append = FALSE)


