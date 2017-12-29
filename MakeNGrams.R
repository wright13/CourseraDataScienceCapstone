MakeNGrams <- function(working.dir) {
    # Clear the environment
    #rm(list = ls())
    
    # Load packages and set working directory
    library(data.table)
    library(tidyverse)
    library(quanteda)
    library(readtext)
    #setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")
    setwd(working.dir)
    
    path.to.data <- paste0(getwd(), "/data/final/en_US/")
    text.files <- paste0(path.to.data, dir(path = path.to.data, pattern = "sample"))
    
    # Create a corpus using the quanteda package
    corpus.all <- corpus(readtext(text.files))
    
    # Tokenize the corpus
    
    # Split into sentences first
    sentences <- tokens(corpus.all, what = "sentence", remove_numbers = TRUE, remove_punct = TRUE, remove_twitter = TRUE, remove_url = TRUE, remove_symbols = TRUE)
    sentences <- paste("#s#", unlist(sentences, use.names = FALSE), "#e#")
    rm(corpus.all)
    
    makeTokens <- function(input, n) {
      n.grams <- tokens(input, what = "word", remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_url = TRUE, remove_twitter = FALSE, ngrams = n) %>%
        toLower() %>%
        unlist(use.names = FALSE) %>%
        as.data.table()
    }
    
    one.grams <- makeTokens(sentences, 1)
    two.grams <- makeTokens(sentences, 2)
    three.grams <- makeTokens(sentences, 3)
    four.grams <- makeTokens(sentences, 4)
    
    fwrite(one.grams, file = paste0(getwd(), "/", "one_grams.txt"), append = FALSE)
    fwrite(two.grams, file = paste0(getwd(), "/", "two_grams.txt"), append = FALSE)
    fwrite(three.grams, file = paste0(getwd(), "/", "three_grams.txt"), append = FALSE)
    fwrite(four.grams, file = paste0(getwd(), "/", "four_grams.txt"), append = FALSE)
    
}   
