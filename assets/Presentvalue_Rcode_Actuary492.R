# install.packages("lifecontingencies") (Remove # to install dependencies)
library(lifecontingencies)

cashflow <- seq(1,10)
time <- seq(0,9)
i <- 0.05
presentValue(cashflow, time, i)


#Construct annuity
annuity_function <- function(i, n, p, type){
  cashflow <- rep(1/p, each=n*p)
  time_arrear <- seq(1, n*p, 1)
  time_advance <- seq(0, n*p-1, 1)
  i_p <- (1+i)^(1/p) - 1
  annuity_value <- ifelse(type == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p))
}

x <- annuity_function(0.04,10,12,0); x
100*annuity_function(0.04,10,12,0)
annuity(i = 0.04, n = 10, m= 0, k = 12, type="arrears")


# Deferred annuity function

deferred_annuity_function <- function(i, n, m, p, advance){
  cashflow <- rep(1/p, each = n*p)
  time_arrear <- seq(m*p + 1, (m+n)*p, 1)
  time_advance <- seq(m*p, (m+n)*p - 1, 1)
  i_p <- (1+i)^(1/p) - 1
  pres_val <- ifelse(advance == 1, presentValue(cashflow, time_advance, i_p), presentValue(cashflow, time_arrear, i_p))
}

x <- deferred_annuity_function(0.04,10,3,12,0); x
annuity(i = 0.04, n= 10, m= 3, k = 12,type="arrears")

#Loan calculation

loan_amount <- 1000000; interest <- 0.05; term <- 10; p <- 1

repayment <- loan_amount/annuity_function(0.05, 10, 1, 0); repayment

loan_value <- NULL

for(i in seq(term,1,-1)){
  loan_value[term+1-i] <- repayment*annuity_function(0.05, i, 1, 0)
}
loan_value

loan_value <- c(loan_value, 0); loan_value

table_loan <- data.frame("Time" = 0:term, "Loan_Value_at_t" = loan_value); table_loan

loan_outstanding <- NULL; interest_paid <- NULL; loan_paid <- NULL
for (i in 1:term){
  loan_outstanding[1] <- loan_amount
  interest_paid[i] <- interest*loan_outstanding[i]
  loan_paid[i] <- repayment - interest_paid[i]
  loan_outstanding[i+1] <- loan_outstanding[i]-loan_paid[i]
  loan_paid[term+1] <- 0
  interest_paid[term+1] <- 0
}

data.frame("Time" = 0:10, "Outstanding Loan"= round(loan_outstanding,2), "Loan Paid"= loan_paid, 
           "Interest Paid" = interest_paid, "Repayment" = c(rep(repayment, each=term), 0))

           