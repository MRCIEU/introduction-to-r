setwd("a_directory")
data_cveda <- read.delim("data_cveda.txt")
data_cveda 

names(data_cveda) 
data_cveda$ageband

data_cveda$child<- data_cveda$ageband==1   
summary

mean(data_cveda$p_sdq_tot, na.rm=TRUE) 
sd(data_cveda$p_sdq_tot,na.rm=TRUE) 
median(data_cveda$p_sdq_tot, na.rm=TRUE) 
IQR(data_cveda$p_sdq_tot,    na.rm=TRUE)
mad(data_cveda$p_sdq_tot,na.rm=TRUE)
min(data_cveda$p_sdq_tot,na.rm=TRUE)
max(data_cveda$p_sdq_tot, na.rm=TRUE)
range(data_cveda$p_sdq_tot, na.rm=TRUE)
summary(data_cveda$p_sdq_tot, na.rm=TRUE) 

d<- data_cveda[data_cveda$ageband==1,]
mean(d$p_sdq_tot, na.rm=TRUE)  
sd(d$p_sdq_tot, na.rm=TRUE) 
median(d$p_sdq_tot, na.rm=TRUE) 
IQR(d$p_sdq_tot,na.rm=TRUE) 
mad(d$p_sdq_tot, na.rm=TRUE) 
min(d$p_sdq_tot, na.rm=TRUE) 
max(d$p_sdq_tot, na.rm=TRUE) 
range(d$p_sdq_tot, na.rm=TRUE) 
summary(d$p_sdq_tot, na.rm=TRUE) 

cor(data_cveda$p_sdq_emotion, data_cveda$p_sdq_conduct, use= “pairwise.complete.obs”)  

table(data_cveda$depanx_1stdeg) 
table(data_cveda$depanx_1stdeg, data_cveda$sex)

boxplot(p_sdq_emotion ~ corpunish, data=data_cveda)   

lm(p_sdq_tot ~ corpunish, data=data_cveda) 
model1 <- lm(p_sdq_tot ~ corpunish, data=data_cveda) 
summary(model1)

lm(p_sdq_tot ~ corpunish + age + sex, data=data_cveda) 
summary(model2) 

lm(p_sdq_tot ~ corpunish + age + sex + site, data=data_cveda) 
summary(model3) 
