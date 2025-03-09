library(MASS)
set.seed(500)

var_sum <- 0; covar_sum <- 0; total_var <- 0 #Predefine terms in the for loop

sd <- 0.1
rho <- 0.2
variance <- sd*sd # Variance is 0.01
covariance <- variance*rho # Remember the formula for correlation coefficient above, we get 0.002 here

for(n in 1:50){
  var_sum[n] <- 1/n * variance # Average of the same variance term 0.01 remains 0.01
  covar_sum[n] <- (n-1)/(n) * covariance # Average of the same covariance terms 0.002 remain 0.002
  total_var[n] <- var_sum[n] + covar_sum[n]
}

total_var

var_sum_p <- 0; covar_sum_p <- 0; total_var_p <- 0
sd <- 0.1
rho <- 0.8
variance <- sd*sd
covar <- variance*rho
for(n in 1:50){
  var_sum_p[n] <- 1/n * variance # Again, average of same variance terms of 0.01 remains 0.01
  covar_sum_p[n] <- (n-1)/n * covar # Average of same covariance terms of 0.008 remains 0.008
  total_var_p[n] <- var_sum_p[n] + covar_sum_p[n]
}
total_var_p

par(mfrow=c(1,2))
plot(1:50, total_var, type='l', xlab= 'Assets in Portfolio', ylab= 'Variance', ylim=c(0,0.01), main='Variance of Returns 𝜌 = 0.2 ')
lines(1:50, var_sum, type='l', lty=2)
lines(1:50, covar_sum, type='l', lty=3)
legend('topright', lty=c(1,2,3), c('Total Variance', 'Variances', 'Covariances'))

plot(1:50, total_var_p, type='l', xlab= 'Assets in Portfolio', ylab= 'Variance', ylim=c(0,0.01), main='Variance of Returns 𝜌 = 0.8 ')
lines(1:50, var_sum_p, type='l', lty=2)
lines(1:50, covar_sum_p, type='l', lty=3)
legend('topright', lty=c(1,2,3), c('Total Variance', 'Variances', 'Covariances'))

# Create matrix of the data set to show the variance of portfolio returns as correlation coefficient changes
var_sum <- matrix(NA, 10, 50); covar_sum <- matrix(NA, 10, 50); total_var <- matrix(NA, 10, 50)
rho_seq <- seq(0,1,length.out=10)
sd <- 0.1
var <- sd*sd

for(n in 1:length(rho_seq)){
  for(k in 1:50){
    var_sum[n,k] <- 1/k * var
    covar_sum[n,k] <- (k-1)/k * rho_seq[n] * var
    total_var[n,k] <- var_sum[n,k] + covar_sum[n,k]
  }
}
total_var

# Let us graph variance of portfolio returns by different correlation coefficients
color <- rainbow(10)
par(mfrow=c(1,1))
plot(1:50, total_var[1,], type="l", col = color[1], xlab= 'Assets in Portfolio', ylab='Variance', main='Total Variation of Portfolio Returns by Correlation Coefficient')
for(i in 2:10){
  lines(1:50, total_var[i,], type="l", col=color[i])
}
legend('bottomleft', lty=c(rep(1,10)), col=color, as.character(round(rho_seq,2)), cex=0.5, title='𝜌')


# Simulation of stock returns
sd <- 0.1
rho <- 0.2

# 2-asset portfolio
n_1 <- 2
mean_1<- as.vector(rep(0, n_1))
# The variance-covariance matrix is 2x2 as there are 2 assets. We first fill in the matrix with only the
# covariance inputs, because all covariance entries will be the same and they are in the off diagonals.
var_cov_mat_1 <- matrix(sd*sd*rho, n_1 , n_1 ) 
# Now, we simply change the diagonals in the previously created matrix to the variance terms to fit the definition
# of variance-covariance matrix
diag(var_cov_mat_1) <- sd*sd

mean_1
var_cov_mat_1

# 20-asset portfolio
n_2<- 20
mean_2<- as.vector(rep(0, n_2))
# The variance-covariance matrix is 20x20 as there are 20 assets. We first fill in the matrix with only the
# covariance inputs, because all covariance entries will be the same and they are in the off diagonals.
var_cov_mat_2 <- matrix(sd*sd*rho, n_2, n_2) 
# Now, we simply change the diagonals in the previously created matrix to the variance terms to fit the definition
# of variance-covariance matrix
diag(var_cov_mat_2) <- sd*sd

mean_2
var_cov_mat_2

# Simulation of stock returns of 

nsims <- 100000
result_sim_1 <- mvrnorm(nsims, mean_1, var_cov_mat_1); result_sim_1
sim_1 <- rowMeans(result_sim_1); sim_1
result_sim_2 <- mvrnorm(nsims, mean_2, var_cov_mat_2)
sim_2 <- rowMeans(result_sim_2); sim_2
par(mfrow=c(1,2))
hist(sim_1, xlab='Portfolio Return', main='Simulation of Returns of 2-Asset Portfolio', xlim=c(-0.4,0.4))
hist(sim_2, xlab='Portfolio Return', main='Simulation of Returns of 20-Asset Portfolio', xlim=c(-0.4,0.4))

# Check VaR 
quantile(sim_1, 0.99)
quantile(sim_1, 0.01)

quantile(sim_2, 0.99)
quantile(sim_2, 0.01)

# Insurance example:

claims_ind <- function(sims, house){
  # First generate sims*house independent probabilities of claims
  prob <- runif(house*sims)
  # Now, make a matrix of zeroes, and use which() function to apply values of
  # 0, 5000, 100 000, 1 000 000 into the matrix
  prob_mat <- matrix(0, 1, sims*house)
  prob_mat[which(prob <= 0.95)] <- 0
  prob_mat[which(prob > 0.95 & prob <= 0.999)] <- 5000
  prob_mat[which(prob > 0.999 & prob <= 0.9999)] <- 100000
  prob_mat[which(prob > 0.9999)] <- 1000000
  # Regroup the matrix into the proper order by row and column! 
  prob_mat_fin <- matrix(prob_mat, sims, house)
  total_claims <- rowSums(prob_mat_fin)
  total_claims
}


claims_corr <- function(sims, house){
  # First generate dependent probabilities of claims with only sims.
  prob <- runif(sims)
  # Then, replace probabilities with the values of 0, 5000, 100000, 1000000
  prob_mat <- matrix(0, 1, sims)
  prob_mat[which(prob <= 0.95)] <- 0
  prob_mat[which(prob > 0.95 & prob <= 0.999)] <- 5000
  prob_mat[which(prob > 0.999 & prob <= 0.9999)] <- 100000
  prob_mat[which(prob > 0.9999)] <- 1000000
  # This matrix replicates the probability vector above by the number of columns, 
  # that is number of houses inputted. The idea with this structure is if a probability
  # is high enough to trigger a claim, the other columns will follow suit since they are
  # replicated, mimicking the nature of housing claims that are perfectly correlated.
  prob_mat_fin <- matrix(prob_mat, sims, house)
  total_claims <- rowSums(prob_mat_fin)
  total_claims
}

# Note, be careful on typing which(prob <= 0.5) and which(prob_mat <= 0.5).
# The reason why which(prob_mat <= 0.5) is not appropriate is because you essentially
# ask the code to check whether ALL elements of the matrix (because prob_mat is a matrix) is
# less than 0.5! If this is satisfied then ALL elements of the matrix will be assigned the same
# value but that is not we want. We want to check the value which every SINGLE element can take!

claims_ind_10 <- claims_ind(100000,10)
claims_ind_100 <- claims_ind(100000,100)
claims_ind_1000 <- claims_ind(100000,1000)

claims_corr_10 <- claims_corr(100000,10)
claims_corr_100 <- claims_corr(100000,100)
claims_corr_1000 <- claims_corr(100000,1000)

# Checks the top 20 highest total claims of each simulation of 10, 100 portfolio houses
head(claims_ind_10[order(-claims_ind_10)], 20)
head(claims_corr_10[order(-claims_corr_10)], 20)

head(claims_ind_100[order(-claims_ind_100)], 20)
head(claims_corr_100[order(-claims_corr_100)], 20)

head(claims_ind_1000[order(-claims_ind_1000)], 20)
head(claims_corr_1000[order(-claims_corr_1000)], 20)

# Create histogram of simulated total_claims distribution
par(mfrow=c(3,3))
hist(claims_ind_10, breaks=50, xlab='Total Claim', main='Distribution Total Claims of 10 Policies Portfolio 𝜌 = 0', cex.main=0.8)
hist(claims_ind_100, breaks=50, xlab='Total Claim', main='Distribution Total Claims of 100 Policies Portfolio 𝜌 = 0', cex.main=0.8)
hist(claims_ind_1000,  breaks=50, xlab='Total Claim', main='Distribution Total Claims of 1000 Policies Portfolio 𝜌 = 0', cex.main=0.8)
hist(claims_corr_10, breaks=50, xlab='Total Claim', main='Distribution Total Claims of 10 Policies Portfolio 𝜌 = 1', cex.main=0.8)
hist(claims_corr_100, breaks=50, xlab='Total Claim', main='Distribution Total Claims of 100 Policies Portfolio 𝜌 = 1', cex.main=0.8)
hist(claims_corr_1000, breaks=50, xlab='Total Claim', main='Distribution Total Claims of 1000 Policies Portfolio 𝜌 = 1', cex.main=0.8)


# Tails of histogram is not that clear especially for the cases of perfect correlation
# Let us use table() to check the different claim amounts and also its respective probability.
table(claims_corr_10)/100000
table(claims_corr_100)/100000
table(claims_corr_1000)/100000

table(claims_ind_10)/100000
table(claims_ind_100)/100000
table(claims_ind_1000)/100000

# Max()
max(claims_corr_10)
max(claims_corr_100)
max(claims_corr_1000)

max(claims_ind_10)
max(claims_ind_100)
max(claims_ind_1000)
