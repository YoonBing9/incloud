############################################################################################################
install = function() {
  install.packages(c("igraph", "tm", "stringr", "KoNLP", "wordcloud", "XML","xlsx"))
  library(stringr)
  library(KoNLP)
  library(wordcloud)
  library(XML)
  library(igraph)
  library(tm)
  library(xlsx)
  print("설치완료")
}
############################################################################################################

############################################################################################################
importWord = function() {
  path = readline(prompt = "rawData path :")
  file <<- str_replace_all(path,".csv","A")
  col=readline(prompt="가져올 컬럼 no. :")
  content = read.csv(as.character(path))
  head(content,1)
  content1 = content[,as.numeric(col)]
  content1 = as.character(content1)
  content1 = sapply(content1, extractNoun)
  content1 = na.omit(content1)
  print("파일명 : content1")
  import<<-content1
}
############################################################################################################

############################################################################################################
extractWord1 = function()
{
  print("1.각 행별로 name 부여하기")
  n.docs <- length(import)
  names(import) <- paste("doc", c(1:n.docs), sep = "")
  
  
  print("2.Tf-Idf matrix 생성")
  
  my.corpus <- Corpus(VectorSource(import))
  my.corpus <- tm_map(my.corpus, content_transformer(tolower))
  
  
  TDM_Tf <-TermDocumentMatrix(my.corpus, control = list(removePuctuation = TRUE, removeNumbers = TRUE, stopwords = TRUE, weighting = weightTf))
  sum_Tf=rowSums(as.matrix(TDM_Tf))
  sum<<-sum_Tf
  TDM_TfIdf <-TermDocumentMatrix(my.corpus,control = list(removePuctuation = TRUE, removeNumbers = TRUE, stopwords = TRUE, weighting = weightTfIdf ) )
  TfIdf <<- TDM_TfIdf
  sum1=rowSums(as.matrix(TDM_TfIdf)) 
  
  w = findFreqTerms(TDM_TfIdf, lowfreq = 0)
  arr=list(name=names(sum1[1:length(w)]), freq=sum1[1:length(w)])
  arr=sort(arr$freq,decreasing = T)
  w=names(arr)  
  
  
  
  print("3.추출단어 sample")
  head(w,100)
  
  print("4. 1차 불용어 처리")
  
  uselessDic = readline(prompt = "1차 useless :")
  useless = read.csv(uselessDic)
  useless_cnt = length(useless[[1]])
  
  i = 1
  for (i in 1:useless_cnt) {
    w = str_replace_all(w, as.character(useless[[1]][i]), "")
    print(useless[[1]][i])
  }
  w = str_replace_all(w,"\\d","")
  w = Filter(function(x) {nchar(x) >= 2}, w)
  w<<-w
}
############################################################################################################

############################################################################################################
extractWord2 = function(){
  second=readline(prompt="2차 불용어 처리 파일이 있습니까?(1:있음 2: 없음):")
  if(as.numeric(second)==1){
    print("2차 불용어 처리")
    uselessDic = readline(prompt = "2차 useless :")
    useless = read.csv(uselessDic)
    useless_cnt = length(useless[[1]])
    
    i = 1
    for (i in 1:useless_cnt) {
      w = str_replace_all(w, as.character(useless[[1]][i]), "")
      print(useless[[1]][i])
    }
    w=str_replace_all(w,"\\d","")
    w = Filter(function(x) {nchar(x) >= 2}, w)
  }
  
  print("불용어 처리 완료")
  print(w)
  
  count= readline(prompt=("추출할 단어 갯수:"))
  
  first=list(name=as.character(w[1]),freq=sum[as.character(w[1])]);
  print(as.character(w[1]))
  i=2
  for(i in 2:as.numeric(count)){
    first1=first
    word=as.character(w[i])
    first=list(name=word,freq=sum[word])
    first=rbind(first1,first)
    print(word)
  }
  row.names(first)=NULL
  print(first)
  wordList <<- first
  write.xlsx(first, file=paste0(file,".xlsx"),sheetName="TfIdf")
}
############################################################################################################

############################################################################################################
Association=function(){
  i=1
  for(i in 1:20){
    word = readline(prompt="단어를 입력하시오:")
    #word=wordList[i]
    try({
    assoc=findAssocs(TfIdf,as.character(word),0.2)
    write.xlsx(assoc,file=paste0(file,".xlsx"),sheetName=as.character(word),append=TRUE)
    },silent=F)
    continue=readline(prompt="계속 진행하시겠습니까?(1.계속 2. 멈춤):")
    if(as.numeric(continue)==2){
      break
    }
  }
}

############################################################################################################

############################################################################################################
install();
import=c();
corpus <- Corpus(VectorSource(import));TfIdf=TermDocumentMatrix(corpus);
useSejongDic();sum=c();w=c();file="a";wordList=c();
importWord();
extractWord1();
extractWord2();
Association();
