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

******************************************************************************; 
* VARIOUS SAS ROUTINES THAT CALL R USING PROC IML:                           *;
* TRAIN AN RPART DECISION TREE AND SCORE WITH PROC PSCORE AND PMML           *;
* TRAIN AN RPART DECISION TREE, SCORE IN R, AND MERGE SCORE ONTO SAS DATA    *;
******************************************************************************;

*** GENERATE TRAINING DATA; 
data _null_; 
	if ^exist('iris') then do; 
		call execute('proc copy in=sashelp out=work;'); 
		call execute('select iris;'); 
		call execute('run;'); 
	end; 
	if ^symexist('TRAINING_DATA') 
		then call symput('TRAINING_DATA', 'work.iris');
run;
%put TRAINING_DATA=&TRAINING_DATA; 

*** DEFINE SCORED DATA, TARGET AND INPUTS;  
%let TARGET=Species;
proc contents 
	data=&TRAINING_DATA 
	out=var_names(keep=name where=(name^="&TARGET")) 
	noprint; 
run;
proc sql noprint; 
	select name into :INPUTS separated by ' + ' 
	from var_names; 
quit;  
proc datasets lib=WORK nolist nowarn; 
	delete var_names; 
quit;  
%put TARGET=&TARGET; 
%put INPUTS=&INPUTS; 

*** IML/PMML/PSCORE SCHEME ***************************************************;

*** TRAIN R MODEL;  
proc iml; 

	*** IMPORT TRAINING DATA FROM SAS;
	run ExportDataSetToR("&TRAINING_DATA", "SAS_TRAINING");

	*** INITIALIZE MACRO VARIABLES FOR R ENVIRONMEMT; 
	target="&TARGET"; 
	inputs="&INPUTS";

	*** SUBMIT R STATEMENTS; 
	submit target inputs/R; 

		# import R libs
		library(rpart) 
		library(pmml)

		# train model 
		SAS_MODEL <- rpart(&target ~ &inputs, method="class", data=SAS_TRAINING)
		summary(SAS_MODEL)

		# write pmml 
		saveXML(pmml(SAS_MODEL), 'SASPMML.xml')

	endsubmit;  

quit;

*** TRANSLATE PMML INTO SAS; 
proc pscore 
	pmml file="%sysfunc(pathname(work))\SASPMML.xml" 
	ds file="%sysfunc(pathname(work))\pscore.sas"; 
run;

*** SCORE SAS DATA WITH R MODEL; 
data &TRAINING_DATA._pscore; 
	set &TRAINING_DATA; 
	%include "%sysfunc(pathname(work))\pscore.sas"; 
run;

*** IML/R predict()/MERGE SCHEME *********************************************;

*** TRAIN R MODEL;  
proc iml; 

	*** EXPORT TRAINING DATA FROM SAS TO R;
	run ExportDataSetToR("&TRAINING_DATA", "SAS_TRAINING" );

	*** INITIALIZE MACRO VARIABLES FOR R ENVIRONMEMT; 
	target="&TARGET"; 
	inputs="&INPUTS";

	*** SUBMIT R STATEMENTS; 
	submit target inputs /R; 

		# import R libs
		library(rpart) 

		# train model 
		SAS_MODEL <- rpart(&target ~ &inputs, method="class", data=SAS_TRAINING)
		summary(SAS_MODEL)

		# R generic predict function to score
		SAS_RESULTS <- predict(SAS_MODEL, type='matrix') 

	endsubmit;  

	*** IMPORT SCORED COLUMNS INTO SAS; 
	run ImportDataSetFromR("rscore", "SAS_RESULTS");

quit;

*** MERGE SCORES ONTO TRAINING DATA; 
data &TRAINING_DATA._rscore;
	merge &TRAINING_DATA rscore; 
run;
proc datasets lib=WORK nolist nowarn; 
	delete rscore; 
quit;

