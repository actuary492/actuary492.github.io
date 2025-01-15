---
layout: single
title: "Linear Regression"
date: 2025-01-10
excerpt: "We will explore concept of linear regression and how to use it in R"
author: Nicholas Wijaya
toc: true
classes: wide
header: 
  image: "/assets/images/regression.jpg"
permalink: /posts/regression/
published: false
draft: false
tags: [post, regression]
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

>*Regression lies at the heart of science. This concept is useful when we aim to investigate whether some predictor variable has an effect to some response variable and potentially quantify it's effect. In risk management modelling, think for instance investigating whether age, location or number of claims in a previous period of the individual may have an effect on the claims in the current period. Having an overview of all possible factors that can influence claims is important to get an overview of where one's risk is precisely coming from. In fact, this analysis does require a variation of the regression method than the one we will be discussing in this article. Here, I will only explain linear regression, and further articles shall follow on the different types of regression models.*

# Regression

The regression model theory is expressed as follows:

$$
Y = f(X_1, X_2, ... , X_p) + error
$$

where $f()$ is essentially some objective function that can be linear, polynomial containing predictor variables $(X_1, ... , X_p)$ that attempts to model (explain) the response variable $Y$ and predict potential reponses $\hat{Y}$. In this article, we will be only focusing on linear regression, where the regression model shall only contain predictor variables of at most to the power of $1$.

# Linear Regression Model

Assume that we have a dataset of pairs $(x_i, y_i)$ from $i = 1,2,..., p$. We can express the supposedly linear relationship between $y_i$ and $x_i$ as follows:

$$
y_i = \alpha + \beta x_i + e_i
$$

The $\alpha$ and $\beta$ are estimates to be calculated in order to complete the model. The error term $e_i$ is the difference between the observed $y_i$ and the estimated $\hat{y_i}$ using the estimates $\hat{\alpha}$ and $\hat"{\beta}$ and fixed $x_i$ observations. 

$$
\hat{y_i} = \hat{\alpha} + \hat{\beta} x_i
$$

## Assumptions of the Linear Regression Model

An important assumption in this model is that the errors are conditionally normally distributed $e|X=x$ with mean 0 and finite constant variance $\sigma^2$, $e|X=x \sim N(0, \sigma^2). Why conditional on X=x? Fixed $x_i$'s are assumed in order to generate predictions $\hat{y_i}$ used to calculate errors. Random error realisations are therefore dependent on fixed $x_i$.

This means that the average of errors shall be zero meaning the model shall not over-or-underpredict $y_i$. The constant variance tells us that spread of errors must remain the same across all values of the predictor $x_i$. If the spread of errors is different for different fixed $x_i$, it tells us that the model predictions are reliable for some values of $x_i$ than the others, which can invalidate conclusions from the model.

As $y_i$ is directly dependent on the errors ($\text{errors} = $y_i$ - $\hat{y_i}$, it means that we need to know for this linear regression model is that the response $y_i$ must strictly be a continuous variable in order to satisfy the continuous nature of the normally-distributed errors and make sense of the linear regression model (remember normal distribution is a continuous distribution). 

However, $x_i$ can be discrete or continuous. There are no particular assumptions made on $x_i$ in the model because the aim of the , thus as long there is a linear relation between $y_i$ and $x_i$ that can be explained through the coefficients $\alpha$ and $beta$, the linear regression model shall hold regardless of the nature of the variable $x_i$. 


## Finding $\beta$ through calculations


## Quantifying accuracy of $\beta$


## Violation of Assumptions in Linear Regression


# Multiple Linear Regression


## Choosing the best model in Multiple Linear Regression by use of Statistical Tests

### Types of Selection Tests

### Commands in R to Select Models


# Dummy and Categorical Variables






