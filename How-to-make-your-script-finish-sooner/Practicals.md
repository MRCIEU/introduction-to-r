This session will give you a series of ineffcient codes that use
“movies” dataset from `ggplot2movies` package. Your job will be to:

1.  use the `apply` family to make the code more efficient and,

2.  check with `profvis` to see whether your version is faster.

## Load package and data

``` r
library(profvis)

#load data from "ggplot2movies" r package
data(movies, package = "ggplot2movies")

#check the data
str(movies)
```

## Excercise 1: Find the total number for each movie genre

``` r
sum_genre<-rep(0,7)
for(k in 1:7){
  sum_genre[k]<-sum(movies[,(k+17)])
}
```

## Excercise 2: Comparing rating between “Action” and “Documentary”

``` r
mean_1<-mean(movies[which(movies$Action ==0 & movies$Documentary ==0),"rating"])
mean_2<-mean(movies[which(movies$Action ==0 & movies$Documentary ==1),"rating"])
mean_3<-mean(movies[which(movies$Action ==1 & movies$Documentary ==0),"rating"])
mean_4<-mean(movies[which(movies$Action ==1 & movies$Documentary ==1),"rating"])
```

## Excercise 3: Tukey Five-Number Summaries for length, budget, rating and vote

`fivenum()` is the Tukey Five-Number summaries, which includes the
minimum, 1st quartile, median, 3rd quartile and maximum.

``` r
fivenum_res<-matrix(0,5,4)
rownames(fivenum_res)<-c("Min.", "1st Qu.", "Median", "3rd Qu.", "Max.")
for(j in 1:4){
  fivenum_res[,j]<-fivenum(movies[,(j+2)])
}
```

## Excercise 4: association coefficients between length, budget, rating and vote, and genres

`glm()` fits the generalized linear models and `as.formula()` tells R to
convert the colnames and symbols into a formula format.

``` r
model_coeff<-list()
for(i in 1:4){
  model<-glm(as.formula(paste(colnames(movies)[i+2], "~", paste(colnames(movies)[18:24], collapse = "+"))), data=movies)
  model_coeff[[i]]<-model$coefficients

}
```

## Excercise 5: association coefficients between length, budget, rating and vote, and genres

``` r
#changing the genre variable from dummy to factor levels
movies_sub<-subset(movies, apply(movies[,18:24], 1, sum)==1) #check whether a movie have multiple genre
movies_sub["genres"] <- factor(apply(movies_sub[,18:24], 1, function(x) which(x == 1)), labels = colnames(movies_sub[,18:24]))

#association coefficient from each genre
model2_coeff<-list()
for(i in 1:length(unique(movies_sub$genres))){
  #i<-1
  model2<-summary(glm(formula = rating ~ budget, data =subset(movies_sub, movies_sub$genres==colnames(movies_sub[i+17]))))
  model2_coeff[[i]]<-model$coefficients
  
}
```

# Solution

Note that your answer doesn’t have to be exactly the same as the
solution, as long as it does the same job in less time and/or fewer
lines.

## Excercise 1:

``` r
apply(movies[,18:24], 2, sum)
```

## Excercise 2:

``` r
tapply(movies$rating,list(movies$Action, movies$Documentary), mean)
```

## Excercise 3:

``` r
vapply(movies[,3:6], fivenum, c(Min.=0, "1st Qu."=0, Median=0, "3rd Qu."=0, Max.=0))
```

## Excercise 4:

``` r
sapply(colnames(movies)[3:6], function(x) glm(as.formula(paste(x, " ~", paste(colnames(movies)[18:24], collapse = "+"))), data=movies)$coefficients, USE.NAMES = T)
```

## Excercise 5:

``` r
lapply(split(movies_sub, movies_sub$genres), function(x) summary(glm(formula = rating ~ budget, data =x))$coefficient)
```
