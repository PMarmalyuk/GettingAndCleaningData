## Important: Before running the script be sure that you have stable Internet connection!
## Important: Before running the script set your working directory by setwd() command!

Here is the information about how the scrip works (steps A-I):
A. The script downloads the archive data file provided in the assignment using following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
B. Then it reads overall information (activity_labels.txt and features.txt) directly from the downloaded archive to get:
1) the linkage table with activity IDs and corresponding activity labels;
2) the names of features (variables) provided.
Data are stored into two data frames. Then the script renames columns of the data frames to make them informative.
C. The next step implemented in the script is reading the training data (y_train.txt, subject_train.txt and X_train.txt) directly from the downloaded archive to get:
1) numeric activity IDs ("y_train_numeric" variable) for each observation;
2) a new factor variable "y_train" with 6 levels labelled in accordance with data from the linkage table ID <-> Activity name);
3) subjects IDs for each observation;
4) measurement results for each observation;
During this step the activity factor variable and subject ID variable are joined together by using cbind command. 
The resulting data frame's ("subj_act_train") columns are named as "Activity.ID" and "Subject.ID" to make them informative.
The "x_train" data frame's columns containing measurement results are renamed using feature names to make them informative and in order to make further variable subsetting possible.
Then the script joins the data frame "subj_act_train" and the measurement results data frame "x_train" to get the training dataset "training_dataset". 
D. After this the script repeats step C for test data as the test data files are analogous to the train data files.
E. Having obtained two datasets ("training_dataset" and "test_dataset") the script merges them by using rbind command.
F. The next step is analyzing feature names in order to find indices of variables containing measurements on the mean and standard deviation.
To do this the script uses the regular expression "*mean\\()|*std\\()" which allows to find strings containing substrings "mean()" or "std()" following any number of symbols.
It is necessary to add the number of additional features (activity and subject IDs) which have been included in the dataset to the indices obtained by grep command.
G. The next step is extracting corresponding data from the dataset (by variable subsetting).
H. The next step is creating an independent tidy data set with the average of each variable for each activity and each subject by using suitable reshape2 package's functions (melt and dcast).
I. The final step is saving obtained tidy dataset into a working directory.
