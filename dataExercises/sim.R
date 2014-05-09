library(lattice)
# http://lattice.r-forge.r-project.org/Vignettes/src/lattice-tricks/regression-lines.pdf
library(ggplot2)
sim <- data.frame(
    age= sample(20:50, 200, replace=TRUE)
    ,edu=factor(sample(0:1, 200, replace=TRUE, prob=.2))
sim$salary <- with(sim, .15*age + 1.50*edu + .25*(age*edu)) + rnorm(200,mean=20,sd=10)
sim$salary <- sim$salary*1000
head(sim)

mod <- lm(salary ~ age + edu + age:edu, data=sim)
mod
summary(mod)
ggplot(sim, aes(x=age, y=salary,colour=factor(edu) )) + geom_point() + geom_smooth(method='lm')

grid <- expand.grid(age=c(20:70), edu=0:2)
grid$salary = predict(mod, grid)
p <- ggplot(grid, aes(x=age, y=salary, colour=factor(edu, levels=0:2))) + geom_point(data=sim) 
p
p + geom_smooth(method='lm', data=grid)

debugonce(ggplot2:::Stat$calculate_groups) # proto
debugonce(ggplot2:::StatSmooth$new) #proto
debugonce(ggplot2:::predictdf) # regular r function
debugonce(ggplot2:::predictdf.default) # s3 method

debugonce(panel.xyplot)
debugonce(panel.lmline)
debugonce(panel.loess)
xyplot(fake ~ age, groups=factor(edu), 
       data=grid,
       type=c("r","p","smooth"), as.table=TRUE)

rmnorm <- function(mu, Sigma){
    ch <- chol(Sigma)
    z <- rnorm(length(mu))
    y <- mu + t(ch) %*% z
    y
}
simulate <- function(x){
    x <- c(1, x[1:2], x[1]*x[2])
    betastar <- rmnorm(coef(mod), vcov(mod))
    ystar <- x %*% rmnorm(betastar, vcov(mod))
    ystar
}
fake <- apply(grid, 1, simulate)
grid$fake <- fake
p <- ggplot(grid, aes(x=age, y=fake, colour=factor(edu, levels=0:2))) + geom_point() 
p








