import pandas as pd
import matplotlib.pyplot as plt

dataset = pd.read_csv('../../Salary_Data.csv')

year = dataset.iloc[:, :-1].values
salary = dataset.iloc[:, 1].values

from sklearn.model_selection import train_test_split
year_train, year_test, salary_train, salary_test = train_test_split(year, salary, test_size=1/6, random_state=0)

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(year_train, salary_train)

print('prediction vs real salary (train set)')
salary_prediction = regressor.predict(year_train)
for i in range(len(year_train)):
    print([salary_train[i], salary_prediction[i]])
print()
print('prediction vs real salary (test set)')
salary_prediction = regressor.predict(year_test)
for i in range(len(year_test)):
    print([salary_test[i], salary_prediction[i]])

plt.scatter(year_train, salary_train, color='green')
plt.scatter(year_test, salary_test, color='red')
plt.plot(year_train, regressor.predict(year_train))
plt.show()

