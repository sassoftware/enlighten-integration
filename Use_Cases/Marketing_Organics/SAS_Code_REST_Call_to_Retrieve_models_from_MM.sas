/* get all models of a project */
%let projectModelsUrl = "http://sasva.demo.sas.com/SASContentServer/repository/default/ModelManager/MMRoot/Marketing";
filename output "D:\EM_Projects\models.txt";
proc http 
   method="GET" 
   out=output
   HTTP_TOKENAUTH
   url=&projectModelsUrl;
   headers
   	"Accept"="application/json";
run;


%let scoreCodeUrl = "http://sasva.demo.sas.com/SASContentServer/repository/default/ModelManager/MMRoot/Marketing/New_Product_Propensity/1.0/Models/Propensity_Q1_Ensemble_Dtree_GLM_EM/score.sas";
filename output "D:\EM_Projects\score.sas";

proc http 
   method="GET" 
   out=output
   HTTP_TOKENAUTH
   url=&scoreCodeUrl;
run;