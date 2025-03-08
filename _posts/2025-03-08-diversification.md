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

Take for example, diversification in hedge funds and pension funds. They typically have assets in different asset classes such as stocks, bonds, and real estate whose returns have been proven by research to have very little correlation with one another. This reduces the risk of asset value loss. How? If the stock market was bearish, there may be an inflow of funds into bonds that may increase price of bonds, offsetting the temporary loss of stock value during it's bearish phase.

For insurance companies, they diversify their policyholder portfolio by making it as large as possible. A large portfolio of carefully chosen policyholders (they go through an underwriting process pick the least risky policyholders) ensure that financial losses of the portfolio (by means of total claims) become as predictable as possible, in the process reducing the risk of extreme claims. 

Of course, the diversification process which I described in these two scenarios also have to be backed up by data and expertise, which institutions such as hedge or pension funds, and insurance companies possess. Having these prerequisites allows them to create extremely reliable predictions which they can use to support their diversification policy and actions.

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

We can easily find the mean of the portfolio return as follows: 

$$
E[R_p] = E[w_1 R_1 + w_2 R_2 + \dots + w_n R_n] = E[\sum_{i=1}^{n} w_i R_i] = \sum_{i=1}^{n} E[w_i R_i] = w_1 E[R_1] + w_2 E[R_2] + \dots + w_n E[R_n]
$$

The variance of the portfolio return on the other hand looks more complex:

$$
\text{Var}(R_p) = \text{Var}(w_1 R_1 + w_2 R_2 + \dots + w_n R_n \)
= \sum_{i=1}^{n} \sum_{j=1}^{n} w_i w_j \text{Cov}(R_i, R_j)
= \sum_{i=1}^{n} w_i^2 \text{Var}(R_i) + \sum_{i=1}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} w_i w_j \text{Cov}(R_i, R_j)
$$

where we see two important terms, that is $\text{Cov}(R_i, R_j)$ that is the covariance between asset $i$ and asset $j$ and $\text{Var}(R_i)$ is the variance of asset $i$ itself.

Although the equation looks complex, the underlying idea behind the result of the variance is very simple. 

First, why can we say that the variance is the risk of return? Remembering the equation of variance:

$$
\text{Var}(R) = \sum_{i=1}^{n} (R_i - E[R])^2
$$

The variance itself is the dispersion of returns around their expected value. This dispersion can be seen as uncertainty. Of course, this uncertainty in our case of portfolio, is not only the risk in each individual assets that is the variance, but also the risk between STRICTLY DIFFERENT asset pairs in the portfolio that is called the covariance.

Having the variance and covariance terms of the every individual weighted assets in the portfolio, let us express them by a variance-covariance matrix. This matrix makes the representation of risk much easier to grasp because it essentially presents all the possible 'dispersions' between ALL possible STRICTLY DIFFERENT return pairs (we call this covariance), including itself (we call this variance).

$$
\text{C} = \text{Var-Cov Matrix} =
\begin{bmatrix}
\text{Var}(R_1) & \text{Cov}(R_1, R_2) & \dots & \text{Cov}(R_1, R_n) \\
\text{Cov}(R_2, R_1) & \text{Var}(R_2) & \dots & \text{Cov}(R_2, R_n) \\
\vdots & \vdots & \ddots & \vdots \\
\text{Cov}(R_n, R_1) & \text{Cov}(R_n, R_2) & \dots & \text{Var}(R_n)
\end{bmatrix}
$$

The first row starts with all the possible variance and covariance terms beginning with $R_1$, that is the covariance of $R_1$ with itself, which is equivalent to it's variance, then continuing with covariance of $R_1$ with $R_2$ up to $R_n$. The second then starts in a similar fashion with variance and covariance terms beginning with $R_2$, here we first start with the covariance of $R_2$ with $R_1$, afterwards the covariance of $R_2$ with itself $R_2$ that is the variance of $R_2$, then covariance of $R_2$ with $R_3$ up to $R_n$. And so on for the third row up to the n-th row.

>*Doing this repeatedly forms the complete n$x$n variance-covariance matrix which we see all variance terms are located in the diagonals, and covariance terms in the off-diagonals.* 

Now, let us add the weight vectors to make it align with the portfolio variance equation, because we are dealing with $w_1 R_1$ up to $w_n R_n$ weighted assets returns in the portfolio return instead of simply unweighted asset returns of $R_1$ up to $R_n$. 

One might wonder why is there a transpose? The idea is that the weightings of assets $w$ which are constants, are squared when taken out of the variance terms (i.e. $\text{Var}(w_1 R_1) = {w_1}^2 Var(R_1)$). This similarly applies to the covariance terms (i.e. $\text{Cov}(w_1 R_1, w_2 R_2) = w_1 w_2 Cov(R_1, R_2)$). The use of weight vectors reflect this perfectly.

$$
\text{Var}(R_p) = \text{Var}(w_1 R_1 + w_2 R_2 + \dots + w_n R_n) = w^{T}Cw
$$

Perhaps a more easier way to follow is indeed by directly applying the weighted random returns of individual assets directly into the variance-covariance matrix as follows, which will produce the same result as the equation above:

$$
\text{C}_w = 
\begin{bmatrix}
\text{Var}(w_1 R_1) & \text{Cov}(w_1 R_1, w_2 R_2) & \dots & \text{Cov}(w_1 R_1, w_n R_n) \\
\text{Cov}(w_2 R_2, w_1 R_1) & \text{Var}(w_2 R_2) & \dots & \text{Cov}(w_2 R_2, w_n R_n) \\
\vdots & \vdots & \ddots & \vdots \\
\text{Cov}(w_n R_n, w_1 R_1) & \text{Cov}(w_n R_n, w_2 R_2) & \dots & \text{Var}(w_n R_n)
\end{bmatrix}
$$

which is equivalent to 

$$
= \begin{bmatrix}
w_1 w_1 \text{Var}(R_1) & w_1 w_2 \text{Cov}(R_1, R_2) & \dots & w_1 w_n \text{Cov}(R_1, R_n) \\
w_2 w_1 \text{Cov}(R_2, R_1) & w_2 w_2 \text{Var}(R_2) & \dots & w_2 w_n \text{Cov}(R_2, R_n) \\
\vdots & \vdots & \ddots & \vdots \\
w_n w_1 \text{Cov}(R_n, R_1) & w_n w_2 \text{Cov}(R_n, R_2) & \dots & w_n w_n \text{Var}(R_n)
\end{bmatrix}
$$

>*If we look closely at the portfolio return variance expression earlier, we can see that it is simply the sum of all the variance and covariance terms of the variance-covariance matrix that has been weight-adjusted by inclusion of weight vectors $w^{T}Cw$. We have a separate summation term for all variance terms $\sum_{i=1}^{n} w_i^2 \text{Var}(R_i)$, then another separate summation for the covariance terms $\sum_{i}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} w_i w_j \text{Cov}(R_i, R_j)$, whose extra summation of $\sum_{\substack{j=1 \\ j \neq i}}^{n}$ ensures that there is no covariance term of the same asset return (i.e. $cov(R_i, R_i)$) because those are essentially the variance terms that have already been reflected in the first summation.*

# Special case of Variance of Portfolio Return : Equal Asset Weighting $\frac{1}{n}$

A good way to put our understanding of the concept of risk of portfolio return into the test is by checking the case when we deal with equal asset weightings $w_1 = \dots = w_n = \frac{1}{n}$. The idea on using equal asset weighting ensures that calculations are made as simple as possible, which we will show later.

But first let us find the mean and variance (risk) of portfolio returns where assets are equally weighted: 

$$
\text{E}(\frac{R_1}{n} + \frac{R_2}{n} + \dots + \frac{R_n}{n})  = \frac{1}{n}(\text{E}(R_1) + \dots + \text{E}(R_n))
$$

We can see finding the mean of returns is quite straightforward.

$$
\text{Var}(\frac{R_1}{n} + \frac{R_2}{n} + \dots + \frac{R_n}{n}) 
= \frac{\overline{\text{Var}(R_i)}}{n} + \frac{(n - 1) \overline{\text{Cov}(R_i, R_j)}}{n}
$$

The result variance of equal-weighted assets portfolio return on the other hand is not that obvious at first glance. Let us break the steps down on how we can arrive there. 

However, the idea behind calculating the variance is still the same as explained previously, it is equivalent to the sum of all terms of the equal-weighted portfolio return variance-covariance matrix. First, let us create the variance-covariance matrix when assets are equally weighted:

$$
\text{C}_w = 
\begin{bmatrix}
\text{Var}\left(\frac{R_1}{n}\right) & \text{Cov}\left(\frac{R_1}{n}, \frac{R_2}{n}\right) & \dots & \text{Cov}\left(\frac{R_1}{n}, \frac{R_n}{n}\right) \\
\text{Cov}\left(\frac{R_2}{n}, \frac{R_1}{n}\right) & \text{Var}\left(\frac{R_2}{n}\right) & \dots & \text{Cov}\left(\frac{R_2}{n}, \frac{R_n}{n}\right) \\
\vdots & \vdots & \ddots & \vdots \\
\text{Cov}\left(\frac{R_n}{n}, \frac{R_1}{n}\right) & \text{Cov}\left(\frac{R_n}{n}, \frac{R_2}{n}\right) & \dots & \text{Var}\left(\frac{R_n}{n}\right)
\end{bmatrix}
$$

which is equivalent to

$$
= \begin{bmatrix}
\frac{1}{n^2} \text{Var}(R_1) & \frac{1}{n^2} \text{Cov}(R_1, R_2) & \dots & \frac{1}{n^2} \text{Cov}(R_1, R_n) \\
\frac{1}{n^2} \text{Cov}(R_2, R_1) & \frac{1}{n^2} \text{Var}(R_2) & \dots & \frac{1}{n^2} \text{Cov}(R_2, R_n) \\
\vdots & \vdots & \ddots & \vdots \\
\frac{1}{n^2} \text{Cov}(R_n, R_1) & \frac{1}{n^2} \text{Cov}(R_n, R_2) & \dots & \frac{1}{n^2} \text{Var}(R_n)
\end{bmatrix}
$$

Now, let us group the summation into the variance and covariance terms. 

Let us first start with the variance.

Looking at the matrix above, we see tha variance terms are only located in the diagonals. Because we have 'n' rows, this means that we have 'n' diagonal terms. Summing these diagonal terms is therefore as follows:

$$
\frac{1}{n^2} \text{Var}(R_1) + \frac{1}{n^2} \text{Var}(R_2) + \dots + \frac{1}{n^2} \text{Var}(R_n) = \frac{1}{n^2} \sum_{i=1}^{n} \text{Var}(R_i)
$$

How do we get the average of variance from this? As we can see:

$$
\frac{1}{n^2} \sum_{i=1}^{n} \text{Var}(R_i) = \frac{1}{n} \frac{1}{n} \sum_{i=1}^{n} \text{Var}(R_i) = \frac{1}{n} * (\frac{1}{n} \sum_{i=1}^{n} \text{Var}(R_i)) = \frac{1}{n} \overline{\text{Var}(R_i)} = \frac{\overline{\text{Var}(R_i)}}{n} 
$$

Now, let us move on to the summation of the covariance terms. 

We should remember, that there are now $n^2 - n = n(n-1)$ covariance terms. There are a total of $n^2$ terms based on the n by n variance-covariance matrix. We then substract by 'n' terms because we do not want to count the variance terms in the diagonals that are already in the first summation earlier. Let us now create a summation for these terms:

$$
\sum_{i}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \frac{1}{n^2} \text{Cov}(\frac{R_i}{n^2}, \frac{R_j}{n^2}) =  \sum_{i}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \frac{1}{n^2} \text{Cov}(R_i, R_j) = \frac{1}{n^2} \sum_{i}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \text{Cov}(R_i, R_j)
$$

Now, let us see how can we manipulate the equation derived above to get the average of covariances:

$$
\frac{1}{n^2} \sum_{i}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \text{Cov}(R_i, R_j) = \frac{1}{n} \frac{1}{n} \sum_{i}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \text{Cov}(R_i, R_j)
$$

We see that to create the average, we need to add the term $\frac{1}{n(n-1)}$ to the covariance summation because we have concluded earlier that there are $n(n-1)$ covariance terms! We also have to compensate for this term by adding $\frac{n(n-1)}{1}$. Doing these steps as shown below will lead us to the final answer:

$$
\frac{1}{n} \frac{1}{n} \sum_{i=1}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \text{Cov}(R_i, R_j) 
= \frac{1}{n} \frac{1}{n} \frac{n(n-1)}{1} \frac{1}{n(n-1)} \sum_{i=1}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \text{Cov}(R_i, R_j) 
= \frac{1}{n} \frac{1}{n} \left( \frac{n(n-1)}{1} \frac{1}{n(n-1)} \sum_{i=1}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} \text{Cov}(R_i, R_j) \right)
= \frac{1}{n} \frac{1}{n} \frac{n(n-1)}{1} \overline{\text{Cov}(R_i, R_j)} 
= \frac{n-1}{n} \overline{\text{Cov}(R_i, R_j)}
$$







