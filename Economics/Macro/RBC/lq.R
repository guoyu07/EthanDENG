# install numDeriv pkg to calculate the
# Jacobian Matrix and Hessian Matrix
install.packages("numDeriv")
library(numDeriv)

# parameter for the economy
a <- 0.33
b <- 0.96
p <- 0.95
d <- 0.10

# the steady state(SS) of capital, investment and shocks
K <- ((a*b)/(1-b*(1-d)))^(1/(1-a))
X <- d*K
Z <- 0
W <- as.matrix(c(Z,K,X))

# define the return function to compute the
# jacobian matrix and hessian matrix with numDeriv pkg
re_fun <- function(u) {
    z <- u[1]; k <- u[2]; x <- u[3];
    return(log(exp(z)*k^a-x))
}

# jabobian matrix and hessian matrix
# Taylor Expansion of return function
R0 <- re_fun(W)
J0 <- t(jacobian(re_fun,W))
H0 <- hessian(re_fun,W)

# format the Expansion of the return function as
# quadratic form
Q = matrix(rep(NA,16),ncol=4)
Q[1,1] <- R0- t(W) %*% J0 + 0.5 %*% t(W) %*% H0 %*% W
Q[-1,1] <- 0.5*(J0 - H0 %*% W)
Q[1,-1] <- t(Q[2:4,1])
Q[-1,-1] <- 0.5 * H0

# state variable
Qff <- Q[-4,-4]
Qfd = Q[4,-4]
Qdd = Q[4,4]

# The linear constraint
B <- matrix(rep(0,12),ncol=4)
B[1,1] <- 1
B[2,2] <- p
B[3,3] <- 1-d
B[3,4] <- 1

# initial P0
P <- -0.1 * diag(3)
# instrument matrix
A <- matrix(rep(1,9),ncol=3)

# error setup
# the 2-norm of the matrix is often used to measure
# the convergence of a matrix
# the while condition controls the termination of the loop
# actually, A is P_{n} at first, and P is P_{n+1}
while (norm(A-P)/norm(A)>0.0000001) {
    A <- P
    M <- t(B) %*% P %*% B
    Mff <- M[-4,-4]
    Mfd <- M[4,-4]
    Mdd <- M[4,4]
    P <- Qff + b * Mff - as.matrix(Qfd + b * Mfd) %*% solve(Qdd + b * Mdd) %*% t(as.matrix(Qfd + b * Mfd))
}

# the matrix of the Value funcion
print("The matrix of the value function is given by")
P
# the value function of the economy is
# given by V = t(F) %*% P %*% F
# where F = t(c(1,z,k)), F is the state vector
# and the decision rule is given by d(F).
# i.e. the policy function is d(F) = J %*% F
J <- -solve(Qdd + b * Mdd) %*% t(as.matrix(Qfd + b * Mfd))
print("The decision rule is given by")
J
