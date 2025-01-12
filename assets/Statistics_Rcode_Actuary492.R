  # Statistics in R
library(mvtnorm)
library(mnormt)
library(psych)
library(MASS)
library(nortest)

# Random Variables & Distributions

  #Univariate case:

# Find probability of a realization of 8 in a Poisson distribution with lambda 5
dpois(8, lambda=5)

# Find probability of that a realization is less than 8 in a Poisson distribution with lambda 5
ppois(8, lambda=5)

# Find the realisation (threshold) for which 70% of the observations of Poisson distribution of lambda 5 lie below this threshold.
ppois(8, lambda=5)

#Generate 1000 realisations of a Poisson random variable with lambda 5
set.seed(10) #Ensures the command below generates same results
rpois(n=5, lambda=5)
    
#Visualising Univariate pdf and cdf graphs

#First, we generate realisations of a Normal(0,1) distribution (continuous)
set.seed(100)
gen_norm <- rnorm(1000, 0, 1)

#We make use of our realisations to findthe range of x values that we can generate to build the pdf and cdf graphs 
#of Normal(0,1) using the histogram function, that way we ensure a accurate pdf and cdf graph (to the tails of the 
#distribution) is shown.
hist(gen_norm)

#We see that the realisations of a Normal distribution therefore lies between -3 and 3. These can be used
#to construct the sequence of x-values to use for the pdf and cdf graphing.

#Start coding inputs for the pdf graph
x_val <- seq(-3,3, length.out=50) #Create x-values sequence to input into the pdf function
pdf_val <- dnorm(x_val, 0, 1) #Returns values of pdfs for every x value (realisation) input
cdf_val <- pnorm(x_val, 0, 1) #Returns values of cdfs for every x value (realisation) input
par(mfrow=c(1,2))
plot(x_val, pdf_val, type="l", main="PDF of Normal(0,1)")
plot(x_val, cdf_val, type="l", main="CDF of Normal(0,1)")
abline(h=1, lty=3); abline(h=0, lty=3) #Visual barrier to tell us that CDF graph lies between 0 and 1 

# We generate pdf and cdf graphs of the Poisson(5) distribution (discrete)
set.seed(100)
gen_pois <- rpois(1000, 5)

# Check range of realizations that allow us to 
par(mfrow=c(1,1))
hist(gen_pois)
x_val <- seq(0, 14, length.out=50)
pdf_val <- dpois(x_val, 5)
cdf_val <- ppois(x_val, 5)
par(mfrow=c(1,2))
plot(x_val, pdf_val, type="h", main="PDF of Poisson(5)")
plot(x_val, cdf_val, type="s", main="CDF of Poisson(5)")
abline(h=1, lty=3); abline(h=0, lty=3)


  # Mulitvariate Case: Bivariate Normal as Example

# First, we construct the mean vector and variance-covariance matrix of the bivariate normal distribution
mean_vecx<-c(2,5) # mu
varX<-4; varY<-16; corXY<-0.1
covXY<-corXY*(varX*varY)^0.5
covar_matx<-matrix(c(varX,covXY,covXY,varY),2,2)

#Now, we want to find the probability of A=1 and B=1
input_vector <- c(1,1) #Inputs of realisations a=1 and b=1 for the pdf 
dmnorm(input_vector, mean_vecx, covar_matx) #Finds the pdf of P[X=1, Y=1]

#Find the cdf of a bivariate normal distribution with same input, that is P[X<1. Y<1]
pmnorm(input_vector, mean_vecx, covar_matx)
#Set number of simulations and set.seed() to ensure you produce same results
set.seed(110); number_sims <- 15
rmnorm(number_sims, mean_vecx, covar_matx)

# Create pdf and cdf graphs of bivariate normal of the same parameters above
number_sims_new <- 1000
gen_biv <- rmnorm(number_sims_new, mean_vecx, covar_matx)
hist(gen_biv[,1], main="Spread of Random Variable X"); hist(gen_biv[,2],main="Spread of Random Variable Y")

#We see that for X, realisations lie between -4 and 8, while for Y, realisations lie between -5 and 20.

x_biv <- seq(-4, 8, 0.5); y_biv <- seq(-5, 20, 0.5)

#Create pdf function that allows us to input x and y realisations into the multivariate pdf 

pdf_biv <- function(x,y){dmnorm(cbind(x,y), mean_vecx, covar_matx)}
cdf_biv <- function(x,y){pmnorm(cbind(x,y), mean_vecx, covar_matx)}

# Now, we need to find values of the pdf for every different possible combinations of the x and y
# The function outer() does the trick for us. 

pdf_valbiv <- outer(x_biv, y_biv, pdf_biv)
cdf_valbiv <- outer(x_biv, y_biv, cdf_biv)

# The pdf we plot now is essentially a three dimensional plot, which we can display either 3-dimensionally by 
# a perspective plot persp() or a 2-dimensional contour plot
par(mfrow=c(1,2))
persp(x_biv, y_biv, pdf_valbiv, theta=-60, phi=30, expand=1, ticktype='detailed',xlab="x", ylab="y", zlab="PDF", main="Bivariate PDF Perspective plot")
contour(x_biv, y_biv, pdf_valbiv, xlab="x", ylab="y", main="Bivariate PDF Contour plot")
par(mfrow=c(1,2))
persp(x_biv, y_biv, cdf_valbiv, theta=-60, phi=30, expand=1, ticktype='detailed', xlab="x", ylab="y", zlab="CDF", main="Bivariate CDF Perspective plot")
contour(x_biv, y_biv, cdf_valbiv, xlab="x", ylab="y", main="Bivariate CDF Contour plot")





# Descriptive Statistics Functions

library(datasets) #install.packages("datasets") if not yet installed
trees #trees dataset is base dataset, there is no need to load it, simply typing trees will show
colnames(trees)[1] <- "Diameter" # change column name from "Girth" to "Diameter"
summary(trees)

#Pairwise scatter plots of all variables in the trees data
plot(trees)

# The histogram shows spread using frequency or probabilities (when freq=FALSE added)
hist(trees$Diameter, freq=FALSE) 

# Pairwise plots gives an complete overview of the dataset by displaying numerous descriptive statistics visualisations
library(psych) #install psych if not yet done
pairs.panels(trees)


  #Types of Statistical Tests

#Normality Test: graphical

#Using histogram + pdf

#Find mean and variance of the variable Height assuming it has normal distribution
mh <- mean(trees$Height); vh <- var(trees$Height)

#Graph the spread of the variable Height
hist(trees$Height, freq=FALSE, main="Graphically Testing Normality of Height")

#We see that height takes value from 60 to 90, thus we try to find pdf of these height values assuming
#height is normally distributed

lines(60:90, dnorm(60:90, mh, sqrt(vh)))

#The histogram and the pdf clearly tells us that Height is normally distributed via this method as the spread
#of the Height fits the pdf of the height assuming it was normally distributed with some mean and variance.

#Using QQ-plot
par(mfrow=c(1,3))
#The function qqnorm() produces the 
qqnorm(trees$Height, main="QQ Plot Height"); qqline(trees$Height)
qqnorm(trees$Diameter, main="QQ Plot Diameter"); qqline(trees$Diameter)
qqnorm(trees$Volume, main="QQ Plot Volume"); qqline(trees$Volume)

#Normality Test: analytical

#Jarque Bera Test
library(tseries)
jarque.bera.test(trees$Height); jarque.bera.test(trees$Diameter); jarque.bera.test(trees$Volume)

#Using significance level of 5%, there is evidence to suggest Height & Diameter are normally distributed, 
#while there is no evidence suggesting Diameter is normally distributed.

#Shapiro Test
shapiro.test(trees$Height); shapiro.test(trees$Diameter); shapiro.test(trees$Volume)

#Using significance level of 5%, it has same conclusion as the Jarque-Bera Test

#Anderson Darling Test
ad.test(trees$Height); ad.test(trees$Diameter); ad.test(trees$Volume)

#Kolmogorov-Smirnov Test 1: Using significance level 5%, there is evidence to suggest Height is normally distributed, 
#while there is no evidence to suggest Diameter and Volume is normally distributed

ks.test(trees$Height,"pnorm", mean(trees$Height), var(trees$Height))
ks.test(trees$Diameter,"pnorm",mean(trees$Diameter),var(trees$Diameter))
ks.test(trees$Volume,"pnorm",mean(trees$Volume),var(trees$Volume))

#Kolmogorov-Smirnov Test 2: Testing if Gamma(1,5) is equivalent to Exp(5)

#In theory, these should be equal, what about by test?

set.seed(100)
ks.test(rgamma(1000, 1, 5), rexp(1000, 5))

# The p-value tells us there is evidence that both of them are of the same distribution, aligning with theory.


  # T-tests

# T- tests for one-sample
xt_test <- rnorm(1000, mean=3) #generate normal distribution of N(3,1)
t.test(xt_test, mu=0)

# The p-value is smaller than 5%, giving us evidence to reject the null which states that mu is 0.
# This should be logical because our sample was generated as a N(3,1) distribution.

# T- tests for two-samples
yt_test <- rnorm(1000, mean=0) #generate normal distribution N(0,1)
t.test(xt_test, yt_test, var.equal=TRUE)


  #Equal Variance Tests

var.test(xt_test, yt_test)


  # Maximum Likelihood Optimization

# Construct data set of realisations of random variable Y
y <- c(225, 171, 198, 189, 189, 135, 162, 135, 117, 162)

# We believe that our observations is best explained by a Exponential distribution, but we need to find the parameter for the Exponential distribution

# Construct the likelihood function of the random variable Y
L <- function(theta){Y = prod(exp(-y/theta)/theta) ; Y}

# Find the parameter of the Exponential Distribution that best explains the data (maximizes the likelihood)
a=optimize(L, c(1,500), maximum = TRUE)
a$maximum
mean(y)

  # fitdistr()

y_fit <- rexp(1000, 5)

# We want to find the parameter that fits the realisations. Through the code above, we expect the rate of the exponential to be close to 5

fit <- fitdistr(y_fit, "exponential")

fit$est
