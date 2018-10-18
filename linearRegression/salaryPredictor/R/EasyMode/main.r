library(caTools)
library(ggplot2)

dataset <- read.csv('../../Salary_Data.csv')
set.seed(123)
split <- sample.split(dataset$Salary, SplitRatio=2/3)
train_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

print(train_set)
print(test_set)

regressor <- lm(formula = Salary ~ YearsExperience,
               data = train_set)

guess <- predict(regressor, newdata = test_set)

print(test_set$Salary)
print(guess)

ggplot() + 
    geom_point(aes(x = train_set$YearsExperience, y = train_set$Salary),
               colour = 'green') +
    geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
               colour = 'red') +
    geom_line(aes(x = train_set$YearsExperience, y = predict(regressor, newdata = train_set)),
              colour = 'black') +
    xlab('Years of Experience') +
    ylab('Salary')
