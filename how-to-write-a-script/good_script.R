# ------------------------------------------------------------------------
# cVEDA: Association between parental punishment and behaviour 
# ------------------------------------------------------------------------

# This script assesses the association between parental corporal punishment
# and total sdq (Strength and Difficulty Questionnaire) score within the cveda cohort
# Date: 2020-10-21

# Set directory and import data and save as data_cveda
setwd("a_directory")

data_cveda <- read.delim("data_cveda.txt")

# ------------------------------------------------------------------------
# Examine the data and add a variable for children
# ------------------------------------------------------------------------

# list the variables in data_cveda
names(data_cveda)  
### The names can be used to refer to the relevant variables by using the $ symbol.
data_cveda$ageband

### Add which individuals in the dataset are children or in ageband=1 
# Code below gives you the number of children included in the study. 
# An additional T/F column is added to the data_cveda data frame ###
data_cveda$child <- data_cveda$ageband == 1   

summary(data_cveda$child) 
# 1918 children in the dataset 

# Examine the statistical qualities of the data
mean(data_cveda$p_sdq_tot, na.rm = TRUE) 
sd(data_cveda$p_sdq_tot, na.rm = TRUE) # standard deviation
median(data_cveda$p_sdq_tot, na.rm = TRUE) 
IQR(data_cveda$p_sdq_tot, na.rm = TRUE) # interquartile range
mad(data_cveda$p_sdq_tot, na.rm = TRUE) # mean absolute deviation
min(data_cveda$p_sdq_tot, na.rm = TRUE) # minimum value
max(data_cveda$p_sdq_tot, na.rm = TRUE) # maximum value
range(data_cveda$p_sdq_tot, na.rm = TRUE) 
summary(data_cveda$p_sdq_tot, na.rm = TRUE) # gives many of values found above

### The following gives you the same variables, but only for the children in the dataset, not the whole sample### 
d_child <- data_cveda[data_cveda$ageband == 1, ]

mean(d_child$p_sdq_tot, na.rm = TRUE) # 11.97
sd(d_child$p_sdq_tot, na.rm = TRUE) # 6.04
median(d_child$p_sdq_tot, na.rm = TRUE) # 12
IQR(d_child$p_sdq_tot, na.rm = TRUE) # 8
mad(d_child$p_sdq_tot, na.rm = TRUE) # 5.93
min(d_child$p_sdq_tot, na.rm = TRUE) # 0
max(d_child$p_sdq_tot, na.rm = TRUE) # 32
range(d_child$p_sdq_tot, na.rm = TRUE) # 0-32
summary(d_child$p_sdq_tot, na.rm = TRUE) # 0, 8, 12, 11.97, 16, 32, NA (56) 

# ------------------------------------------------------------------------
# Assess the relationship between SDQ variables and corp punishment
# ------------------------------------------------------------------------

# correlation between SDQ emotion problems and SDQ conduct problems
cor(data_cveda$p_sdq_emotion, data_cveda$p_sdq_conduct, use = “pairwise.complete.obs”)  

# table of numbers with anxiety/depression in a first degree relative
table(data_cveda$depanx_1stdeg)
###The following will produce a three-way cross-tabulation between anxiety/depression in a first degree relative with gender. ###
table(data_cveda$depanx_1stdeg, data_cveda$sex)

### Create a boxplot of sdq emotional problems with the dichotomous variable corporal punishment ###
boxplot(p_sdq_emotion ~ corpunish, data = data_cveda)   

## Regressions:
# Model 1 looks at the basic linear relationship between parental corp punishment and total sdq score.
# Model 2 includes adjustment for age and sex
# Model 3 includes adjustment for age, sex, urbanisation, houseownership and site 

model1 <- lm(p_sdq_tot ~ corpunish, data = data_cveda) 
summary(model1)

model2 <- lm(p_sdq_tot ~ corpunish + age + sex, data = data_cveda) 
summary(model2) 

model3 <- lm(p_sdq_tot ~ corpunish + age + sex + urbanisation +houseownership + site, data = data_cveda) 
summary(model3) 
