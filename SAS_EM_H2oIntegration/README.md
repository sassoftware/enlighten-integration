/******************************************************************************

Copyright (c) 2016 by SAS Institute Inc., Cary, NC 27513 USA

Licensed under the Apache License, Version 2.0 (the "License"); 
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

   http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.  

******************************************************************************/

Code and materials for integrating h2o packages using Open Source Integration
node in SAS Enterprise Miner.

==========

These examples were tested in the following environment:

Windows Server 2008 R2 Enterprise (SP1)
Dual Intel Xeon E5-2667 @ 2.9 GHz
128 GB RAM 
SAS Enterprise Miner 14.1
Oracle JDK 1.8.0_73 64-Bit

R 3.1.2
R package: h2o 3.8.0.6 (Rel-Tukey)
R package: h2oEnsemble 0.1.6

==========

To run this demo:

- Use R version 3.1.2
- Install h2o-R package and any packages it depends upon. 
  Use instructions from h2o download site http://www.h2o.ai/download/h2o/r
- Install h2oEnsemble package (need this package to run Super Learner)
  The following steps are used to install h2oEnsemble package in R:
    install.packages("devtools")
    library(devtools)
    install_github("h2oai/h2o-3/h2o-r/ensemble/h2oEnsemble-package")

- Create a new SAS Enterprise Miner project and add IRIS data by clicking
  Help >> Generate Sample Data Sources. Select Fisher-Anderson Iris 
  data set and click OK
- Unzip train_normalized_py.zip (subset of MNIST data) to local file 
  directory. Create a new library (pointing to the unzipped file 
  location) in SAS Enterprise Miner using File >> New >> Library
- Right-click on Data Sources and select Create Data Source and add 
  SAS data set train_normalized_py.sas7bdat from above library. In the 
  Data Source wizard, at Step 5 of 8 Column Metadata, select
  Role=Target and Level=Nominal for label variable. Use defaults
  in all other places.  
- Import SimplePCA.xml and DeepAndSuperLearner.xml diagrams into 
  SAS Enterprise Miner. (File -> Import Diagram From XML ...)
- Run the process flows in SimplePCA and DeepAndSuperLearner diagrams

==========

NOTES:
- SimplePCA runs Principal Component Analysis in h2o
- DeepAndSuper Learner has two separate flows - top flow performs h2o Deep
  Learning with validation and bottom flow runs h2o Super Learner with 
  5 fold cross validation.
- H2o currently does not support Super Learner algorithm for nominal
  target, so a SAS Code node is added in the bottom flow to subset MNIST 
  data (digits 1 and 7) to make the target binary.
- In these diagrans, the Open Source Integration node sets Output Mode
  property to Merge to merge predictions with input data.
