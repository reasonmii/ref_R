# ========================================================
# Setting
# ========================================================

source("/data/Glibrary/globalFuncs.R")

# setwd('folder/folder/folder')
setwd('/data/CP/2021_Healthchk')
getwd()

library(magrittr)
library(dplyr)
library(data.table)
library(plyr)

# Check sandbox
paste9(Sys.getenv("R_PROJECTED"),"/")   # CC, CP, FT

# Get table from SQL to R
dataOrg <- as.data.table(G_ExecuteSql(dbSource = "hadoop",
                                      sqlstmt = "select * from yuna_hck_cmp_rspn_ans_txt"))

# Save as CSV
G_RxDataStep(inData = dataOrg, outFile = "yuna_hck_cmp_rspn_ans_txt_jan.csv")
dataCSV <- fread(paste0(G_GetTmpDataDir(), "/yuna_hck_cmp_rspn_ans_txt_jan.csv"))

# Get data from CSV
data <- dataCSV

# Filter data
data <- dataCSV[data$stfy_yn == "2불만"]

# Check columns
colnames(data)

# ========================================================
# Text Analysis
# https://kerpect.tistory.com/129
# ========================================================
library(KoNLP)      # Korean dictionary
library(tm)         # Text data preprocessing
library(wordcloud)  # Visualize

# Check column with text answers (주관식 답변)
data$ans_txn[1]

# Create table with only a column of text answers
dataTxt <- data$ans_txn


# ========================================================
# Extract Nouns
# ========================================================
# paste() : 나열된 원소 사이에 공백을 두고 결과값 출력
# extractNoun() : 명사 추출
# collapse=" " : 찾은 단어 사이에 " " 삽입

# Create function
# Conver to character type -> extract Nouns -> connect them with " "
exNouns <- function(x) {
  paste(extractNoun(as.character(x)), collapse=" ")
}

# Extract Nouns
# sapply(list, function) : Convert list to matrix/vector and apply function
# apply(matrix, 1 or 2, function) : Apply function (1 : row, 2 : column direction)
#                                   It's input should be array ★
#                                   but, since most of inputs are vector, we use "lapply"
# lapply : input 'vector/list' and return 'list'
dataNouns <- sapply(data, exNouns)
dataNouns[1]


# ========================================================
# Data Preprocessing
# ========================================================

# Create my stop words
myStopwords <- c("너무","자주","매우","많이","자꾸","계속","제발","많아서",
                 "가끔","그냥","다른","거의","항상","진짜","정말",
                 "없음","없어요","없고","있음","있는","없다","있으면",
                 "별로","비해", "대한","경우가","부분이","바로","제대로",
                 "같아요","좋겠다","합니다","그리고")

# Create Corpus
myCorpus <- Corpus(VectorSource(dataNouns))

# tm_map : Filter the corpus data
myCorpusNew <- tm_map(myCorpus, removePunctuation)    # Remove Punctuation
myCorpusNew <- tm_map(myCorpusNew, removeNumbers)     # Remove Numbers
myCorpusNew <- tm_map(myCorpusNew, tolower)           # Conver to lower case
myCorpusNew <- tm_map(myCorpusNew, removeWords, stopwords('english'))  # Remove english stopwords
myCorpusNew <- tm_map(myCorpusNew, removeWords, myStopwords)  # Remove my stopwords

# Check the data
inspect(myCorpusNew[1])

# TermDocumentMatrix() : 분석에 필요한 단어를 선별하고 단어/문서 행렬 만들기
# 한글 1음절은 2byte에 저장 (2음절 = 4byte, 8음절 = 16byte)
corpusSelect <- TermDocumentMatrix(myCorpusNew, control=list(wordLengths=c(4,16))) # 2~8음절
corpusSelect

# Convert matrix into data.frame
df <- as.data.frame(as.matrix(corpusSelect))
dim(df)


# ========================================================
# Word Frequency
# ========================================================
wordFreq <- sort(rowSums(df), decreasing = T)

# Top 30 words
wordFreq[1:30]


# ========================================================
# Word Cloud visualization
# ========================================================
cloudList <- names(wordFreq)
wordcloud(cloudList, wordFreq)

# Create a data frame with word and its frequency 
word_df <- data.frame(word=cloudList, freq=wordFreq)
str(wordDF)

# Set Design
pal <- brewer.pal(12, "Paired")                # 12 Colors
#pal <- brewer.pal(8, "Dark2")                  # 8 Colors
windowsFonts(malgun-windowsFont("맑은 고딕"))  # Font

# Visualize word cloud
x11()                            # 별도의 창을 띄우는 함수
wordcloud(word_df$word,
          word_df$freq,
          scale = c(5, 1),
          min.freq = 1,
          max.words = 100,
          random.order = F,      # Set the biggest one in the center
          rot.per = .1,
          colors = pal,
          family = "malgun")
          
