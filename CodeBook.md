Codebook for the project 
==========================
This code book describes the variables, the data, and any transformations or work that was performed to clean up the data.

Data
---------------
The data for the project comes from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Transformations
-----------------------
The test data files
    - subject_test.txt
    - X_test.txt
    - y_test.txt
and the training data files
 - subject_train.txt
 - X-train.txt
 - y_train.txt
Are combined to form two datasets that are output as 
- tidy_data_set.txt
- tidy_data_average.txt



Variables
-------------
. subject - Subject IDs are a range between 1 and 30.         
. activity - Includes walking, walkingupstairs, walkingdownstairs, sitting, standing, laying          
. Attribute Names
tbodyacc-mean-x

tbodyacc-mean-y

tbodyacc-mean-z

tbodyacc-std-x

tbodyacc-std-y

tbodyacc-std-z

tgravityacc-mean-x

tgravityacc-mean-y

