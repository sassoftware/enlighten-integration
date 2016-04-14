"""
Copyright (c) 2016 by SAS Institute
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
   http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

@author: radhikha.myneni@sas.com

"""

import numpy as np
import sys, os
from sklearn import ensemble

# load data
train = np.genfromtxt(os.path.join(sys.argv[1], "digitsdata_17_train.csv"),\
	              delimiter=",", skip_header=1)
X = train[:, 1:]
y = train[:, 0]

# train model
params = {'n_estimators': 100, 'max_depth': None, 'min_samples_split': 1,
          'random_state': 0}
clf = ensemble.RandomForestClassifier(**params)

clf.fit(X, y)
predp = clf.predict_proba(X)

# export output
np.savetxt(os.path.join(sys.argv[1], 'predict_train_py_forest_prob.csv'), predp, fmt='%f', delimiter=",")
