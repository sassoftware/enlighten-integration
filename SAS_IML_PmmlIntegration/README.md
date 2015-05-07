/******************************************************************************

Copyright (c) 2015 by SAS Institute Inc., Cary, NC 27513 USA

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

Code and materials for calling R with SAS PROC IML.

These examples where tested in the following environment:

Windows Server 2008 R2 Enterprise

Dual Intel Xeon E5-2667 @ 2.9 GHz

128 GB RAM 

SAS 9.4 (TS1M2)

R 2.15.3 with PMML 1.4.1 

===============

1.) Install R:

SAS/IML Version: 13.1 
  -> Recommended versions of R: 2.13.0-3.0.2 
  -> Required Version of PMML Package: pmml_1.4.1

SAS/IML Version: 13.2 
  -> Recommended versions of R: 2.15.3-3.0.3 
  -> Required Version of PMML Package: pmml_1.4.1

SAS/IML Version: 14.1 
  -> Recommended versions of R: 3.0.1-3.1.2 
  -> Required Version of PMML Package: pmml_1.4.2
 
2.) If it is not set, set the -RLANG SAS system option:

The –RLANG option is typically added to the main sasv9.cfg file of a given
SAS installation. 

The main sasv9.cfg file is often located in a directory like 

C:\Program Files\SASHome\SASFoundation\9.4\nls\en

Once you have found this file, add 

-RLANG 

to the bottom of the file. 

3.) Run SAS_IML_R.sas

===============
Discussion:
===============

This example shows how to call R models with SAS PROC IML and translate PMML
into SAS code. 

The SAS program (sas_iml_R.sas) through PROC IML trains a R decision tree model 
using well-known IRIS data where the flower species is predicted using sepal, 
petal length and width. Next, the model parameters are exported as PMML for 
subsequent scoring. The SAS program then converts PMML into SAS Data Step code
(using PROC PSCORE), scores IRIS data in SAS, and merges scored data with
training data.

Another, simpler approach is put forward, in which training data is scored in 
R, exported from R to SAS, and then merged onto the training data in SAS.