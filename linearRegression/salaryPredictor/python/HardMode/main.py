import pandas as pd
import matplotlib.pyplot as plt
import numpy.random as random

# read dataset
dataset = pd.read_csv('../../Salary_Data.csv').values
random.shuffle(dataset)
train_set = dataset[:25]
test_set = dataset[25:]

learning_rate = 0.0001
iteration = 100000

# linear regression formula y = mx + c
c = 0
m = 0

def predict (x):
    return (m * x) + c

for i in range(iteration):
    guess = predict(train_set[i % len(train_set), 0])
    error = train_set[i % len(train_set), 1] - guess

    c += error * learning_rate
    m += train_set[i % len(train_set), 0] * error * learning_rate
print(c)
print('comparison in training set:')
print('prediction vs actual salary')
for d in train_set:
    print(str(predict(d[0]))+ ' '+str(d[1]))

print()
print('comparison in test set:')
print('prediction vs actual salary')

for d in test_set:
    print(str(predict(d[0]))+ ' '+str(d[1]))

print(train_set)
plt.scatter(train_set[:, 0], train_set[:, 1], color="green")
plt.scatter(test_set[:, 0], test_set[:, 1], color="red")
plt.plot(dataset[:, 0], [predict(x) for x in dataset[:, 0]])
plt.show()

