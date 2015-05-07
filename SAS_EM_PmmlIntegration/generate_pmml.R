# Set to git repository directory
git_dir <- ''
# Import decision tree and pmml library
library(rpart)
library(pmml)

# Ensure you are using pmml_1.4.1
# For EM Version < 14.1
# More info: https://communities.sas.com/docs/DOC-9988 
print(sessionInfo())

# Load some sample data
data(iris)

# Give the variables names that can be used in SAS
sas_names <- c( "SepalLen","SepalWid","PetalLen","PetalWid","Species" )
colnames(iris) <- sas_names

# Build a type of model for which SAS PROC PSCORE can import the generated PMML
model <- rpart(Species ~., method="class", data=iris)

# Save PMML file to git directory
saveXML(pmml(model), paste(git_dir, 'emRPMML.xml', sep='\\'))

# Save data as CSV to git directory
write.table(iris, file=paste(git_dir, 'iris.csv', sep='\\'), sep=',', row.names=FALSE)