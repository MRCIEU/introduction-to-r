load("path/to/GSE41169_samplesheet_intro_to_R.Rdata")

load("path/to/GSE41169_matrix_intro_to_R.Rdata")

# let's look at the data:
colnames(samplesheet)
dim(samplesheet)
dim(meth)

mean(samplesheet$age)

# mean of numericage column:
mean(samplesheet$numericage)
# NA

# use debug() to find out why we are getting NA:
debug(mean)
mean(samplesheet$numericage)

# looks like this could be caused by NAs in the data - let's check:
sum(is.na(samplesheet$numericage))

# yep, it's NAs in the data so we include na.rm=T
mean(samplesheet$numericage,na.rm = T)

# Whoops! this comes up with debug() again so we need to switch it off
undebug(mean)

# run the command again:
mean(samplesheet$numericage,na.rm = T)

# test regression of disease status and first DNAm site
temp <- summary(lm(meth[,1]~samplesheet$diseasestatus2))

# this gives us an error - lets check the dimensions of our data:
dim(meth)
meth[1:5,1:5]

# OK we had the meth df the wrong way round for regression - 
# let's transform it:
meth <- t(meth)
dim(meth)

# let's try that regression again!
temp <- summary(lm(meth[,1]~samplesheet$diseasestatus2))

# Now let's test whether DNAm is associated with some of our covariates

# make a vector of covariates we want to test:
exposures <- c("numericage","plate","position")
# make a list to save the results to:
results_list <- list()

# run a loop to test the association:
for(i in exposures){
  temp <- lm(meth~samplesheet[,i])
  results_list[[i]] <- temp
}

# let's use traceback() to find out what might be causing the error:
traceback()

# let's use print() to find out which variable is causing the problem:
for(i in exposures){
  print(i)
  temp <- lm(meth~samplesheet[,i])
  results_list[[i]] <- temp
}

# we know the variable plate is causing the problem
# lets check the values of plate:
table(samplesheet$plate)

# plate only has one level so we can't use that in the regression!
