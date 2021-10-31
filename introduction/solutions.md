# Introduction to R Practical (Solutions)

## Objectives

By the end of this practical it is intended that you will be able to:

* Extract variables from a data frame
* Summarise categorical and continuous variables
* Basic plots
* Basic statistical analysis

Begin by opening RStudio and starting a new script file. Type all your code into your R script file, writing the question number and making comments with the # symbol. For example:

```{r,eval=F}
## 1: Set the working directory
# This command sets the working directory to your documents, e.g. C:/Users/user/Documents

setwd("C:/Users/user/Documents")
```

The **setwd** function sets the working directory to a given directory, e.g. C:/Users/user/Documents

It is good practice to comment your code and split it up into sections.

## Loading and navigating a data frame

This practical is based around the Hosmer and Lemeshow data on birthweight ([lbw.csv](lbw.csv?raw=1)). Download this file to your working directory.

The **lbw** data frame contains the following information:

```{r tab1, echo=FALSE, results = "asis"}
#load knitr library
library(knitr)

#Define a vector of variable names
Variable<-c("id","low","age","lwt","race","smoke","ptl","ht","ui","ftv","bwt")

#Define a vector of variable descriptions
Description<-c(
  "identification code",
  "low birthweight (0 = birthweight>=2500g, 1 = birthweight<2500g)",
  "age of mother (years)",
  "weight of mother at last menstrual period (pounds)",
  "race (1 = white, 2 = black, 3 = other)",
  "smoked during pregnancy (0 = no, 1 = yes)",
  "premature labour history (count)",
  "has history of hypertension (0 = no, 1 = yes)",
  "presence of uterine irritability (0 = no, 1 = yes)",
  "number of visits to physician during 1st trimester",
  "birthweight (grams)"
)
  
#Define a dataframe containing variable names and descriptions
tabdat<-data.frame(Variable,Description)

#Generate table in RMarkdown document
kable(tabdat,caption= "Variables in the lbw dataset")

```

### Loading the lbw dataset

1. Start your R script by setting the working directory

2. Load the dataset into your R environment

```{r}
lbw <- read.csv("lbw.csv")
```

The **lbw** object is stored as a particular type of R object called a *data frame*.

3. The **names** function gives the list of variables stored in a *data frame*. So using the names function will show a list of column names:

```{r}
names(lbw)
```

The column names can be used to extract the relevant variables by using the **$** symbol. For instance, the R command:

```{r}
lbw$bwt
```

extracts the **bwt** variable. 

Square brackets can also be used to obtain specific information from a data frame. We can either use a variable name or index number for the information we want.

Think of the data frame as a matrix with a specific number of columns and rows. We can use a pair of square brackets after the name of a data frame to select information. This takes the form **dataframe[row,column]**. So for example, the commands:

```{r}
lbw[1,]
lbw[,1]
lbw[2,1]
```

select row 1 of the lbw dataframe, column 1 of the lbw dataframe,
and the value in row 2 and column 1 of the data frame respectively.

### Exercise 1:

a.	Write an R command that will display the **bwt** variable using square brackets.

**As bwt is the variable corresponding to column 11 in the lbw data frame, we can use either of the following commands:**


```{r}
lbw[,"bwt"]

#or

lbw[,11]

```

We can also add a new variable to a data frame using the $ and <- symbols. For example, to make a variable to indicate very low birthweight, we might use the R command:

```{r}
lbw$vlow <- lbw$bwt < 1500 
```

R uses a standard logic syntax, and good guide to logical operators available can be found [here](https://www.statmethods.net/management/operators.html).

### Exercise 2:

a.	Try this command, and examine its effect on the **lbw** data frame using the **names** and **head** functions.

**Using names and head we can see that vlow has been added to the lbw data frame:**

```{r}
names(lbw)
head(lbw)
```

## Summarising continuous variables

The following R code contains examples of functions that could be used to summarise a continuous variable, in this case the maternal age:

```{r}
mean(lbw$age)
sd(lbw$age)
median(lbw$age) 
IQR(lbw$age) 
mad(lbw$age) 
min(lbw$age) 
max(lbw$age) 
range(lbw$age) 
summary(lbw$age) 
```

### Exercise 3:

a.	Write down the names of the statistics that each of these functions calculates, by looking at the help file of the function (using **help** or **?()**)

**These functions compute the following statistics: mean, standard deviation, median, interquartile range, mean absolute deviation, minimum, maximum, range, and list of minimum, lower quartile, median, mean, upper quartile and maximum.**

b.	Use one or two of these functions to summarise the maternal age for cases with low birthweight (less than 2500g).

**The mean and standard deviation of age for mothers who have offspring with low birthweight (bwt<2500) can be computed using:**

```{r}
mean(lbw$age[lbw$bwt<2500])
sd(lbw$age[lbw$bwt<2500])

```

or

```{r}
mean(lbw$age[lbw$low==1])
sd(lbw$age[lbw$low==1])

```

The R function **cor** calculates the correlation between two continuous variables. For instance, the R command:

```{r}
cor(lbw$lwt, lbw$bwt)
```

calculates the correlation between **lwt** and **bwt**.

### Exercise 4:

a.	Calculate the correlation of **age** with **lwt** and **bwt**.

**Likewise, the correlation of age with lwt and bwt can be computed using:**

```{r}
cor(lbw$age, lbw$lwt)
cor(lbw$age, lbw$bw)
```

## Summarising categorical variables

Categorical variables are usually summarised in frequency tables. The table function is used to create frequency tables. For example:

```{r}
table(lbw$ptl)
```

creates a simple frequency table for the premature labour variable. Additional variables can be added as additional arguments to create cross-tabulations. For instance, the R command:

```{r}
table(lbw$ptl, lbw$smoke)
```

creates a cross-tabulation of premature labour with smoking during pregnancy.

### Exercise 5:

a.	It is useful to be able to recall the table output later, so write an R command that will store the output of the above cross-tabulation in an R object called **ptl_smoke**.

**The cross-tabulation of ptl and smoke can be assigned to ptl_smoke using:**

```{r}
ptl_smoke <- table(lbw$ptl, lbw$smoke) 
```

b.	Write an R command that will produce a three-way cross-tabulation between **ptl**, **smoke** and **ht**.

**The three-way cross-tabulation of ptl, smoke and ht can be generated using:**

```{r}
table(lbw[,c("ptl", "smoke", "ht")])
```

We can add marginal totals to the table with the **addmargins** function. The R command:

```{r}
addmargins(ptl_smoke)
```

adds marginal totals to the table stored in the previous question. We can also re-express the table as proportions rather than frequencies. The following R commands use the **prop.table** function to achieve this:

```{r}
prop.table(ptl_smoke, 1) 
prop.table(ptl_smoke, 2) 
prop.table(ptl_smoke) 

```

### Exercise 6:

a.	How do these three different ways of using the **prop.table** function differ in their output?

**Each command gives row proportions, column proportions and overall proportions respectively.**

## Plotting the data

We can use the **plot** function generate a scatter plot showing bwt versus lwt:

```{r}
plot(lbw$lwt, lbw$bwt, xlab = "Maternal weight at last menstrual period", 
    ylab = "Birthweight", main = "Birthweight vs maternal weight")

```

### Exercise 7:

a.	Use the **hist** and **boxplot** to investigate the distribution of age.

**The histogram of age can be plotted using:**

```{r}
hist(lbw$age, xlab="Maternal age", main="Histogram of maternal age") 
```

**The box plot of age can be plotted using:**

```{r}
boxplot(lbw$age, ylab="Maternal age", main="Box plot of maternal age") 
```

## Linear regression
The following R command performs a basic linear regression of **bwt** against **lwt**:

```{r}
lm(bwt ~ lwt, data=lbw) 
```

The first argument **bwt ~ lwt**, the formula, describes the dependent and independent variables in the linear regression. The second argument **data=lbw** specifies that **bwt** and **lwt** can be found in the **lbw** data frame. The output of lm only provides the beta coefficients. We can store all this information by storing the output as an R object, for instance with the command:

```{r}
model <- lm(bwt ~ lwt, data=lbw)
```

### Exercise 8:

a.	What happens when you apply the summary function to the R object **model**?

**The summary function gives you more information on the regression model (e.g. standard errors of the regression coefficients):**

```{r}
summary(model)
```

b.	Use the **names** function to see what named objects are available in **model** (an explanation is available in the **lm** help file).

**The names function can be used to show the components within model:**

```{r}
names(model)
```