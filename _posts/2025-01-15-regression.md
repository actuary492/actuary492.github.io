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

>*Regression lies at the heart of science. This concept is useful when we aim to investigate whether some predictor variable has an effect to some response variable and potentially quantify it's effect. In risk management modelling, think for instance investigating whether age, location or number of claims in a previous period of the individual may have an effect on the claims in the current period. Having an overview of all possible factors that can influence claims is important to get an overview of where one's risk is precisely coming from. In fact, this analysis does require a variation of the regression method than the one we will be discussing in this article. Here, I will only explain the basic concept of linear regression, and further articles shall follow on the different types of regression models.*

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

The $\alpha$ and $\beta$ are estimates to be calculated in order to complete the model. The error term $e_i$ is the difference between the observed $y_i$ and the estimated $\hat{y_i}$ using the estimates $\hat{\alpha}$ and $\hat{\beta}$ and the given fixed $x_i$ observations. 

$$
\hat{y_i} = \hat{\alpha} + \hat{\beta} x_i
$$

## Assumptions of the Linear Regression Model

An important assumption in this model is that the errors are conditionally normally distributed $e_i|x_i$ with mean 0 and finite constant variance $\sigma^2$. Why conditional on $X=x$? Fixed $x_i$'s are assumed in order to generate predictions $\hat{y_i}$ used to calculate errors. Random error realisations therefore require fixed $x_i$.

$$
e_i|x_i \sim N(0, \sigma^2)
$$

This means that the average of errors shall be zero meaning the model shall not over-or-underpredict $y_i$. The constant variance tells us that spread of errors must remain the same across all values of the predictor $x_i$. If the spread of errors is different for different fixed $x_i$, it tells us that the model predictions are reliable for some values of $x_i$ than the others, which can invalidate conclusions from the model.

As $y_i$ is directly dependent on the errors ($\text{errors} = $y_i$ - $\hat{y_i}$, it means that we need to know for this linear regression model is that the response $y_i$ must strictly be a continuous variable in order to satisfy the continuous nature of the normally-distributed errors and make sense of the linear regression model (remember normal distribution is a continuous distribution). 

However, $x_i$ can be discrete or continuous because the model is conditional on $x_i$ being fixed. As long as one can show $y_i$ can vary through $x_i$, the model shall hold regardless whether $x_i$ is discrete or continuous.

With these assumptions in mind, we can also find the distribution of $y_i$ that we should know assumed to directly follow the normal distribution through it's errors:

$$
E[y_i|x_i] = E[\alpha + \beta x_i + e_i|x_i] = \alpha + \beta x_i + E[e_i|x_i] 
           = \alpha + \beta x_i + 0 = \alpha + \beta x_i 
$$

$$
Var[y_i|x_i] = Var[\alpha + \beta x_i + e_i|x_i] 
             = Var[e_i|x_i] = \sigma^2
$$

$$
y_i|x_i \sim N(\alpha + \beta x_i , \sigma^2)
$$


## Finding $\alpha$ and $\beta$ through calculations

Finding $\alpha$ and $\beta$ is done through the condition that these coefficients can arrive at a model can minimize the sum of squared residual errors. We have learned what the error is previously.

$$
\min_{\alpha, \beta} \sum_{i=1}^{n} e_i^2 = \min_{\alpha, \beta} \sum_{i=1}^{n} (y_i - \hat{y_i})^2
$$

In other words, the $\alpha$ and $\beta$ is calculated such that it produces the regression line (consisting of paired observations of predicted $\hat{y_i}$ values and $x_i$) that minimizes the distance between observations of $x_i$ to the regression line. Visualised, it looks as such:

<img src="https://actuary492.github.io/assets/images/ssr.jpeg" alt="description" style="width: 80%; height: 80%;">

Let me take you through how you can derive $\alpha$ and $\beta$.

$$
\min_{\alpha, \beta} \sum_{i=1}^{n} (y_i - \hat{y_i})^2 = \min_{\alpha, \beta} \sum_{i=1}^{n} (y_i - \alpha - \beta x_i)^2
$$

Deriving $\alpha$ by minimization:

$$
\frac{d}{d_\alpha} \sum_{i=1}^{n} (y_i - \alpha - \beta x_i)^2 = 0
$$

$$
\sum_{i=1}^{n} 2*(y_i - \alpha - \beta x_i)*(-1) = 0 \rightarrow \sum_{i=1}^{n} (y_i - \alpha - \beta x_i) = 0
$$

We split the summation into own terms:

$$
\sum_{i=1}^{n} y_i - \sum_{i=1}^{n} \alpha - \sum_{i=1}^{n} \beta x_i = 0 \rightarrow \sum_{i=1}^{n} y_i - n\alpha - \beta \sum_{i=1}^{n} x_i = 0
$$

Using the relationship $ \sum_{i=1}^{n} x_i = n \frac{1}{n} \sum_{i=1}^{n} x_i = n\bar{x_i}

$$

$$







## Quantifying accuracy of $\beta$


## Violation of Assumptions in Linear Regression


# Multiple Linear Regression


## Choosing the best model in Multiple Linear Regression by use of Statistical Tests

### Types of Selection Tests

### Commands in R to Select Models


# Dummy and Categorical Variables






