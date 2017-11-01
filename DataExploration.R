# Clear the environment
rm(list = ls())

# Load packages
library(data.table)
library(tidyverse)
library(quanteda)

con <- file("C:/Users/Sarah/Documents/R/DataScienceCapstone/textSample.csv", "rb")
sample <- data.table()
while (length(line <- readLines(con, n = 20, skipNul = TRUE, encoding = "UTF-8")) > 0) {
  sample <- rbind(sample, line)
}
close(con)
n <- dim(sample)[1]
n.chunks <- 10

# Split the text into four smaller chunks so as not to run out of memory while processing

for (i in 1:n.chunks) {
  # Set start and end indices
  start <- n * (i - 1)/n.chunks + 1
  end <- n * (i / n.chunks)
  # If this is the first iteration of the loop, set append to false so that new files are created; otherwise, set append to true
  append.TF <- !(i == 1)
  
  # Create a corpus using the quanteda package
  sample.corpus <- corpus(as.data.frame(sample[start:end,]), text_field = "x")
  
  # Tokenize the corpus
  one.grams <- quanteda::tokenize(sample.corpus, simplify = TRUE, remove_punct = TRUE, remove_symbols = TRUE) %>%
    char_tolower() %>%
    as.data.table() %>%
    write_csv(path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/one_grams.csv", append = append.TF)
  rm(one.grams)
}

for (i in 1:n.chunks) {
  # Set start and end indices
  start <- n * (i - 1)/n.chunks + 1
  end <- n * (i / n.chunks)
  # If this is the first iteration of the loop, set append to false so that new files are created; otherwise, set append to true
  append.TF <- !(i == 1)
  
  # Create a corpus using the quanteda package
  sample.corpus <- corpus(as.data.frame(sample[start:end,]), text_field = "x")
  
  # Tokenize the corpus
  two.grams <- quanteda::tokenize(sample.corpus, simplify = TRUE, remove_punct = TRUE, remove_symbols = TRUE, ngrams = 2) %>%
    char_tolower() %>%
    as.data.table() %>%
    write_csv(path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/two_grams.csv", append = append.TF)
  rm(two.grams)
}

for (i in 1:n.chunks) {
  # Set start and end indices
  start <- n * (i - 1)/n.chunks + 1
  end <- n * (i / n.chunks)
  # If this is the first iteration of the loop, set append to false so that new files are created; otherwise, set append to true
  append.TF <- !(i == 1)
  
  # Create a corpus using the quanteda package
  sample.corpus <- corpus(as.data.frame(sample[start:end,]), text_field = "x")
  
  three.grams <- quanteda::tokenize(sample.corpus, simplify = TRUE, remove_punct = TRUE, remove_symbols = TRUE, ngrams = 3) %>%
    char_tolower() %>%
    as.data.table() %>%
    write_csv(path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/three_grams.csv", append = append.TF)
  rm(three.grams)
  
}

for (i in 1:n.chunks) {
  # Set start and end indices
  start <- n * (i - 1)/n.chunks + 1
  end <- n * (i / n.chunks)
  # If this is the first iteration of the loop, set append to false so that new files are created; otherwise, set append to true
  append.TF <- !(i == 1)
  
  # Create a corpus using the quanteda package
  sample.corpus <- corpus(as.data.frame(sample[start:end,]), text_field = "x")
  
  four.grams <- quanteda::tokenize(sample.corpus, simplify = TRUE, remove_punct = TRUE, remove_symbols = TRUE, ngrams = 4) %>%
    char_tolower() %>%
    as.data.table() %>%
    write_csv(path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/four_grams.csv", append = append.TF)
  rm(four.grams)
  
}

for (i in 1:n.chunks) {
  # Set start and end indices
  start <- n * (i - 1)/n.chunks + 1
  end <- n * (i / n.chunks)
  # If this is the first iteration of the loop, set append to false so that new files are created; otherwise, set append to true
  append.TF <- !(i == 1)
  
  # Create a corpus using the quanteda package
  sample.corpus <- corpus(data.frame(sample[start:end,]), text_field = "x")
  
  five.grams <- quanteda::tokenize(sample.corpus, simplify = TRUE, remove_punct = TRUE, remove_symbols = TRUE, ngrams = 5) %>%
    char_tolower() %>%
    as.data.table() %>%
    write_csv(path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/five_grams.csv", append = append.TF)
  rm(five.grams)
}

for (i in 1:n.chunks) {
  # Set start and end indices
  start <- n * (i - 1)/n.chunks + 1
  end <- n * (i / n.chunks)
  # If this is the first iteration of the loop, set append to false so that new files are created; otherwise, set append to true
  append.TF <- !(i == 1)
  
  # Create a corpus using the quanteda package
  sample.corpus <- corpus(data.frame(sample[start:end,]), text_field = "x")
  
  six.grams <- quanteda::tokenize(sample.corpus, simplify = TRUE, remove_punct = TRUE, remove_symbols = TRUE, ngrams = 6) %>%
    char_tolower() %>%
    as.data.table() %>%
    write_csv(path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/six_grams.csv", append = append.TF)
  rm(six.grams)
}

rm(sample)
rm(sample.corpus)
