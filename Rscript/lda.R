install.packages("lda","stringr","xlsx","KoNLP")
install.packages("KoNLP")
require(lda)
require(stringr)
require(xlsx)
library(KoNLP)
require(KoNLP)
useSejongDic()

lda=function(){
  
  rm(bs0);rm(i);
  i=1
  for(i in 1:17){
    
    if(i<10){
      inputname=paste0("BS0",i,".csv")
      outputname=paste0("BS200",i,".csv")
      
      name = read.csv(inputname)
      name = as.vector(as.matrix(name))
      
      name = sapply(name, extractNoun)
      name = str_replace_all(name,"\\d","")
      name = str_replace_all(name,"[^[???-???]]","")
      name = Filter(function(x) {nchar(x) >= 2}, name)
      
      
      listener_lda <- lexicalize(name, lower=TRUE)
      listener_vocab <- listener_lda$vocab[nchar(listener_lda$vocab)>=2]
      k = 3
      
      try({
        
        result <- lda.collapsed.gibbs.sampler(listener_lda$documents, as.integer(k), listener_vocab,300, 0.5, 0.5, compute.log.likelihood = TRUE)
        
        top.word <- top.topic.words(result$topics,30,by.score=T)
      },silent=T) 
      write.csv(top.word,outputname)
      
      print(paste0(i,"?????? ?????? ??????"))
      
    }else{
      inputname=paste0("BS",i,".csv")
      outputname=paste0("C:/R_temp/BS20",i,".csv")
      
      name = read.csv(inputname)
      name = as.vector(as.matrix(name))
      
      listener_lda <- lexicalize(name, lower=TRUE)
      listener_vocab <- listener_lda$vocab[nchar(listener_lda$vocab)>=2]
      k = 3
      try({
        result <- lda.collapsed.gibbs.sampler(listener_lda$documents, k, listener_vocab, 300, 0.5, 0.5, compute.log.likelihood = TRUE)
        
        top.word <- top.topic.words(result$topics,30,by.score=T)
      },silent=T) 
      write.csv(top.word,outputname)
      
      print(paste0(i,"?????? ?????? ??????"))
      
    }
  }
}
lda()

i=1
for(i in 1:10){
  write.xlsx(result[[i]], "view.xlsx",sheetName=as.character(i),append=TRUE)
}
