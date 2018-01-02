CleanupNGrams <- function(working.dir) {

    require(tidyverse)
    require(quanteda)
    require(data.table)
    require(plotly)
    
    #setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")
    setwd(working.dir)
    
    # Read in 1- through 4-grams
    one.grams <- fread("one_grams.txt")
    two.grams <- fread("two_grams.txt")
    three.grams <- fread("three_grams.txt")
    four.grams <- fread("four_grams.txt")
    
    # Calculate total occurrences of all n-grams
    n.one.grams <- sum(one.grams$count)
    n.two.grams <- sum(two.grams$count)
    n.three.grams <- sum(three.grams$count)
    n.four.grams <- sum(four.grams$count)
    
    # Print number of n-grams that cover 90% of occurrences
    nrow(one.grams[cumulative.proportion <= 0.90])
    nrow(two.grams[cumulative.proportion <= 0.90])
    nrow(three.grams[cumulative.proportion <= 0.90])
    nrow(four.grams[cumulative.proportion <= 0.90])
    
    # Plot file size vs percentage of corpus covered
    acc.data <- data.frame()
    for (pct in seq(0.1, 0.9, 0.1)) {
        one.grams.size <- object.size(one.grams[cumulative.proportion <= pct])
        two.grams.size <- object.size(two.grams[cumulative.proportion <= pct])
        three.grams.size <- object.size(three.grams[cumulative.proportion <= pct])
        four.grams.size <- object.size(four.grams[cumulative.proportion <= pct])
        acc.data <- rbind(acc.data, c(pct, one.grams.size, two.grams.size, three.grams.size, four.grams.size))
    }
    names(acc.data) <- c("percent", "one.grams.size", "two.grams.size", "three.grams.size", "four.grams.size")
    acc.data[,2:5] <- acc.data[,2:5]/1000000000
    
    plot_ly(data = acc.data, x = ~percent) %>%
        add_trace(y = ~one.grams.size, name = "one-grams size (Gb)") %>%
        add_trace(y = ~two.grams.size, name = "two-grams size (Gb)") %>%
        add_trace(y = ~three.grams.size, name = "three-grams size (Gb)") %>%
        add_trace(y = ~four.grams.size, name = "four-grams size (Gb)")
}