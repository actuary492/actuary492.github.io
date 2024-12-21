---
layout: single
title: "Present Value"
date: 2024-12-18
excerpt: "We will explore the concept of present value and it's applications using R"
author: Nicholas Wijaya
toc: true
classes: wide
header: 
  image: "/assets/images/money.jpg"
permalink: /posts/present-value/
published: true
tags: [post, present, value]
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

> *The Present Value is extremely important concept in the world of finance. In practice, this concept, by the name itself, is used very often to arrive at the current value financial instruments. Knowing the current value of financial products in one's possesion is essential to quantify financial risks, and allows us to have a good overview of the health of one's investments. In this article, I will present the concepts of the present value, and apply some coding examples in R to illustrate the applications of this concept in the real world.*

# Introduction to Present Value

Present value tells us the current worth of a of future cashflow (or a series of one) by discounting it to the present using the appropriate discount (interest) rates. But why the concept of present value? Why discount the value of money? It all goes back to economics. The time concept of money tells us that yearly inflation erodes the value of money. This also directly erodes the value of every financial instrument that depends on cashflows of money. Due to this, people want to essentially estimate the value of their future money now, by using some appropriate discount rate, which now you can logically think, as some predicted inflation rate in the future, because they know their spending power (of money) in the future will not be as powerful as now.

This concept is easily simplified by this number line we see.

<img src="https://actuary492.github.io/assets/images/cf.png" alt="description">

Assume that we have cashflows of $1 from t=0 to t=5. We are then asked to find the present value (at $t=0$) of this series of cashflows. Looking at the number line above, the goal is to discount all the cashflows happening in the future (thus from $t=1$ to $t=5$) back into $t=0$. After that, we can sum up all the current values of the cashflows in the future, along with the cashflow at $t=0$ as well (whose present value of course remains at $1 as $t=0$ is the present, to which we discount all the future cashflows to) to get the present value of the series of cashflows. Assume a constant discounting rate to use is 5%. The formula to do so is simplified below:

$$
\sum_{t=0}^5 \frac{\text{Cashflow}}{(1+i)^t}
$$

Plugging in numbers, we arrive at:

$$
\frac{$1}{(1+0.05)^0} + \frac{$1}{(1+0.05)^1} + ... + \frac{$1}{(1+0.05)^5} = $5.329477
$$

We can summarize the general formula of the present Value, assuming constant interest rates, and if we want to find the present value discounted back to $t=0$, as follows:

$$
\sum_{t = 0}^{n} \frac{\text{Cashflow}}{(1 + i)^t}
$$


