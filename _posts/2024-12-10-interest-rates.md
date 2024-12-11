---
layout: single
title: "Interest Rates"
date: 2024-12-10
excerpt: "We will learn about application of interest rates in Actuarial Science."
author: Nicholas Wijaya
header: 
  image: "/assets/stethoscope-financial-graphs-scaled.jpg"
categories: [posts, actuarial-science]
tags: [post, blog, jekyll]
---

<p style="color:darkgray; font-style:italic;">
      Interest rates. Something that we have encountered multiple times during our finance classes and in our daily lives. Examples of interest rates are coupon rates in bonds, or forward rates in derivatives. Essentially, the interest rate tells us the percent growth of an amount of fund $X_t$ at some time t over a specified time period, typically in the next year. This concept is very useful especially for actuaries for calculating cashflows of their client's portfolios in order to get a good overview of their financial risk. In this article, I will bring to you the different interest rates around that can be useful to actuaries.

<h2 style="color:dark; font-style:italic;">Effective Interest Rates</h2>
<p style="color:black;">
	Effective interest rate (per unit time, i.e. 10% per annum) tells us that the end of a time period, the fund $X_t$ will grow by $10%$ to $X_{t+1}$. Essentially, we can consider this as a simple interest rate where we assume that the interest is paid at the end of the year (in arrears), which can be visualized by the formula below.
 
$$
X_1 = X_0(1+i)
$$

	However, this concept is quite flawed in it's essence. Sure, it is easy to assume that the interest will be paid out at the end of year in our example for instance. However, in this concept of effective interest rates, we are not able to calculate the growth of a fund $X_t$ at any time between that one time period (i.e. calculating the fund at $t=0.06$ between $0<t<1$) except for the amount at the end of the time period. Essentially, the fund amount in any $t$ between $0<t<1$ will therefore still remain at the original amount of $X_t$ because at $t=0.06$, we have not received the interest yet based on this concept. This assumption can or cannot be true - we do not know. Let's take an example where we open a savings account that gives us interest of 3.50% per annum. Sure, we can assume that at the end of the year the fund in our savings will rise by 3.5%. But, als logically speaking, we know that at every second, minute, hour within that one year, interest is building up, but we are not able to calculate them simply by using effective interest rates.
 
	This concept thus can be handy if actuaries are only interested in cashflows only at certain time periods. But in some cases, actuaries are expected to calculate with fund growth within much specific periods, such as within seconds, minutes, or hours. But, this concept of effective interest rates will not be able to fulfill such duty. Now comes the question, which type of interest rate can do this?

<h2 style="color:dark; font-style:italic;">Force of Interest</h2>
<p style="color:black;">

</p>


### Features

- Beautiful layout
- Support for images
- Markdown styling

And here's another image with a caption:

![A Calm Forest](/assets/forest.jpg)
*Photo credit: Unsplash*


In this post, we will discuss Einstein's famous equation $ E = mc^2$. The equation states that energy is equal to mass times the speed of light squared.

For a particle at rest, its energy is given by:

$$
E = mc^2
$$

Where:
- \( E_0 \) is the rest energy,
- \( m_0 \) is the rest mass,
- \( c \) is the speed of light.

Another interesting formula is the Lorentz factor \( \gamma \), which is defined as:

$$
\gamma = \frac{1}{\sqrt{1 - \frac{v^2}{c^2}}}
$$






