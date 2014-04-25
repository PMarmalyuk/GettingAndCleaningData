==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universitа degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

==================================================================
How the data is processed
==================================================================
* A. The script downloads the archive data file provided in the assignment using following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* B. Then it reads overall information (activity_labels.txt and features.txt) directly from the downloaded archive to get:
1) the linkage table with activity IDs and corresponding activity labels;
2) the names of features (variables) provided.
Data are stored into two data frames. Then the script renames columns of the data frames to make them informative.
* C. The next step is reading the training data (y_train.txt, subject_train.txt and X_train.txt) directly from the downloaded archive to get:
  * Numeric activity IDs ("y_train_numeric" variable) for each observation.  
  * A new factor variable "y_train" with 6 levels labelled in accordance with data from the linkage table ID <-> Activity name).
  * Subjects IDs for each observation.
  * Measurement results for each observation.
During this step the activity factor variable and subject ID variable are joined together by using cbind command. 
The resulting data frame's ("subj_act_train") columns are named as "Activity.ID" and "Subject.ID" to make them informative.
The "x_train" data frame's columns containing measurement results are renamed using feature names to make them informative and in order to make further variable subsetting possible.
Then the script joins the data frame "subj_act_train" and the measurement results data frame "x_train" to get the training dataset "training_dataset". 
* D. After this the script repeats step C for test data as the test data files are analogous to the train data files.
* E. Having obtained two datasets ("training_dataset" and "test_dataset") the script merges them by using rbind command.
* F. The next step is analyzing feature names in order to find indices of variables containing measurements on the mean and standard deviation.
To do this the script uses the regular expression "*mean\\()|*std\\()" which allows to find strings containing substrings "mean()" or "std()" following any number of symbols.
It is necessary to add the number of additional features (activity and subject IDs) which have been included in the dataset to the indices obtained by grep command.
* G. The next step is extracting corresponding data from the dataset (by variable subsetting).
* H. The next step is creating an independent tidy data set with the average of each variable for each activity and each subject by using suitable reshape2 package's functions (melt and dcast).
* I. The final step is saving obtained tidy dataset into a working directory.

Pavel A. Marmalyuk
