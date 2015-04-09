library("kernlab")
args <- commandArgs(trailingOnly=TRUE)

# Load data
train <- read.csv(paste(args[1], 'digitsdata_17_train.csv', sep='/'),
                        sep=',', header=T)
test <- read.csv(paste(args[1], 'digitsdata_17_test.csv', sep='/'), 
                       sep=',', header=T)

# Fit SVM
svmmodel <- ksvm(label~., data=train, type='C-svc', scaled=c(FALSE))
pred <- predict(svmmodel, test[, -1])

# Export output
write.table(pred, file=paste(args[1], 'predict_test_R.csv', sep='/'), eol="\n", 
            row.names=F, col.names=F)

