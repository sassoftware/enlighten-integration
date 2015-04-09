import numpy as np
import sys, os
from sklearn import svm

# Load data
train = np.genfromtxt(os.path.join(sys.argv[1], "digitsdata_17_train.csv"),\
	              delimiter=",", skip_header=1)
test = np.genfromtxt(os.path.join(sys.argv[1], "digitsdata_17_test.csv"),\
	             delimiter=",", skip_header=1)
X = train[:, 1:]
y = train[:, 0]
Xtest = test[:, 1:] 

# Fit SVM
clf = svm.LinearSVC()
clf.fit(X, y)
pred = clf.predict(Xtest)
pred = pred.reshape(200, 1)

# Export output
np.savetxt(os.path.join(sys.argv[1], 'predict_test_python.csv'), pred, fmt='%f')
