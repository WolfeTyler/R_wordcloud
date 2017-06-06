# Tutorial for using wordcloud
# https://rstudio-pubs-static.s3.amazonaws.com/132792_864e3813b0ec47cb95c7e1e2e2ad83e7.html


install.packages(c('tm', 'SnowballC', 'wordcloud', 'topicmodels'))
library(tm)
library(SnowballC)
library(wordcloud)

corpus_data = read.csv("example.csv", stringsAsFactors = F, row.names = NULL)
some_corpus = Corpus(VectorSource(corpus_data))

some_corpus = tm_map(some_corpus, content_transformer(tolower))
some_corpus = tm_map(some_corpus, removeNumbers)
some_corpus = tm_map(some_corpus, removePunctuation)
some_corpus = tm_map(some_corpus, removeWords, c("and", "the", stopwords("english")))
some_corpus =  tm_map(some_corpus, stripWhitespace)
review_dtm <- DocumentTermMatrix(some_corpus)
review_dtm = removeSparseTerms(review_dtm, 0.1)
freq = data.frame(sort(colSums(as.matrix(review_dtm)), decreasing=TRUE))

wordcloud(rownames(freq), freq[,1], max.words=40, colors=brewer.pal(3, "Set1"))
findFreqTerms(review_dtm, 25)