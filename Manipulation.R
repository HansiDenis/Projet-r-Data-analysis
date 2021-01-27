setwd("C:/Users/HP/Documents/Stat&r/projet/World FactBook/")
#Fichier dans lequel on récupère le nom du pays
codes <- read.csv(file='codes.csv',stringsAsFactors = FALSE,encoding = "UTF-8")
#Fichier avec les intitulés des données et les références
categories <- read.csv(file='categories.csv',stringsAsFactors = FALSE,encoding = "UTF-8")
#Nombre de lignes parcourues
line=1
#On ajoute les noms de pays à la base de données wfb2(WorldFactBook 2)
wfb2 <- codes[1]
while (line<=74){
  #On récupère le numéro du fichier de la catégorie puis on l'ouvre dans place
  num=categories$Num[line]
  place <- read.csv(file=paste(c('data/c',num,'.csv'),collapse = ""),stringsAsFactors = FALSE)
  i=1
  #On vérifie pays par pays si on a une valeur correspondante
  while (i<=279){
    pays=wfb2[i,1]
    j=1
    #on parcours tout plae
    while (j<=nrow(place)){
      if (identical(pays,place[j,2])){
        #On récupère la valeur et on enlève les éventuelles virgules
        res=place[j,3]
        res=gsub(",","",res,fixed=TRUE)
        #Si il y a un dollar au début on l'enlève
        if(identical(substring(res,1,1),"$") ){
          res=substring(res,2)
        }
        #Si le dollar est en deuxième place(présence d'un signe -) on enlève que le dollar
        if(identical(substring(res,2,2),"$") ){
          res=paste(c(substring(res,1,1),substring(res,3)),collapse="")
        } 
        #l'utilisation de as.double n'entraîne pas de perte de précision, elle
        #raccourci juste l'écriture(testé)
        wfb2[i,line+1]=as.double(res)}
      j=j+1}
    i=i+1}
  #On ajoute l'intitulé de la donnée que l'on vient de traiter aux nom de colonnes
  colnames(wfb2)<-c(colnames(wfb2)[1:length(colnames(wfb2))-1],categories$Name[line])
  line=line+1
}
print(wfb2)
write.csv(wfb2,'wfb2.csv')