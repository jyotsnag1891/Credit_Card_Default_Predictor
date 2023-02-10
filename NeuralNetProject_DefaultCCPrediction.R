library(rpart)
library(rpart.plot)
library(caret)
library(neuralnet)

#Importing the dataset
data <- read.csv("sampled_amex_dataDec2.csv",header=TRUE,na.strings = "")
rownames(data)<-data[,1]
data<-data[,-1]
View(data)
num_cols <- unlist(lapply(data, is.numeric))         # Identify numeric columns
num_cols
data_num <- data[ , num_cols]                        # Subset numeric columns of data
View(data_num) 

apply(data_num,2, function(x) is.na(x))              #check for NA values

train.index <- sample(c(1:dim(data_num)[1]), dim(data_num)[1]*0.5)  
train.df <- data_num[train.index, ]
valid.df <- data_num[-train.index, ]
#sapply(lapply(train.df, unique), length)

attach(data_num)

set.seed(2)
nn <- neuralnet(target ~ D_39+B_1+R_1+B_4+B_5+R_2+D_47+B_6+B_7+D_51+B_9+R_3+B_10+S_5+B_11+S_6+R_4+B_12+S_8+R_5+D_58+B_14+D_60+B_15+S_11+D_65+B_18+S_12
+R_6+S_13+B_21+D_71+S_15+B_23+P_4+D_75+B_24+R_7+B_25+R_8+S_16+R_10+R_11+S_17+R_12+B_28+R_13+R_14+R_15+R_16, data = valid.df, 
linear.output = F, hidden = 3, learningrate = 0.5) # 3 hidden layers

##2 hidden layers
##nn <- neuralnet(target ~ D_39+B_1+R_1+B_4+B_5+R_2+D_47+B_6+B_7+D_51+B_9+R_3+B_10+S_5+B_11+S_6+R_4+B_12+S_8+R_5+D_58+B_14+D_60+B_15+S_11+D_65+B_18+S_12
##+R_6+S_13+B_21+D_71+S_15+B_23+P_4+D_75+B_24+R_7+B_25+R_8+S_16+R_10+R_11+S_17+R_12+B_28+R_13+R_14+R_15+R_16, data = train.df, 
##linear.output = F, hidden = 2)

##1 hidden layer
##nn <- neuralnet(target ~ D_39+B_1+R_1+B_4+B_5+R_2+D_47+B_6+B_7+D_51+B_9+R_3+B_10+S_5+B_11+S_6+R_4+B_12+S_8+R_5+D_58+B_14+D_60+B_15+S_11+D_65+B_18+S_12
##+R_6+S_13+B_21+D_71+S_15+B_23+P_4+D_75+B_24+R_7+B_25+R_8+S_16+R_10+R_11+S_17+R_12+B_28+R_13+R_14+R_15+R_16, data = train.df, 
##linear.output = F, hidden = 1)

#plot Neural network model
plot(nn, rep="best")

#for training dataset
nn.pred <- predict(nn, train.df, type = "response")
nn.pred.classes <- ifelse(nn.pred > 0.5, 1, 0)  #threshold set to 0.5
confusionMatrix(as.factor(nn.pred.classes), as.factor(train.df$target))

#for validation dataset
nn.pred <- predict(nn, valid.df, type = "response")
nn.pred.classes <- ifelse(nn.pred > 0.5, 1, 0)  #threshold set to 0.5
confusionMatrix(as.factor(nn.pred.classes), as.factor(valid.df$target))

#plot ROC
library(pROC)
r <- roc(nn.pred.classes$actual, nn.pred.classes$prob)
plot.roc(r)

#compute AUC
auc(r)

