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

Code and materials to import a PMML model generated in R into SAS Enterprise
Miner. 

This code was tested in the following environment:
- Windows Server R2008
- R 2.15.3 with pmml_1.4.1 (VERY IMPORTANT, more info: https://communities.sas.com/docs/DOC-9988)
- SAS Enterprise Miner 13.2

==========

To run this demo:
- Set the git_dir variable in the generate_pmml.R file to the directory
  containing the generate_pmml.R file. (Probably this directory)
- Run the R file ensuring PMML is generated using the pmml_1.4.1 package. 
- Create a new SAS Enterprise Miner project and import the import_pmml.xml
  diagram into SAS Enterprise Miner. 
  (File -> Import Diagram From XML ...)
- Open the SAS Code node code editor and set the git_dir variable to the
  directory containing the import_pmml.xml file. (Probably this directory)
- Run the IDS -> SAS Code node flow.

==========

- The emRPMML.xml file in this repository contains a basic R decision tree
  model that can be read using SAS PROC PSCORE. 
- The iris.csv file is supplied just in case you need it.



