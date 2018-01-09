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
    names(one.grams) <- "one.gram"
    print("Making bigrams")
    two.grams <- makeTokens(sentences, 2)
    names(two.grams) <- "two.gram"
    print("Making trigrams")
    three.grams <- makeTokens(sentences, 3)
    names(three.grams) <- "three.gram"
    print("Making tetragrams")
    four.grams <- makeTokens(sentences, 4)
    names(four.grams) <- "four.gram"
    print("Making five-grams")
    five.grams <- makeTokens(sentences, 5)
    names(five.grams) <- "five.gram"    
    
    
    one.grams.count <- CountNGrams(one.grams, "one.gram", 1)
    rm(one.grams)
    
    two.grams.count <- CountNGrams(two.grams, "two.gram", 2)
    rm(two.grams)
    
    three.grams.count <- CountNGrams(three.grams, "three.gram", 3)
    rm(three.grams)
    
    four.grams.count <- CountNGrams(four.grams, "four.gram", 4)
    rm(four.grams)
    
    five.grams.count <- CountNGrams(five.grams, "five.gram", 5)
    rm(five.grams)
    
    # Write data frame of n-grams, counts, and percentages
    # getwd()
    fwrite(one.grams.count, file = paste0(getwd(), "/", "one_grams.txt"), append = FALSE)
    fwrite(two.grams.count, file = paste0(getwd(), "/", "two_grams.txt"), append = FALSE)
    fwrite(three.grams.count, file = paste0(getwd(), "/", "three_grams.txt"), append = FALSE)
    fwrite(four.grams.count, file = paste0(getwd(), "/", "four_grams.txt"), append = FALSE)
    fwrite(five.grams.count, file = paste0(getwd(), "/", "five_grams.txt"), append = FALSE)

    # Write data frame of n-grams and counts into a single file
    fwrite(select(one.grams.count[count > 5000], one.gram, count, n), file = paste0(getwd(), "/", "n_grams.txt"), append = FALSE)
    fwrite(select(two.grams.count[count > 5], two.gram, count, n), file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
    fwrite(select(three.grams.count[count > 5], three.gram, count, n), file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
    fwrite(select(four.grams.count[count > 5], four.gram, count, n), file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
    fwrite(select(five.grams.count[count > 5], five.gram, count, n), file = paste0(getwd(), "/", "n_grams.txt"), append = TRUE)
    
    # Clear the environment
    # rm(list = ls())
}   
