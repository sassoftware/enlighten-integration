******************************************************************************;
* Copyright (c) 2016 by SAS Institute Inc., Cary, NC 27513 USA               *;
*                                                                            *;
* Licensed under the Apache License, Version 2.0 (the "License")             *;
* you may not use this file except in compliance with the License.           *;
* You may obtain a copy of the License at                                    *;
*                                                                            *;
*   http://www.apache.org/licenses/LICENSE-2.0                               *;
*                                                                            *;
* Unless required by applicable law or agreed to in writing, software        *;
* distributed under the License is distributed on an "AS IS" BASIS,          *;
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *;
* See the License for the specific language governing permissions and        *;
* limitations under the License.                                             *;
******************************************************************************;

*** call python **************************************************************;

data _null_;
  length rtn_val 8;
  /* python program takes working directory as first argument */
  python_pgm = "&WORK_DIR.\em_digitsdata_forest.py";
  python_arg1 = "&WORK_DIR";    
  python_call = cat('"', trim(python_pgm), '" "', trim(python_arg1), '"');
  declare javaobj j("dev.SASJavaExec", "&PYTHON_EXEC_COMMAND", python_call);
  j.callIntMethod("executeProcess", rtn_val);
run;

*** load data and prediction CSV files from python into SAS datasets *********;

proc import
  out = predict_py
  datafile = "&WORK_DIR.\predict_train_py_forest_prob.csv"
  dbms = csv
  replace;
  getnames = no;
run;

proc import
  out = digitsdata_17_train
  datafile = "&WORK_DIR.\digitsdata_17_train.csv"
  dbms = csv
  replace;
  getnames = yes;
run;

/* export results to subsequent nodes */
data &EM_EXPORT_TRAIN;
  set digitsdata_17_train;
  /* correct names for easy model import */
  set predict_py (rename=(var1=p_label1 var2=p_label7));
run;
