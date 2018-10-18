library(caTools)
library(ggplot2)

dataset <- read.csv('../../Salary_Data.csv')
set.seed(999)
# print(dataset)
split <- sample.split(dataset$Salary, SplitRatio=5/6)
train_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

learning_rate <- 0.0001
iteration <- 100000

m <- 0
c <- 0

predict <- function(x) {
    # print(m)
    return (m * x) + c
}

l_train <- length(as.matrix(train_set)) / 2
l_test <- length(as.matrix(test_set)) / 2

curr <- 1
for (i in 1:iteration) {
    guess <- predict(train_set[curr, 1])

    error <- train_set[curr, 2] - guess
    m <- m + (error * learning_rate * train_set[curr, 1])
    c <- c + (error * learning_rate)

    if (curr + 1 > l_train) {
        curr <- 1
    } else {
        curr <- curr + 1
    }
}

for (i in 1:l_train) {
    print(cat(train_set[i, 2], predict(train_set[i, 1])))
}

for (i in 1:l_test) {
    print(cat(test_set[i, 2], predict(test_set[i, 1])))
}

ggplot() +
    geom_point(aes(x = train_set$YearsExperience, y = train_set$Salary),
               colour = 'green') +
    geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
               colour = 'red') + 
    geom_line(aes(x = train_set$YearsExperience, y = predict(train_set$YearsExperience)),
              colour = 'black') +
    xlab('Years of Experience') +
    ylab('Salary')
