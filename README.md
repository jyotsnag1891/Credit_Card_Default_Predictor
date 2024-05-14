# Unlocking Financial Insights: Predicting High-Risk Credit Card Defaults 

Obejective:
1.To predict potential delinquent customers based on their customer profile, and the bill payment pattern for the previous 50 months.
2.To optimize credit card lending decisions, which leads to a better customer experience and sound business economics.

Data Source:
Kaggle:  Amex Credit Card Default Prediction 
Computationally heavy data – 4.5M unique records(16gb)
Initial iteration using first 20,000 records
Model convergence time was very high
Final Dataset - Randomly sampled 2,000 records

Data description:
The dataset contains aggregated profile features for each customer at each statement date.
Target Variable 
	Customer is Delinquent or not
	What is Delinquency: If Credit Card bill is unpaid >120 days
Independent Variables : 191 
	Spend
	Balance
	Payment history
	Delinquency
	Risk Factor
All the predictors are anonymized and normalized.

Exploratory Data Analysis:
102 predictors have missing values
24 Predictors have >60% missing
Missing value imputation:
	For numeric: Replaced missing values with median
	For Character: Created separate category.
Created Dummies using fast dummies library.

Neural Network was a strong contender for choosing an efficient predictive model for our dataset.

Model tuning (hyperparameters)
Learning rate= 0.5
Number of hidden layers= 3 





