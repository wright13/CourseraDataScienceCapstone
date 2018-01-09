CountNGrams <- function(n.gram.table, token, n.words) {
    #n.grams.count <- as.data.table(n.gram.list)
    n.gram.table[, count := .N, by = token]
    setorder(n.gram.table, -count)
    n.gram.table <- unique(n.gram.table)
    n.gram.table[, n := n.words]
    return(n.gram.table)
}

MakeNGrams <- function(working.dir) {
    # Clear the environment
    #rm(list = ls())
    
    # Load packages and set working directory
    require(data.table)
    require(tidyverse)
    require(quanteda)
    require(readtext)
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
        tokens_tolower() %>%
        unlist(use.names = FALSE) %>%
        as.data.table()
    }
    
    print("Making unigrams")
    one.grams <- makeTokens(sentences, 1)
    names(one.grams) <- "token"
    print("Making bigrams")
    two.grams <- makeTokens(sentences, 2)
    names(two.grams) <- "token"
    print("Making trigrams")
    three.grams <- makeTokens(sentences, 3)
    names(three.grams) <- "token"
    print("Making tetragrams")
    four.grams <- makeTokens(sentences, 4)
    names(four.grams) <- "token"
    print("Making five-grams")
    five.grams <- makeTokens(sentences, 5)
    names(five.grams) <- "token"    
    
    
    one.grams.count <- CountNGrams(one.grams, "token", 1)
    rm(one.grams)
    
    two.grams.count <- CountNGrams(two.grams, "token", 2)
    rm(two.grams)
    
    three.grams.count <- CountNGrams(three.grams, "token", 3)
    rm(three.grams)
    
    four.grams.count <- CountNGrams(four.grams, "token", 4)
    rm(four.grams)
    
    five.grams.count <- CountNGrams(five.grams, "token", 5)
    rm(five.grams)
    
    # Write data frame of n-grams, counts, and percentages
    # getwd()
    fwrite(one.grams.count, file = paste0(getwd(), "/", "one_grams.txt"), append = FALSE)
    fwrite(two.grams.count, file = paste0(getwd(), "/", "two_grams.txt"), append = FALSE)
    fwrite(three.grams.count, file = paste0(getwd(), "/", "three_grams.txt"), append = FALSE)
    fwrite(four.grams.count, file = paste0(getwd(), "/", "four_grams.txt"), append = FALSE)
    fwrite(five.grams.count, file = paste0(getwd(), "/", "five_grams.txt"), append = FALSE)

    # Clear the environment
    # rm(list = ls())
}

ConsolidateNGrams <- function() {
  # Read n-grams in from individual text files
  one.grams.count <- fread("one_grams.txt")
  names(one.grams.count) <- c("token", "count", "n")
  two.grams.count <- fread("two_grams.txt")
  names(two.grams.count) <- c("token", "count", "n")
  three.grams.count <- fread("three_grams.txt")
  names(three.grams.count) <- c("token", "count", "n")
  four.grams.count <- fread("four_grams.txt")
  names(four.grams.count) <- c("token", "count", "n")
  five.grams.count <- fread("five_grams.txt")
  names(five.grams.count) <- c("token", "count", "n")
  
  # Write data frame of n-grams and counts into a single file
  fwrite(one.grams.count[count > 40], file = paste0(getwd(), "/", "n_grams.txt"), append = FALSE)
  fwrite(two.grams.count[count > 5], file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
  fwrite(three.grams.count[count > 5], file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
  fwrite(four.grams.count[count > 5], file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
  fwrite(five.grams.count[count > 5], file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)  
}
