dat <- read.csv("samples.csv")
dat$bmi <- 27 + scale(dat$age) + sign(dat$sex == "M") + dat$diet + rnorm(nrow(dat))
write.csv(dat, file="bmi.csv", row.names=F)