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

Of course we should remember there will certainly be cases where realisations can be <em style="font-style:bold;">discrete</em> or <em style="font-style:bold;">continuous</em>. A discrete realisation can be number of claims per interval, while a continuous realisation can be something as time taken to travel. We definitely cant say that one has made 34.56 claims hence it's discrete nature. On the other hand, 34.56 minutes does still make sense, hence it's continuous nature.

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
```
 
## Cumulative Distribution Function (cdf)

The cumulative distribution function is the function that gives us the probability mass of a random variable $X$ being less than some realization $x$, $X<x$. In other words, we can see this probability as the percentage of realisations that lie below some certain realisation x.

$$
P[X < x] = cdf(x)
$$

In Rstudio, the function to find the density function is d<<distribution code>>. It can be pnorm(), ppois(), et cetera.

```r
# Find probability of that a realization is less than 8 in a Poisson distribution with lambda 5
ppois(8, lambda=5)
[1] 0.9319064
```

## Quantile Function
The quantile function on the other hand is the inverse of the cdf function. It basically gives us the realisation as threshold for which a given percentage of realisations falls below this threshold. The percentage is known as the quantile of the distribution.

$$
\text{Quantile Function} = \text{cdf}{-1}(x)
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

## Multivariate Distributions and Some Useful Commands in R

The concepts that we dealt above was in the univariate case, which means we are only dealing with one random variable. However, we should know that in reality it is not as simple as that. Take for instance in risk management, we expect to deal with multiple random individual claims in a portfolio, that can be $X_1$, $X_2$ up to $X_n$ where each belongs to some distribution. This requires we know joint distribution of all those random variables to be able to calculate metrics such as the pdf, cdf, quantiles related to these random variables.

Let us take a multivariate normal distribution as an example.

We need to note some changes to elements of the multivariate normal distribution versus the univariate normal distribution. A clear thing is while we dealt with only single values of mean and variance to describe the normal distribution in the univariate model. However, we now deal with vector of means and a variance-covariance matrix to describe distribution in the multivariate model. This should be logical as we assume every random variable possesses it's own mean, hence the vector of means. We also assume by default that there is correlation between these random variables, and these are used to calculate the variance and covariances that belongs in the variance-covariance matrix. Unless stated otherwise where there is no correlation between variables, covariances between random variables are esentially zero leaving us a diagonal variance matrix only consisting of variances of every random variable on the diagonals.

To visualise, we compare:

Univariate Normal Distribution pdf



Multivariate Normal Distribution pdf

$$
f(\mathbf{x}) = \frac{1}{(2\pi)^{d/2} (\det \boldsymbol{\Sigma})^{0.5}} \exp\left[-\frac{1}{2} (\mathbf{x} - \boldsymbol{\mu})' \boldsymbol{\Sigma}^{-1} (\mathbf{x} - \boldsymbol{\mu})\right]
$$

where

$$
\boldsymbol{\mu} = 
\begin{bmatrix}
\mu_1 \\
\mu_2 \\
\vdots \\
\mu_d
\end{bmatrix}
= 
\begin{bmatrix}
\mathbb{E}[X_1] \\
\mathbb{E}[X_2] \\
\vdots \\
\mathbb{E}[X_d]
\end{bmatrix}
$$




# Descriptive Statistics

# Statistical Tests

# The Maximum Likelihood Concept

