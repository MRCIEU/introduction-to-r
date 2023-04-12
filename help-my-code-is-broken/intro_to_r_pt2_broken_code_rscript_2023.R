load("path/to/GSE41169_samplesheet_intro_to_R.Rdata")

load("path/to/GSE41169_matrix_intro_to_R.Rdata")

# let's look at the data:
colnames(samplesheet)
dim(samplesheet)
dim(meth)

mean(samplesheet$age)

# mean of numericage column:
mean(samplesheet$numericage)

# use debug() to find out why we are getting NA:
debug(mean)
mean(samplesheet$numericage)

# test regression of disease status and first DNAm site
temp <- summary(lm(meth[,1]~samplesheet$diseasestatus2))

# this gives us an error - lets check the dimensions of our data:
dim(meth)
meth[1:5,1:5]

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
