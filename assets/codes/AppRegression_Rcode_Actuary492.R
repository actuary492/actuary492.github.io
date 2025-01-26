# Applications of Regression in R

library(MASS)
library(stats)
library(leaps)
library(psych)
library(regclass)

# In this we will use a data set "nyc" (change directory)

nyc <- read.csv("~/nyc.csv"); nyc

# The linear regression command lm()

reg0 <- lm(nyc$Price ~ 1)
reg1 <- lm(nyc$Price ~ nyc$Food) 
reg2 <- lm(nyc$Price ~ nyc$Food + nyc$Decor)
reg3 <- lm(nyc$Price ~ nyc$Food + nyc$Decor + nyc$Service)
reg4 <- lm(nyc$Price ~ nyc$Food + nyc$Decor + nyc$Service + nyc$East)

# plot()

# Place # otherwise automatic run of whole code will cause an error, remove # to execute code plot() code 
# plot(reg2)

# Applying concepts to find best model fit in R using Sheather (2009) dataset

# aov()

summary(aov(reg1))
summary(aov(reg2))
summary(aov(reg3))
summary(aov(reg4))

# anova()
anova(reg1, reg4)
anova(reg0, reg1)
anova(reg1, reg2)
anova(reg2, reg3)

# drop1()

drop1(reg4, test="F")


# add1()
add1(reg0, test="F", scope=.~.+ nyc$Food + nyc$Decor + nyc$Service + nyc$East)

reg0_update <- update(reg0, .~. + nyc$Service)

add1(reg0_update, test="F", scope=.~. + nyc$Food + nyc$Decor + nyc$Service + nyc$East)

reg0_update_1 <-  update(reg0_update, .~. + nyc$Decor)

add1(reg0_update_1, test= "F", scope=.~. + nyc$Food + nyc$Decor + nyc$Service + nyc$East)

reg0_update_2 <- update(reg0_update_1, .~.+ nyc$Food)

add1(reg0_update_2, test="F", scope=.~. + nyc$Food + nyc$Decor + nyc$Service + nyc$East)

reg0_update_3 <- update(reg0_update_2, .~.+ nyc$East)

# AIC Forward Selection/Backward Elimination

stepAIC(reg4, scope=.~. + nyc$Food + nyc$Decor + nyc$Service + nyc$East, direction="backward")
stepAIC(reg0, scope=.~. + nyc$Food + nyc$Decor + nyc$Service + nyc$East, direction="forward")

# R-squared criteria

M <- leaps(x = nyc[,4:7], y= nyc[,3], int=TRUE, method="r2")

# This gives a list of every possible linear combination and it's respective R-squared.
# TRUE/FALSE changed to 1/0 by cbind() function

cbind(M$which[order(M$r2), ], sort(M$r2))

# Interpreting best fit model

summary(lm(nyc$Price~nyc$Food+nyc$Decor+nyc$East))

# Check whether regression assumptions hold

plot(lm(nyc$Price~nyc$Food+nyc$Decor+nyc$East))

nyc[130,]; nyc[30,]; nyc[56,]


# Why is "Service" not significant

# Check pairs.panels to check 
pairs.panels(nyc[,3:7])

# Service is significant when regressed alone
summary(lm(nyc$Price~nyc$Service))

# When second variable added, Service still significant
summary(lm(nyc$Price~nyc$Service+nyc$Decor))
summary(lm(nyc$Price~nyc$Service+nyc$Food))
summary(lm(nyc$Price~nyc$Service+nyc$East))

# Try on addition of third and fourth terms; we see that inclusion of the pairs "Food" and "Decor" 
# when there is "Service" in the model causes "Service" to be insignificant. If the aforementioned
# pair is not in the model, then "Service" remains significant.
summary(lm(nyc$Price~nyc$Service+nyc$Decor+nyc$Food))
summary(lm(nyc$Price~nyc$Service+nyc$Decor+nyc$East))
summary(lm(nyc$Price~nyc$Service+nyc$Food+nyc$East))
summary(lm(nyc$Price~nyc$Service+nyc$Food+nyc$East+nyc$Decor))

# Interaction term consideration: "Service" on "Food" and/or "Decor"
summary(lm(nyc$Price ~ nyc$Service:nyc$Food + nyc$Decor + nyc$East))
summary(lm(nyc$Price ~ nyc$Service:nyc$Decor + nyc$Food + nyc$East))






