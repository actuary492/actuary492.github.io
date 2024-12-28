# R Code for Article: Present Value in GitHub Website Present Value

# install.packages("lifecontingencies") (remove # and this bracket to install dependencies if not yet done)
library(lifecontingencies)

# Construct a random increasing step cashflow
cashflow <- seq(1,10)
# Construct a random time sequence for the discounting factor
time <- seq(0,9)
# Input a random effective rate for discounting; assumes constant rate of i for all time intervals
i <- 0.05
# Plug everything into presentValue()
presentValue(cashflow, time, i)


## Annuity Code

# Note the inputs: the effective rate (i), the term of the annuity (n), the frequency of payments # (p), and type that is a logical input (0: arrears or 1: advance) to tell the function if we are # calculating annuity in advance or annuity in arrears.
annuity_function <- function(i, n, p, advance){
  #Construct cashflow of annuity, accounting for p-thly intervals.
  cashflow <- rep(1/p, each=n*p)
  #Construct time intervals for the discounting factor for annuity in arrear back to t=0, considering p.
  time_arrear <- seq(1, n*p, 1)
  #Construct time intervals for the discounting factor for annuity in advance back to t=0, considering p.
  time_advance <- seq(0, n*p-1, 1)
  #Change the effective rate into nominal rate suitable for p-thly intervals
  i_p <- (1+i)^(1/p) - 1
  #Calculate the value of the annuity given the inputs (either arrear or advance)
  annuity_value <- ifelse(advance == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p))
}

# Value of a 1 unit 10-year annuity in arrears, with monthly payment frequency
annuity_function(0.04,10,12,0)
# Value of a 100 unit 10-year annuity in arrears, with monthly payment frequency (simply mutiply function above by 100)
100*annuity_function(0.04,10,12,0)
# Check validity of the function by comparing it to built in function annuity()
annuity(i = 0.04, n = 10, m= 0, k = 12, type="arrears")

# Note the inputs: the effective rate (i), the term of the annuity (n), the frequency of payments # (p), and type that is a logical input (0: arrears or 1: advance) to tell the function if we are # calculating annuity in advance or annuity in arrears.


annuity_function <- function(i, n, p, advance){
  #Construct cashflow of annuity, accounting for p-thly intervals.
  cashflow <- rep(1/p, each=n*p)
  #Construct time intervals for the discounting factor for annuity in arrear back to t=0, considering p.
  time_arrear <- seq(1, n*p, 1)
  #Construct time intervals for the discounting factor for annuity in advance back to t=0, considering p.
  time_advance <- seq(0, n*p-1, 1)
  #Change the effective rate into nominal rate suitable for p-thly intervals
  i_p <- (1+i)^(1/p) - 1
  #Calculate the value of the annuity given the inputs (either arrear or advance)
  annuity_value <- ifelse(advance == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p))
}

# Value of a 1 unit 10-year annuity in arrears, with monthly payment frequency
annuity_function(0.04,10,12,0)
# Value of a 100 unit 10-year annuity in arrears, with monthly payment frequency (simply mutiply function above by 100)
100*annuity_function(0.04,10,12,0)
# Check validity of the function by comparing it to built in function annuity()
annuity(i = 0.04, n = 10, m= 0, k = 12, type="arrears")

# The inputs remain the same as the previous code, except for the addition
# of the variable m, that is the deferment period.

deferred_annuity <- function(i, n, m, p, advance){
  #Construct cashflow of annuity, accounting for p-thly intervals.
  cashflow <- rep(1/p, each = n*p)
  #Construct the annuity in arrear time vector for the discounting factor back to t=0 when the cashflow start paying out after deferment 
  time_arrear <- seq(m*p + 1, (m+n)*p, 1)
  #Construct the annuity in advance time vector for the discounting factor back to t=0 when the cashflow start paying out after deferment 
  time_advance <- seq(m*p, (m+n)*p - 1, 1)
  #Change the effective rate into nominal rate suitable for p-thly intervals
  i_p <- (1+i)^(1/p) - 1
  #Calculate the value of the annuity given the inputs (either arrear or advance)
  pres_val <- ifelse(advance == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p))
}

# Find the present value at t=0 of an 3-year deferred annuity of length 10 years, subject to monthly payments, and has interest rate of 4%
deferred_annuity_function(0.04,10, 3, 12, 0)
# Validate if function is correct using built-in annuity function
annuity(i = 0.04, n = 10, m= 3, k= 12, type="arrears")


## Loan Valuation Code

# Define loan characteristics
loan_amount <- 1000000; interest <- 0.05; term <- 10; p <- 1

# Use actuarial equivalence on the annuity function we created earlier:
repayment <- loan_amount/annuity_function(0.05, 10, 1, 0)

# Construct vector of loan values every year
loan_value <- NULL

# Construct for loop to find the annuity 
for(i in seq(term,1,-1)){
  loan_value[term+1-i] <- repayment*annuity_function(0.05, i, 1, 0)
}
loan_value

# The value of the loan at t=10 is naturally 0 because we assumed the loan has been fully paid off at t=10 with the loan schedule.
# The for loop does not catch this, so we have to manually add 0 to the end of the loan value vector
loan_value <- c(loan_value, 0); loan_value

# Construct table of loan
table_loan <- data.frame("Time" = 0:term, "Loan_Value_at_t" = loan_value); table_loan

# Check the elements of the loan schedule from t=0 to t=10
# We want to see whether this repayment schedule does indeed already cover all the outstanding loans and 
# the interests associated to it
# There is the element of loan_outstanding, loan_paid, and interest_paid
loan_outstanding <- NULL; interest_paid <- NULL; loan_paid <- NULL
for (i in 1:term){
  # The loan at t=0 is the original loan amount
  loan_outstanding[1] <- loan_amount
  # The interest paid is the interest rate multiplied by the current outstanding loan, which
  # decreases by year as we pay off the loan capital
  interest_paid[i] <- interest*loan_outstanding[i]
  # We assumed part of the repayment consists of the payment of interest and payment of loan,
  # thus, to find the loan amount paid, we subtract the repayment with the interest paid at t
  loan_paid[i] <- repayment - interest_paid[i]
  # The outstanding loan left at the next period is naturally the outstanding loan amount in the previous
  # period subtracted by the loan paid in the previous period
  loan_outstanding[i+1] <- loan_outstanding[i]-loan_paid[i]
  # The for loop only produces loan_paid and interest_paid up to i=9, because outstanding_loan at t=10 is already 0 as shown.
  # This already confirms that our repayment structure does indeed work in repaying the whole loan plus interest
  # To complete things, we have to manually add 0 as the last elements in both of the vectors mentioned.
  loan_paid[term+1] <- 0
  interest_paid[term+1] <- 0
}

# Table of the loan schedule from t=0 to t=10
# We add the repayment vector along the table, to allow us to see that this repayment does
# indeed equal to the loan paid plus interest paid for each time period from t=0 to t=10
data.frame("Time" = 0:10, "Outstanding Loan"= round(loan_outstanding,2), "Loan Paid"= loan_paid, 
           "Interest Paid" = interest_paid, "Repayment" = c(rep(repayment, each=term), 0))


## Bond Code

# Define characteristics of bond: 20-year-bond of face value 100, with coupon rate of 6%, and interest vector assumed above:
face_value <- 400; coupon_rate <- 0.1; coupon <- face_value*coupon_rate; term <- 20; interest <- seq(0.03, by=0.005)

# Calculating the bond value at t=0:

# Define cashflows of bond as described:
bond_cashflow <- c(rep(coupon, each=term-1), face_value + coupon)
# Define the time of cashflows of the bond, assumed payments are made in arrears
bond_time <- seq(1,term)

# Use presentValue to find bond value at t=0
presentValue(bond_cashflow, bond_time, interest[1:length(bond_cashflow)])

# Create a bond cashflow function which produces the cashflow to find the value of bond at arbitrary t
bond_cashflows <- function(time){
  cf <- c(rep(coupon, each=time-1), face_value + coupon)
}

# Create a time vector function for the discounting factor to find the value of the bond at arbitrary t
bond_time <- function(time){
  time <- seq(1,time)
}

# Create an empty vector to store the bond values
value <- NULL

# Used a for loop to calculate the values of the bond from t=0 to t=19
for(i in 1:term){
  value[i] <- presentValue(bond_cashflows(term+1-i), bond_time(term+1-i), interest[i:term])
}

# Note of the i and term+1-i; these are parts of the code are vital to ensure the correct values are returned
# It follows my explanation of how the cashflow and time vectors are structured for values at t=0 up to t=19.
# The bond value at t=20 will be manually added to create a new complete bond value vector from t=0 to t=20.

# Returns the values of the bond from t=0 to t=20
bond_value <- c(value, face_value + coupon)


# Construct data frame to show table of values of the bond at every t
df <- data.frame("t" = 0:20, "Bond_Value_at_t" = bond_value); df

# Plot the bond value from t=0 to t=20
plot(1:length(bond_value), bond_value, type="p", pch=8, xlab="Time", ylab="Value", main="Value Growth of Bond")

# Construct a vector that shows how many coupon payments have been received from t=0 up to t=20.
coupons_received <- NULL
# Construct for loop that gives the coupon payments received so far at t=1 up to t=19
for (i in 1:term-1){
  coupons_received[i] <- coupon*i
}
# The coupon payments at t=0 and t=20 are not well defined with the for loop above. We have to edit the bond value vector to fit the context above.
# At t=0, the coupon payments we have received is still zero, hence we add 0 into the vector for the coupon payment vector
# At t=20, we have calculated the bond value as the face value plus the coupon payment together. Instead of adding 800,
# that is 40 coupon payment * 20 terms to this last element, we add 760, showing instead we have received 19 coupon payments at t=20.
coupons_received <- c(0, coupons_received, coupons_received[term-1]); coupons_received

# Returns bond_value at time t=0 to t=20 inclusive of the coupons received so far at t
bond_value_with_coupons <- bond_value + coupons_received; bond_value_with_coupons

# Constructs table to show the bond values inclusive coupons received
df2 <- data.frame("t" = 0:20, "Bond_Value_with_Coupons_at_t" = bond_value)



