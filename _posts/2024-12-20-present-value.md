---
layout: single
title: "Present Value in Actuarial Science"
date: 2024-12-18
excerpt: "We will explore the present value and it's applications in Actuarial Science using R"
author: Nicholas Wijaya
toc: true
classes: wide
header: 
  image: "/assets/images/money.jpg"
permalink: /posts/present-value/
published: false
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

Present value tells us the current worth of a of future receivable or to be given out cashflow (or a series of one) by discounting it to the present using the appropriate discount (interest) rates. But why the concept of present value? Why discount the value of money? It all goes back to economics. The time concept of money tells us that yearly inflation erodes the value of money. This also directly erodes the value of every financial instrument that obviously depends on cashflows of money. Due to this, people want to essentially estimate the value of their future money now, by using some appropriate discount rate, (which now you can logically think of as some predicted inflation rate in the future) because they know their spending power (of money) in the future will not be as powerful as now.

This concept is easily simplified by this number line we see.

<img src="https://actuary492.github.io/assets/images/cf2.png" alt="description" style="width: 80%; height: auto;">

Assume that we have cashflows of 1 from $t=1$ to $t=5$. Assume that these cashflows are given at the end of the period. We are then asked to find the present value (at $t=0$) of this series of cashflows. Looking at the number line above, the goal is to discount all the cashflows (thus from $t=1$ to $t=5$) back into $t=0$. After that, we can sum up all the current values of the cashflows in the future to get the present value of the series of cashflows at $t=0$. Assume a constant discounting rate to use is 5%. The formula to do so is simplified below:

$$
PV_{t=0} = \frac{$1}{(1+0.05)^1} + \frac{$1}{(1+0.05)^2} + ... + \frac{$1}{(1+0.05)^5} = $4.329477
$$

We can summarize the general formula of the finding the present value, of a series of n cashflows discounted back to $t=0$, assuming constant discounting rate as follows:

$$
\sum_{n = 1}^{n} \frac{\text{Cashflow}_{t_n}}{(1 + i)^{t_n}} 
$$

The $t_n$ is the arbitrary time which we want to start the discounting from. The reason I do not start with arbitrary $t$ directly in the summation, but with $t_n$ instead, is due to the fact that the time variable in this formula may vary based on the way that cashflows may be received/given out. This will be further elaborated on the later sections. The $t_n$ belonging to the discounting factor can generally be seen as a sequence of differences between the time of the cashflow minus the time to which we want to discount back to.

If we are asked to find the PV at t=0 using the constant force of interest, it is quite straightforward as well:

$$
\sum_{n = 1}^{n} {\text{Cashflow}_{t_n}}e^{-\int_{t_1 = 0}^{t_2 = n} \delta \ ds}
$$

We should note variations to the formula. If the discounting rate is variable, the notation should be changed to $\delta_{t_n}$. 

<img src="https://actuary492.github.io/assets/images/cf3.png" alt="description" style="width: 80%; height: auto;">

Now, what if I want to calculate the present value of the same cashflow series (paid at the end of the period) above in the picture, assuming same constant discounting rate of 5%, but at $t=1$? What this means is that cashflows in between $t \in (0,1]$ will be ignored. Why? The cashflow of 1 has been received/given out at $t=1$, thus it is not further in our interest to find the present value of 1 of $t=1$ as it has been received. What we now focus on is the cashflows in $t \in (1,5]$. Remember the point of present value is to calculate the current value of all cashflows to be given to or received in the future. Calculating the present value thus becomes as illustrated by the number line:

$$
PV_{t=1} = \frac{$1}{(1+0.05)^1} + ... + \frac{$1}{(1+0.05)^4} = $3.545951
$$

This is a quick overview of the concept of the present value along with motivation of its use. In the next section, I will explain how this concept of present value is simplified in Actuarial Science.

# The annuity: an actuarial concept that uses the present value

In Actuarial Science, there is a concept of annuity that embeds the concept of present value. The annuity is a notation that tells us the sum of present values of a set of future cashflows of unit 1 for a given time period. There are various notations to this annuity that reflects the different ways the 1 unit cashflows are being received or given out which I briefly touched upon. This is again the reason why $t$ starts and ends at different time values for the different annuities below. Below I show examples of types of annuities.

## Immediate annuity or annuity in advance: 

$$
\ddot{a}_{\overline{n}|}^{@i} = \sum_{t = 1}^{n} \frac{\text{Cashflow}}{(1 + i)^t}
$$

<img src="https://actuary492.github.io/assets/images/cf4.png" alt="description" style="width: 80%; height: auto;">


This notation tells us that the cashflows in question are given out at the end of the period, starting from $t=1$ up until arbitrary time $t=n$. It gives the present value to $t=0$ of the series of 1 unit of cashflows, discounted by constant i, as shown in the picture above.

## Annuity due or annuity in arrears: 

$$
a_{\overline{n}|}^{@i} = \sum_{t = 0}^{n-1} \frac{\text{Cashflow}}{(1 + i)^t}
$$

<img src="https://actuary492.github.io/assets/images/cf5.png" alt="description" style="width: 80%; height: auto;">

This notation tells us that the cashflows in question are given out directly at the beginning of the period, starting from $t=0$ up until arbitrary time $t=n-1$. It calculates the sum of all the present value of same amount of cashflows above in the picture discounted by constant i. Note here we also calculate the present value of the cashflow at $t=0$, which shall logically remain as 1. 

## Deferred annuity in arrears and in advance

I am not able to reproduce the notation of the deferred annuity in arrears using MathJax. However, the difference is not much. We simply add $m \vert$, where $m$ is the deferment period, to the left subscript of the notation for annuity in arrears, to get deferred annuity in arrears equation. A deferment period of $m$ a m-period of delay before the payment of 1 unit starts at 
or after $t=m$, which in the case of cashflow in arrears, should start at $t=m+1$, after $t=m$.

$$
\text{Deferred Annuity in Arrears} = \sum_{t = m+1}^{n} \frac{\text{1}}{(1 + i)^t}
$$

<img src="https://actuary492.github.io/assets/images/cf6.png" alt="description" style="width: 80%; height: auto;">

We see that cashflows start at $t=m+1$ up until $t=n$ and these are discounted back to $t=0$, the present. 

For deferred annuity in advance, cashflows are given out or received at the beginning of the period. The only difference in cashflow to the image above, is that the first cashflow starts directly at the beginning of $t=m$ and ends at $t=n-1$, shown in the picture below.

<img src="https://actuary492.github.io/assets/images/cf7.png" alt="description" style="width: 80%; height: auto;">

$$
\text{Deferred Annuity in Advance} = \sum_{t = m}^{n-1} \frac{\text{1}}{(1 + i)^t}
$$

## Special Case: p-thly annuities 

What if we are faced with cashflows of $p$ frequencies per annum? What does the notation become? What happens to our calculations? Let us take an example of an monthly annuity in arrears.

$$
a_{\overline{n}|}^{(p)@i} = \sum_{t = 1}^{n*p} \frac{\frac{\text{1}}{p}}{(1 + \frac{i^{(p)}}{p})^t}
$$

The differences are clear and understandable. The nominal interest rate of one unit interval that has been adjusted for frequency $p$, $\frac{i^{(p)}}{p}$ should be used to reflect the nominal rate per discrete $p$-thly intervals. The cashflow itself has also been scaled down by $p$ in order to reflect the true cashflows of the of p-thly interval. The time intervals are also chopped into in $p$-thly intervals further. What we do in the end is the same, it is just a matter of summing up the present values of each $\frac{1}{p}$ cashflows of smaller intervals. 


## Other Types of Annuities

There are more types of annuities in practice. Think of continuous annuities, increasing or decreasing annuities. These will not be further discussed here, and can be easily read online. The concept of these to the ones above remain the same, these are notations to tell us the sum of present values of a specific set of cashflows.



# Present Value Function and Constructing Annuity Function in R

In this section I will show you how to build up a function in R that calculates value of an annuity, using the built in presentValue() function. To understand this section it is assumed the reader has familiarity with R to some degree.

## Built-in function of presentValue

In the "lifecontingencies" package, the presentValue() function is extremely handy to simplify present value calculations. However, we should note a downside to this built-in function. We can only use the effective rate here. Thus, if we are given force of interest, it should be changed into the effective rate before it can be plugged into presentValue(). Using "?presentValue" documentation, we are able to see the different input parameters. Simply plugging in the cashflow vector, time vector, and interest rate (vector, if applicable) into the function already allows us to find the present value easily as shown below. Below is an example.

```r
install.packages("lifecontingencies")
library(lifecontingencies)

#Construct increasing step increasing cashflow of 1:10
cashflow <- seq(1,10)
#Construct time sequence when the cashflow occurs, from t=0 to t=9
time <- seq(0,9)
#Input the effective rate for discounting; assumes constant rate of i for all time intervals
i <- 0.05
#Plug everything into presentValue()
presentValue(cashflow, time, i)

[1] 41.34247
```

## Annuity Code

Now, I will now construct a single function to calculate noth annuity in arrears and in advance, accounting for payment frequency. Look and try to understand the descriptions of each line of code. 

```r
# Note the inputs: the effective rate (i), the term of the annuity (n), the frequency of payments (p), and type that is a logical input (0: arrears or 1: advance) to tell the function if we are calculating annuity in advance or annuity in arrears.

annuity <- function(i, n, p, type){
  #Constructs cashflow of annuity, accounting for p-thly intervals.
  cashflow <- rep(1/p, each=n*p)
  #Constructs time intervals of the annuity in arrear, considering p.
  time_arrear <- seq(1, n*p, 1)
  #Constructs time intervals of the annuity in advance, considering p.
  time_arrear <- seq(0, n*p-1, 1)
  #Changes the effective rate into nominal rate suitable for p-thly intervals
  i_p <- (1+i)^(1/p) - 1
  #Calculates the value of the annuity given the inputs (either arrear or advance)
  annuity_value <- ifelse(type == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p)
}

annuity(0.04,10,12,0)
annuity(0.04,10,1)

[1] 8.258543
[1] 8.110896
```

I tried to find the present value of a 10-year annuity in arrears discounted at a effective rate of 4%, one with a yearly payment frequency while the other with a monthly payment frequency. The results shown are not far away from each other, with the slight difference due to different effective rate used due to frequency compounding. The steps are clear: construct the cashflow, time intervals, and effective rate, input all into the presentValue() function, before plugging all those into function I built.


Now, let us try to add a deferred input into the function now (for advance and arrears):

```r
# The inputs remain the same as the previous code, except for the addition of the variable m, that is the deferment period.

deferred_annuity <- function(i, n, m, p, advance){
  #Constructs cashflow of annuity, accounting for p-thly intervals.
  cashflow <- rep(1/p, each = n*p)
  #Constructs the annuity in arrear time vector to when the cashflow start paying out after deferment 
  time_arrear <- seq(m*p + 1, (m+n)*p, 1)
  #Constructs the annuity in advance time vector to when the cashflow start paying out after deferment 
  time_advance <- seq(m*p, (m+n)*p - 1, 1)
  #Changes the effective rate into nominal rate suitable for p-thly intervals
  i_p <- (1+i)^(1/p) - 1
  #Calculates the value of the annuity given the inputs (either arrear or advance)
  pres_val <- ifelse(type == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p)
}

deferred_annuity(0.04,10, 3, 12)
[1] 7.341814
```

We can see that it is not that complex either. We simply need to incorporate $m$ into the previous function, which changes the content time intervals, as shown in the deferred annuity graph. It could be possible that you will not directly arrive at the function above, hence it is always wise to construct the annuity function step by step. For instance, first without considering frequency payments, then with frequency payments, then with the deferrment period.

We have seen that building the annuity function is not hard to construct. Again, simply define your cashflows, the time sequence, and interest rates, plug them into presentValue() function, and voila!

Note that it would be wise to cross-check your function with the results of the built-in function of annuity() of the "lifecontingencies" package, to check for the validity of the function coded, which I have done. Additionally, it is also advised to experiment building different annuity functions out there, for instance of increasing or decreasing annuities. 


## Using annuity function above to value Financial Instruments

The annuity function above can be useful to value some financial instruments that may have a constant cashflow. An example is a loan schedule. Assume that we have received a loan of some amount, to be repaid in 10 years with interest. The payment structure can be arranged, such that every year we pay the same amount that covers both the interest and the capital. To find how much repayment will be done in 1 year, we can use actuarial equivalence. To find the value of the loan at every yearly interval during it's life, we can also use the annuity function after finding it's yearly repayments.

In another instance, the annuity function might not help us, because our annuity function above does not take into account non-constant cash flows unlike the loan schedule above. Take an example of $n$-year coupon bearing bond with a face value of $F$ and coupon payment $c$. For the $n-1$ years, we will be paid out the constant cashflow of coupon payments. However, in the last cashflow at maturity $n$, we will be paid out the coupon payment along with the face value $F+c$. This non-constant cashflow makes using the annuity function not possible. What we have to do instead is build a separate function for 

```r
# Define characteristics of bond: 20-year-bond of face value 100, with coupon rate of 6%.
face_value <- 100; coupon_rate <- 0.06; coupon <- face_value*coupon_rate; term <- 20

```











