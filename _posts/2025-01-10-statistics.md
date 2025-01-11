---
layout: single
title: "Statistics"
date: 2025-01-10
excerpt: "We will be going through concepts of basic statistics necessary for actuaries and how to apply them in R."
author: Nicholas Wijaya
toc: true
classes: wide
header: 
  image: "/assets/images/stat.jpg"
permalink: /posts/statistics/
published: true
draft: false
tags: [post, statistics]
---

<style>
  .page-header img {
    max-width: 100%; /* Adjust as needed */
    height: auto;    /* Maintain aspect ratio */
    width: 50%;      /* Example: Scale to 50% of the container's width */
    display: block;
    margin: 0 auto;  /* Center the image */
  }
</style>

>*Statistics is the forefront of science. It helps people of different fields make informed decisions. It is also the same in risk management. Statistics can help companies quantify the probability of going insolvent. Statistics plays a big part in informing the likelihood of some amount of claims being made. Shortly speaking, statistics is the foundation for almost all concepts in risk management. Therefore, I am dedicating this post to re-exploring the basic statistical concepts to refresh your memory.*

# Distributions in Statistics

## Random Variable and Distribution

In elementary statistics, we have surely come across the random variable. A random variable (notation capital $X$, capital $Y$, etc.) can be seen as a random realisations (small $x$, small $y$) of something measurable. For example, the time needed to travel from A to B or the weight of chickens. Statistics tells us that such random variable has a distribution that tells us how random realisations of the random variable is spread. 

Of course we should remember there will certainly be cases where realisations can be <em style="font-style:bold;">discrete</em> or <em style="font-style:bold;">continuous</em>. A discrete realisation can be number of claims per interval, while a continuous realisation can be something as time taken to travel. Hence, we see the split of discrete distributions and continuous distributions.

Distributions can be described by this set of default matrics that is the mean and variance. The mean tells us the average values of the random realisations, while the variance tells us the spread of such random realisations from the mean. However, we will come to see that not all distributions directly have these parameters. 

A very common continuous distribution out there is the Normal Distribution. The Normal distribution tells us directly that some random variable is distributed with some arbitrary mean $\mu$ and some arbitrary standard deviation $\sigma$. A common discrete distribution is the Poisson distribution that has a lambda parameter. The $\lambda$ parameter tells us the expected rate of which an event (that is Poisson distributed) occurs at some fixed interval. In this case we are not explicitly given the mean and variance, but the mean and variance can be found using the $\lambda$. Lambda of $5$ essentially tells us that the average of the different realisations of the Poisson distributed random variable will be 5.

Every random variable that has a distribution will have these probability metrics: the probability density function (pdf), the cumulative distribution function (cdf), and the quantile function.

In R, distributions are given different codes. These codes are imperative in order to execute R functions of the pdf, cdf, and the quantile. For instance, a Poisson distribution is noted as <em style="font-style:bold;">pois</em> in R. The Normal distribution is noted as <em style="font-style:bold;">norm</em> in R. To know more about the distribution codes in R, execute the command <em style="font-style:bold;">?distribution</em>.


## Probability Density Function (pdf)

The probability density function (pdf) is a function that gives us the probability mass of a random variable $X$ taking on some realisation $x$, $X=x$.

$$ 
P[X=x] = pdf(x)
$$

In Rstudio, the function to find the density function is d<<distribution code>>. It can be dnorm(), dpois(), et cetera.

```r
# Find probability of a realization of 8 in a Poisson distribution with lambda 5
dpois(8, lambda=5)
[1] 0.06527804

#To visualise the pdf of the Poisson distribution of lambda 5, we can do as follows:

```
 
## Cumulative Distribution Function (cdf)

The cumulative distribution function is the function that gives us the probability mass of a random variable $X$ being less than some realization $x$, $X<x$. 

$$
P[X < x] = cdf(x)
$$

In Rstudio, the function to find the density function is p<<distribution code>>. It can be pnorm(), ppois(), et cetera.

```r
# Find probability of that a realization is less than 8 in a Poisson distribution with lambda 5
ppois(8, lambda=5)
[1] 0.9319064
```

## Quantile Function
The quantile function on the other hand is the inverse of the cdf function. It basically finds the realisation as a threshold for which a given percentage/quantile (p, which we set) of realisations falls below it.

$$
\text{Quantile Function} = \text{cdf}^{-1}(x)
$$

In Rstudio, the function to find the quantile function is q<<distribution code>>. It can be qnorm(), qpois(), et cetera.

```r
# Find the realisation (threshold) for which 70% of the observations of Poisson distribution of lambda 5 lie below this threshold.
ppois(8, lambda=5)
[1] 6
```

## Generating Realisations of some Distribution in R

We can use the function of r<<distribution code>> to generate realisations of some code. It can be rnorm(), rpois(), et cetera. The 

```r
#Generate 1000 realisations of a Poisson random variable with lambda 5
set.seed(10) #Ensures the command below generates same results
rpois(n=5, lambda=5)
[1] 5 4 4 6 2 3 4 4 5 4
```

## Visualising the Univariate pdf and cdf of Continuous and Discrete Functions

Visualising graphs of the pdf and cdf are equally important. They allow us to see how the probability function develops as the realisations changes.

```r
#First, we need to generate realisations (1000 of them) of a Normal(0,1) distribution (Continuous)
set.seed(100)
# Generating more realisations (1000) will give a more accurate x-range to work with later on.
gen_norm <- rnorm(1000, 0, 1)

#We make use of our realisations to findthe range of x values that we can generate to build the pdf and cdf graphs #of Normal(0,1) using the histogram function, that way we ensure a accurate pdf and cdf graph (to the tails of the #distribution) is shown.
hist(gen_norm) 

#We see that the realisations of a Normal distribution therefore lies between -3 and 3. These can be used
#to construct the sequence of x-values to use for the pdf and cdf graphing. I am not going to show the picture. Reader can confirm by using the code by oneself.

#Start coding inputs for the pdf graph
x_val <- seq(-3,3, length.out=50) #Create x-values sequence to input into the pdf function
pdf_val <- dnorm(x_val, 0, 1) #Returns values of pdfs for every x value (realisation) input
plot(x_val, pdf_val, type="l")
cdf_val <- pnorm(x_val, 0, 1) #Returns values of cdfs for every x value (realisation) input
plot(x_val, cdf_val, type="l")
abline(h=1, lty=3); abline(h=0, lty=3) #Visual barrier to tell us that CDF graph lies between 0 and 1 
```
<img src="https://actuary492.github.io/assets/images/cdfpdf.jpeg" alt="description" style="width: 100%; height: 80%;">

We can see for instance through the pdf function, which realisation holds the most probability mass in the $Normal(0,1)$ distribution or how the tails of the distribution look like. On the other hand, the cdf function allows to find important quantiles of the distribution. 

Note that I have graphed a continuous distribution above. If the distribution is discrete, then the pdf and cdf's functions cannot be presented by straight line. In the case of the cdf of Poisson, the graph would look like a step function. In the case of Poisson pdf, the graph would look more like a histogram. Making these plots can be done by adding the argument of $type="s"$ and $type="h"$ in the $plot()$ function of the cdf and pdf respectively.Take the visualisation of the Poisson(5) pdf and cdf. Since the code is rather repetitive, I will directly show the graphs while the code will still be available in the R-file itself.


<img src="https://actuary492.github.io/assets/images/cdfpdfpoi.jpeg" alt="description" style="width: 100%; height: 80%;">


## Multivariate Distributions and Some Useful Commands in R

The concepts that we dealt above was in the univariate case, which means we are only dealing with one random variable. However, we should know that in reality it is not as simple as that. Take for instance in risk management, we expect to deal with multiple random individual claims in a portfolio, that can be $X_1$, $X_2$ up to $X_n$ where each belongs to some distribution. This requires we know joint distribution of all those random variables to be able to calculate metrics such as the pdf, cdf, quantiles related to these random variables.

Let us take a multivariate normal distribution as an example.

We need to note some changes to elements of the multivariate normal distribution versus the univariate normal distribution. A clear thing is while we dealt with only single values of mean and variance to describe the normal distribution in the univariate model. However, we now deal with vector of means and a variance-covariance matrix to describe distribution in the multivariate model. This should be logical as we assume every random variable possesses it's own mean, hence the vector of means. We also assume by default that there is correlation between these random variables, and these are used to calculate the variance and covariances between variables that belongs in the variance-covariance matrix. Unless stated otherwise where there is no correlation between variables, covariances between random variables are esentially zero leaving us a diagonal variance matrix only consisting of variances of every random variable on the diagonals.

To help visualise:

Univariate Normal Distribution pdf that requires only one mean ($\mu$) and one variance ($\sigma^2$) with a single number input $x$.

$$
f(x) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left(-\frac{(x - \mu)^2}{2\sigma^2}\right)
$$


Multivariate (n) Normal Distribution pdf which requires multiple means stored as a vector (bolded $\mu$) and multiple variances and covariances stored as a variance-covariance matrix (bolded $\Sigma$) with potentially multiple inputs of $x_1$, $x_2$ until $x_n$ as a vector (bolded $x$).

$$
f(\mathbf{x}) = \frac{1}{(2\pi)^{n/2} (\det \boldsymbol{\Sigma})^{0.5}} \exp\left[-\frac{1}{2} (\mathbf{x} - \boldsymbol{\mu})' \boldsymbol{\Sigma}^{-1} (\mathbf{x} - \boldsymbol{\mu})\right]
$$


To illustrate how to use the built-in multivariate function in R, I attempt calculate the bivariate normal pdf (as a case of the multivariate distribution) in R, using the function dmnorm(). In other words we aim to find $P[X = 1 , Y = 1]$.

```r
# First, we construct the mean vector and variance-covariance matrix of the bivariate normal distribution
mean_vecx<-c(2,5) # mu
varX<-4; varY<-16; corXY<-0.1
covXY<-corXY*(varX*varY)^0.5
covar_matx<-matrix(c(varX,covXY,covXY,varY),2,2)

#Now, we want to find the probability of A=1 and B=1
input_vector <- c(1,1) #Inputs of realisations a=1 and b=1 for the pdf 
dmnorm(input_vector, mean_vecx, covar_matx) #Finds the pdf of P[X=1, Y=1]
[1] 0.0111859
```

We can also find the cdf of multivariate distributions using pmnorm(), which we can see as the joint probability that $X$ lies below some realisation $x$ and $Y$ lies below some realisation $y$, that is $P[X<x , Y<y]$. We can also generate realisations of the bivariate distribution using rmnorm(). This command will generate some number of realisations of every random variable in the multivariate distribution by columns. One can try to practice by finding pdf's and cdf's of higher variate distributions, for instance of 3 random variables.

```r
#Find the cdf of a bivariate normal distribution with same input, that is P[X<1. Y<1]
pmnorm(input_vector, mean_vecx, covar_matx)
#Set number of simulations and set.seed() to ensure you produce same results
set.seed(110); number_sims <- 15
rmnorm(number_sims, mean_vecx, covar_matx)
```

## Creating pdf and cdf graphs of the bivariate distribution (as a sample of the multivariate distribution)

It is equally important to know how to graph the bivariate pdf and cdf. The purpose of illustrations remain the same as in the univariate case, to understand important data points that give the most probability mass and to identify important quantiles of the distribution. Below is the code to do so.

```r
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
persp(x_biv, y_biv, pdf_valbiv, xlab="x", ylab="y", zlab="Bivariate PDF", main="Bivariate PDF Perspective plot")
contour(x_biv, y_biv, pdf_valbiv, xlab="x", ylab="y", main="Bivariate PDF Contour plot")
par(mfrow=c(1,2))
persp(x_biv, y_biv, cdf_valbiv, xlab="x", ylab="y", zlab="Bivariate CDF", main="Bivariate CDF Perspective plot")
contour(x_biv, y_biv, cdf_valbiv, xlab="x", ylab="y", main="Bivariate CDF Contour plot")
```
<img src="https://actuary492.github.io/assets/images/bivpdf.jpeg" alt="description" style="width: 100%; height: 80%;">
<img src="https://actuary492.github.io/assets/images/bivcdf.jpeg" alt="description" style="width: 100%; height: 80%;">

We should note that contour plots are esentially horizontal slices of the perspective plots.

Due to limitations in R we are only allowed to graph at best a 3-dimensional plot. Thus if one is presented with a tri-variate distribution (three random variables) or further, then one only has the capability to plot different bivariate combinations of the trivariate (or multivariate) distribution. It also logical that a larger dimensional graph would not be handy either as it would be hard to interpret. Nevertheless, this will be still be useful to us. Why? Through pairwise plots of the three (or multiple) variables, we can potentially identify dependencies of these variables while marginalising the others. 


# Descriptive Statistics

Descriptive statistics as we will see below can be very useful to show distributions of single variables and the pairwise descriptive statistics and visualisations of multiple variables.

## summary() Function

We can use the summary() function in R to look at important descriptive statistics. This function produces a list of important descriptive statistics that can inform the user on how the dataset is distributed. Let us take a summary of the $\text{Trees}$ base dataset in R.

```r
library(datasets) #install.packages("datasets") if not yet installed
trees #trees dataset is base dataset, there is no need to load it, simply typing trees will show
colnames(trees)[1] <- "Diameter" # change column name from "Girth" to "Diameter"
summary(trees)

    Diameter    Height       Volume     
 Min.   : 8.30   Min.   :63   Min.   :10.20  
 1st Qu.:11.05   1st Qu.:72   1st Qu.:19.40  
 Median :12.90   Median :76   Median :24.20  
 Mean   :13.25   Mean   :76   Mean   :30.17  
 3rd Qu.:15.25   3rd Qu.:80   3rd Qu.:37.30  
 Max.   :20.60   Max.   :87   Max.   :77.00  
```

The summary gives us important statistics such as the minimum and maximum values of the variable in the datasets, and important quantiles.

To find the most common descriptive statistics of mean, variance, correlation in R, we can use mean(), var(), and cor().

## Scatter Plots and Pairwise Plots

There are also functions that can help visualise distributions of the data. 

Take for instance the built-in functions of plot() which gives us the scatter plot between Diameter, Height and Volume. Via this scatterplot we will be able to deduce important relationships of variables. For instance, we can see that there is a extremely positive correlation between the variable Diameter and Volume simply by looking at the plots below without having to know the precise correlation coefficient.

```r
#Pairwise scatter plots of all variables in the trees data
plot(trees)
```
<img src="https://actuary492.github.io/assets/images/scat.jpeg" alt="description" style="width: 80%; height: 80%;">

Another useful function is the histogram. This allows us to see the spread of a variable. We can use hist(). Let us find the histogram of the variable Diameter in the trees dataset.

```r
# The histogram shows spread using frequency or probabilities (when freq=FALSE added)
hist(trees$Diameter, freq=FALSE) 
```
<img src="https://actuary492.github.io/assets/images/hit.jpeg" alt="description" style="width: 80%; height: 80%;">

The most informative built-in function for descriptive statistics is the pairs.panels() data. The built-in function creates pairwise plots of regression lines, histogram and correlation coefficients of variables in the data that shows the relationship between variables in a data which can be useful.

```r
# Pairwise plots shows distribution of dataset by displaying numerous descriptive statistics visualisations
pairs.panels(trees)
```
<img src="https://actuary492.github.io/assets/images/panel.jpeg" alt="description" style="width: 80%; height: 80%;">

This is everything so far on basic descriptive statistics. Of course, there are more built-in functions out there which I might not have discussed. It is always wise to explore those further.

# Hypothesis Testing: The Basis to all Statistical Tests

A hypothesis that states something about a population is true or not. If a hypothesis is not true, there should be an alternative hypothesis. Therefore through hypothesis testing, we attempt to either accept one hypothesis while rejecting the other. We normally call the two hypotheses as the null hypothesis and the alternative hypothesis. This is done by incorporating statistical tests that can help aid in forming such conclusion. Of course, there is a chance that we do not arrive at the correct conclusion, such as when one rejects the null hypothesis given the null hypothesis is true, or accepting the null hypothesis when the null hypothesis is false. This is called the type I error and type II error respectively. A type I error is considered to be more serious than a type II error, hence hypothesis testing is based on trying to limit the probability of making a type I error to some level called the significance level ($\alpha$).


## p-value as a Statistical Concept for Hypothesis Testing 

In elementary statistics classes, you might have learned hypothesis testing by first determining some significance level, then constructing some rejection region based on that significance level that can reject the null hypothesis, before calculating some test statistic based on observed data which we check lies in the rejection region or not. If the test statistic lies in the rejection region, we reject the null, otherwise, we accept the null. However, most built in hypothesis testing functions in statistical softwares do not show rejection regions. Rather, they produce quick ouputs of some test-statistic with it's associated p-value which we can directly compare to some significance level to conclude the hypothesis test. It is not to say that knowing how to find rejection regions is unimportant, but I will only be focusing on the p-value in this article due to it's popular use in softwares. The reader can do self-study on how rejection regions are constructed. 

The p-value tells us the probability of obtaining a test statistic more extreme (and/or equal) than what is observed (from the data we use for hypothesis testing), given that the null hypothesis is true and this serves as evidence against the null hypothesis. Determining which extreme tail it is ($\geq$ or $\leq$) requires that we understand the alternative hypothesis. If the alternative hypothesis deems that a population mean is lower than some value, in order to reject $H_0$, then we need to show probability of the observing an even lower sample mean than on our observed data given the null hypothesis to help with "finding" the evidence against the null.

$$
\text{p-value} = P[Test statistic \geq x | H_0 true]
$$

$$
\text{p-value} = P[Test statistic \leq x | H_0 true]
$$

With the explanation above in mind, a small p-value therefore tells us such that the test statistics we observed, and it's tails is very extreme and unlikely to occur under the null hypothesis. 

If the null hypothesis were to be true, the probability of the observed test statistic and it's extremes occuring under the null hypothesis should be fairly large. The fact that the probability of the observed test statistic and it's extremes occuring is very rare on the distribution under the null, should allow us to question whether the null is correct. This is equivalent to saying that even though the null had predicted your observed test statistic to be an unlikely occurence, yet you still observed it through your dataset, suggesting $H_0$ might not be the best explanation for the data. 

Hence, a small probability value is seen as "evidence" to reject the null hypothesis. "Evidence" does not tell us $100%$ that the null hypothesis is false, simply that the evidence we received (based on observed data) shows that we should reject the null hypothesis. 

Linking this to the significance level, we can look at this as the threshold of how large of a p-value or in other words, how extreme can an observation be in order to consider that it does not belong to the distribution under the null. In most literature, a 5% significance level is deemed enough to draw a conclusion. In other words, if the probability of obtaining an equal or more extreme test statistic than observed is less than 5%, then we have sufficient evidence to reject the null hypothesis. 

# Types of statistical tests

There are sev

# The Maximum Likelihood Concept

