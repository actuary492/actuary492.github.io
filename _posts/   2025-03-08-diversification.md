---
layout: single
title: "Diversification"
date: 2025-03-08
excerpt: "Exploring the concept of diversification by simple examples using R"
author: Nicholas Wijaya
toc: true
classes: wide
header: 
  image: "/assets/images/diversification.png"
permalink: /posts/diversification/
published: false
draft: false
tags: [post, diversification, R]
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

>*Diversification is very common in finance. The main purpose of diversification is to ensure that risks are significantly reduced. Financial institutions, such as banks, hedge funds and pension funds have their own diversification policies to prevent large value losses in their assets. In this article, we will explore what is diversification in mathematical terms and give an example of an application in R.*

# What is diversification?

Diversification may come in different forms but it's main purpose remains the same, that is to reduce risks. What risks though? 

Take for example, diversification in hedge funds and pension funds. They typically have assets in different asset classes such as stocks, bonds, and real estate whose returns have been proven by research to have very little correlation with one another. This reduces the risk of asset value loss. How? If the stock market was bearish, there may be an inflow of funds into bonds that may increase price of bonds, offsetting the temporary loss of stocks during it's bearish phase.

For insurance companies, they diversify their policyholder portfolio by making it as large as possible. A large portfolio of carefully chosen policyholders (they go through an underwriting process pick the least risky policyholders) ensure that financial losses of the portfolio (by means of total claims) become as predictable as possible, in the process reducing the risk of extreme claims. Of course, the diversification process which I described in these two scenarios also have to be backed up by data and expertise, which institutions such as hedge or pension funds, and insurance companies possess. Having these prerequisites allows them to create extremely reliable predictions which they can use to support their diversification policy and actions.
Diversification can also apply to the average person. In investing, we are always advised to never put our eggs in one basket, that is why people diversify their investment in different asset classes!

# The mathematical intutition behind diversification

Let us express the concept of diversification mathematically. 

Let us first express the return of a portfolio of n assets:

$$
R_p = w_1 R_1 + w_2 R_2 + \dots + w_n R_n = \sum_{i=1}^{n} w_i R_i
$$

where $w_i$ is the weight of each asset in the portfolio and these individual weights have to sum up to 1 ($\sum_{i=1}^{n} w_i = 1$). $R_i$ is seen as the return on each individual asset $i$ while $R_p$ is seen as the return of portfolio that can be seen as the sum of return of weighted assets.

Two metrics which we can attain from this portfolio return is the mean of returns and also the variance of returns. 
The mean can be simply seen as the average returns of the portfolios based on the weighting of each asset.
The variance on the other hand should be interpreted as the risk of return of the given portfolio. 

These two measures come hand-in-hand. Ideally, one wants to ensure a high mean return with the least variance (or risk) as possible but in real life this is hard to achieve. More on this will be highlighted in the next article about Modern Portfolio Theory. 

We can easily find the mean as follows: 

$$
E[R_p] = E[w_1 R_1 + w_2 R_2 + \dots + w_n R_n] = E[\sum_{i=1}^{n} w_i R_i] = \sum_{i=1}^{n} E[w_i R_i] = w_1 E[R_1] + w_2 E[R_2] + \dots + w_n E[R_n]
$$

The variance on the other hand looks more complex:

$$
\text{Variance}(R_p) = \text{Var}(w_1 R_1 + w_2 R_2 + \dots + w_n R_n \)
= \sum_{i=1}^{n} \sum_{j=1}^{n} w_i w_j \text{Cov}(R_i, R_j)
= \sum_{i=1}^{n} w_i^2 \text{Var}(R_i) + \sum_{i=1}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} w_i w_j \text{Cov}(R_i, R_j)
$$


