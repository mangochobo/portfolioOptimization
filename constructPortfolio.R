library(quadprog)

constructPortfolio <- function(histReturns, covMatrix, numRVals)
{
  #get the amount of assets
  numAssets = length(histReturns)
  
  #variables
  weights = matrix(0,numAssets, numRVals)
  stdDevs = NULL
   
  #historical returns in decimals
    Returns <- histReturns * 0.01
  
  #10 desired rates of return
    RVals = seq(min(Returns), max(Returns), length.out=numRVals)
  
  
  #set up and solve the optimization problem with solve.QP
  Dmat <- 2*covMatrix
  dvec <- rep(0,numAssets) 
  
  #constraint matrix
  Amat <- matrix(cbind(rep(1,numAssets), rep(-1,numAssets), Returns, diag(numAssets)), nrow=numAssets)  
  
  for(i in 1:length(RVals)) #solve for weights for each RVal
    {
      bvec <- c(1,-1,RVals[i], rep(0,numAssets))
      
      #solve quadratic program
      solution <- solve.QP(Dmat,dvec,Amat,bvec)
      
      #get portfolio std deviation and weights at each iteration
      stdDevs[i] <- sqrt(solution$value)
      weights[,i] <- solution$solution
    }
  
  finalSolution <- matrix(weights, nrow=numAssets, ncol=length(RVals))
  
  #return weights for ea asset class and portfolio sds
  return(list(weights=finalSolution, stdDevs=stdDevs, RVals=RVals))
}