---
layout: single
title: "Interest Rates"
date: 2024-12-10
excerpt: "We will learn about application of interest rates in Actuarial Science."
author: Nicholas Wijaya
toc: true
classes: wide
header: 
  image: "/assets/images/stethoscope-financial-graphs-scaled.jpg"
permalink: /posts/interest-rates/
published: true
draft: false
tags: [post, blog, jekyll]
---

> *Interest rates. Something that we have encountered multiple times during our finance classes and in our daily lives. Examples of interest rates are coupon rates in bonds, or forward rates in derivatives. Essentially, the interest rate tells us the percent growth of an amount of fund $X_t$ at some time t over a specified time period, typically in the next year. This concept is very useful especially for actuaries in order to calculate cashflows of their client's portfolios in order to get a good overview of their financial risk. In this article, I will bring to you the different interest rates around actuarial literature that can be useful to actuaries.*


# Effective Interest Rates and It's Downsides

Effective interest rate (per unit time, i.e. 10% per annum) tells us that the end of a time period, the fund $X_t$ will grow by 10% to $X_{t+1}$. Essentially, we can consider this as a simple interest rate where we assume that the interest is paid at the end of the year. This can be visualized by the formula below.

$$
X_1 = X_0(1+i)
$$

However, this concept is quite flawed in it's essence. Sure, it is easy and more understandable for the normal person to assume that the interest will be paid out at the end of year in our example for instance. However, in this concept of effective interest rates, we are not able to calculate the growth of a fund $X_t$ at any time between that one time period (i.e. calculating the fund at $t=0.06$ between $0<t<1$) except for the amount at the end of the time period. Thus, this interest rate concept is regarded as <em style="font-style:bold;">discrete</em> in nature.  Essentially, the fund amount in any $t$ between $0<t<1$ will therefore still remain at the original amount of $X_t$ because at $t=0.06$, we have not received the interest yet at $t=0.06$ based on this concept. This assumption can or cannot be true - we do not know. Let's take an example where this isn't true. We open a savings account that gives us interest of 3.5% per annum. Sure, we can assume that at the end of the year the fund in our savings will rise by 3.5%. But, also logically speaking, we know that at every second, minute, hour within that one year, interest is building up. Yet, we are not able to calculate them simply by using effective interest rates.


This concept thus can be handy if actuaries are only interested in cashflows only at certain time periods. But in some cases, actuaries can be expected to calculate fund growth in much more specific periods, such as within seconds, minutes, or hours. But, this concept of effective interest rates will not be able to fulfill such task. Now comes the question, which type of interest rate can do this?

# Force of Interest

It is no other than the force of interest. The force of interest, that is usually denoted as $ \delta_{t}$ can be considered as the interest earned in an "infinitesimally" small time interval. This force of interest can be variable (in terms of $t$) or be constant (i.e. 0.05). A variable force of interest, that can allow us to calculate force of interest at some future time point is also called as the <em style="font-style:italic;">forward interest rate</em>. 
  
Let us start with a step-by-step proof of this force of interest to show how can we use it to calculate the growth of some fund $X_t$.

First, we need some prerequisites. The interest $\delta_{t}$ earned in a small time interval $dt$ from a fund of $X_t$, is equivalent to the increase in fund $X_t$ denoted as $dX_t$, which can be visualised as follows:

$$
X_t * \delta_{t}\ * dt = dX_t 
$$

Rearranging the equation, with $\delta_{t}$ as the subject, we get as follows:

$$
\delta_{t} \ = \frac{1}{X_t} * \frac{dX_t}{dt}
$$

At this point, we should be aware that the fund $X_t$ can be a function that calculates the amount of fund at some time $t$, which can be also denoted as $X(t)$. Now, let us then move to the main part. Let us first observe this number line.

<img src="https://actuary492.github.io/assets/images/cashflow.png" alt="description">

This number line tells us the growth of fund $X_t$ [ $X(t)$ ] over a time interval $h$ to $X_{t+h}$ [ ($X(t+h)$ ]. The interest earned in this time interval, following simple interest rate definition, can be visualised as:

$$
i[t, t+h] = \frac{X(t+h) - X(t)}{X(t)}
$$
 
Now, let us assume that we can chop up more intervals in between $t$ and $t+h$ until $h$ becomes infinitesimally small. Equating the interest rate between $X_t$ and $X_{t+h}$ for infinitesimally small time intervals, otherwise known as the force of interest $\delta_{t}$ :

$$
\delta_t = \lim_{h \to 0} \frac{i[t, t+h]}{h}  = \lim_{h \to 0} \frac{\frac{X(t+h) - X(t)}{X(t)}}{h} = \lim_{h \to 0} \frac{X(t+h) - X(t)}{h} * \frac{1}{X(t)}
$$

Remembering the limit definition of a derivative below:

$$
\lim_{h \to 0} \frac{f(x+h)-f(x)}{h} = f'(x)
$$

We can then simplify the proof as follows by using definition of derivative:

$$
\lim_{h \to 0} \frac{X(t+h) - X(t)}{h} * \frac{1}{X(t)} = \frac{1}{X(t)} * \lim_{h \to 0} \frac{X(t+h) - X(t)}{h} = \frac{X'(t)}{X(t)} =  \delta_{t}
$$

In order to see how the fund evolves with the force of interest, we have to express $X(t+n)$, that is the fund at new time $t+n$, in terms of $X(t)$, the original fund amount at time $t$ and in terms of $\delta_{t}$. 

$$
\delta_{t} = \frac{X'(t)}{X(t)}
$$

Integrating both sides in some time interval $t$ to $t+n$:

$$
\int_t^{t+n} \delta_{t} \ ds = \int_t^{t+n} \frac{X'(s)}{X(s)} \, ds
$$

$$
\int_t^{t+n} \delta_{t} \ ds = \left[ ln(X(s)) \right]_t^{t+n}
$$

$$
\int_t^{t+n} \delta_{t} \ ds = ln(X_{t+n}) - ln(X_t) = ln(\frac{X_{t+n}}{X_t})
$$

Now, we can simply rearrange the equation above to express $X_{t+n}$ in terms of $X_t$ and $\delta_{t}$.

$$
\int_t^{t+n} \delta_{t} \ ds = ln(\frac{X_{t+n}}{X_t})
$$

$$
e^{\int_t^{t+n} \delta_{t} \ ds} = \frac{X_{t+n}}{X_t}
$$

$$
X_{t+n} = X_{t} * e^{\int_t^{t+n} \delta_{t} \ ds}
$$

Looking at the equation above, we can clearly see that the interest rate is not exactly the force of interest, but rather the equation that is:

$$
e^{\int_t^{t+n} \delta_{t} \ ds}
$$

To find the discounting rate using the force of interest, simply add a negative behind the integral of the function above:

$$
e^{-\int_t^{t+n} \delta_{t} \ ds}
$$

This interest accumulation equation itself, based on the force of interest, is very important in the world of financial mathematics. With this equation, even if we are given a force of interest that is per annum, we are still able to calculate the interest that shall be accrued between time intervals of minutes, days, or hours and this solves the limitation of the effective interest rates. This is further embedded into logic by the integral definition in the equation, which tells us that we are calculating the average of interest rates between some arbitrary time period. This explains the <em style="font-style:italic;">continuous</em> nature of this force of interest.

Let us take an example where we need to calculate the interest of borrowing $100 000$  in 10 days time for one day, given an constant annual force of interest of \( \delta \) $= 0.05$ . By the accumulation formula based on the force of interest, it should be fairly simple. We first have to adjust the annual $t$ into daily time interval by dividing by 365. What this means is that we are interested in the fund growth between time $t=10/365$ and $t=11/365$. Plugging this into the accumulation function of the force of interest:

$$
X_{t+n} = X_{t} * e^{\int_t^{t+n} \delta_{t} \ ds}
$$

$$
X(11/365) = X(10/365) e^{\int_{10/365}^{11/365} 0.05 \ ds} = 100000 e^{\int_{10/365}^{11/365} 0.05 \ ds} \approx 100013.7
$$

We therefore see that the interest of borrowing $100 000$ for 1 day in the 10th day is about $13.70$ based on this concept. Looking back, this is something we could not have calculated with only the effective interest rates.

# The Relationship between Force of Interest and Effective Interest Rates

Taking a glance back, it was argued earlier how effective interest rates are not able to calculate interest built up in between a time period, while the force of interest is able to do so. The latter is definitely desired, however in the real world, actuaries are only often served effective interest rates, which can likely be used to calculate growth of funds over smaller time intervals. Finding the relationship between effective rates and the force of interest allows us to calculate growth of fund in between time periods by only requiring the effective interest rate, serving as a bridge between theory and practice. In order to do this, we have to assume equality between the two different interest accumulation functions: consider the interest accumulated at a time interval $0<t<1$, using the constant force of interest (to simplify calculations) is equivalent to the interest accrued using the effective interest rate. This can be visualised by the following equation:

$$
e^{\int_{0}^{1} \delta \ ds} = e^{\delta} = (1+i)
$$

This gives us an extremely important relationship. Starting with a fund of $1$, applying \( \delta \) to infinitesimally small time intervals, then calculating the interest accrued over these time intervals, gives us $(1+i)$  in the end.

# Nominal Interest Rates

Previously, we interpreted effective interest rates as the interest received at the end of one period. The nominal interest rates ($i^{(p)}$) essentially has the same idea as effective interest rates, except that this concept can be interpreted as receiving interest more than once per unit period. Nominal rates are still discrete in nature, however they allow us to calculate interest rates of smaller discrete time intervals. The relationship between effective and nominal rates is as follows:

$$
i^{(p)} = p((1+i)^{\frac{1}{p}} - 1)
$$

  The nominal rate essentially tells us that some effective interest rate per unit period can be convertible into a much smaller unit period. For instance, a 1 year unit period, convertible into the quarterly unit period. Normally, if we are given or have derived $i^{(p)}$, we have to note that is still the annual nominal rate, and the $p$ in the notation tells us the number we have to divide with in order to convert the nominal interest rate into the appropriate unit period for our calculations. This concept may be quite difficult at first glance, hence it is advised to re-read several times to get the jist of it.

  For example, $i^{(12)} = 0.1$ tells us that the nominal rate that is 0.1 per annum payable can be converted monthly, by dividing $i^{(12)}$ by 12, that becomes $\frac{0.1}{12} \approx 0.0083 $, the nominal rate for the monthly time interval. However, to be clear once again, due to it's discrete nature, we are still not able to calculate the growth of fund at some arbitrary time point in between the monthly time periods.

# When are Effective Interest Rates and Force of Interest Used?

  Effective rates are used often in the world of finance due to the regular and discrete characteristic of cashflows which we encounter, such as insurance premiums and monthly pension payments. As these cashflows are received or paid out at fixed time intervals, using an effective rate consistent whose period is consistent with the frequency of payments suffices to reflect financial risk in practice. Thus, force of interest is not really needed. However, in situations where patterns of interest rates or payments are irregular and continuous in nature, the force of interest will be needed for calculations.  

  Using mortality rates as an example which you might have encountered some time in your academics, if we are only required to measure death rates between discrete time intervals, then mortality rate suffices. However, if we are asked to measure death rates over non-integer time ranges, such as the probability of survival an 80.2 year old in the next 2.5 years, the force of mortality will be better suited for this purpose.

# Conclusion

  In this article, we have learned about the different types of interest rates used by actuaries, it's characteristics, and in which situations are these types of interest rates used. I hope you have learned something from this article. See you on the next one!

# References

McQuire, A., & Kume, M. (2020). <em style="font-style:bold;">R Programming for Actuarial Science</em>. Wiley.

