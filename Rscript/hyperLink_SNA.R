install=function(){
  install.packages(c("igraph","xlsx"))
  library(stringr)
  library(KoNLP)
  library(wordcloud)
  library(XML)
  library(igraph)
  library(tm)
  library(xlsx)
}

######################################################################################################
hyperMatrix=function(){
  path = readline(prompt = "rawData path(확장자 제외!!) :")
  output=paste0(path,"graph.csv")
  l=read.xlsx(paste0(as.character(path),".xlsx"),sheetName="TfIdf",encoding="UTF-8")
  l=l$name
  
  m=matrix(0,nrow=length(l),ncol=length(l))
  i=1;j=1;
  for(i in 1:length(l)){
    for(j in 1:length(l)){
      m[i,j]=paste0(l[j],"+",l[i])
    }
  }
  as.vector(m)
  
  s=0;number=0;relation=data.frame()
  
  for(i in 1:length(m)){
    relation1=relation
    search=m[i];
    u=paste0("http://www.google.co.kr/search?q=",search,"&oq=",search)
    t=htmlTreeParse(u, useInternalNodes=TRUE, trim=TRUE, encoding="UTF-8");
    number=xpathSApply(t,"//div[@id='resultStats']",xmlValue);
    number=str_replace_all(number,"\\D","");
    s=data.frame(search);
    relation=data.frame(search, number);
    relation=rbind(relation1,relation);
    print(i)
    print(number)
  }


num1=as.numeric(as.character(relation$number))

mat=matrix(0, nrow=length(l), ncol=length(l))
rownames(mat)=l;colnames(mat)=l

a=1;i=1;j=1
div=vector() #hyperlink값을 상대화 시켜줄 수 있는 자기 자신 값!!!
for(i in 1:length(l)){
  for(j in 1:length(l)){
    mat[i,j]=num1[a]
    a=a+1
    if(i==j){
      div[i]=mat[i,j]
    }
  }
}

i=1
for(i in 1:length(l)){
  for(j in 1:length(l)){
    mat[i,j]=mat[i,j]/div[i]
  }
}

i=1
for(i in 1:length(l)){
  mat[i,i]=0
}

protage=length(mat)*0.1 
cut=sort(mat, decreasing=TRUE)[protage] 

mat.cutoff <- mat
mat.cutoff[mat.cutoff<cut]<- 0
mat.cutoff[mat.cutoff>=cut]<- 1

a=1
for(i in 1:length(l)){
  for(j in 1:length(l)){
    H_num[a]=mat.cutoff[i,j]
    a=a+1
  }
}

List=list(l,H_num)
List<<-List
print("csv저장")
write.csv(List, output)
print("완료")
}
#####################################################################################################

#####################################################################################################
graph=function(){
  num1=c();a=1;
  path = readline(prompt = "rawData path(확장자 제외!!) :")
  print(path)
  graph=read.csv(paste0(as.character(path),".csv"))
  print(graph)
  l=graph[1:8,2]
  num1=graph[,3]
  mat=matrix(0, nrow=length(l), ncol=length(l))
  rownames(mat)=l;colnames(mat)=l
  
  for(i in 1:length(l)){
    for(j in 1:length(l)){
      mat[i,j]=num1[a]
      a=a+1
    }
  }
  
  mat1<<-mat
  mat=graph.adjacency(mat,weighted=T,mode="undirected")
  V(mat)$size<-degree(mat)*5 #네트워크 edge크기 키우기
  plot(mat)
  
}

######################################################################################################
install()
List=c();mat1=matrix()
hyperMatrix()
A_mat=matrix()
graph();
