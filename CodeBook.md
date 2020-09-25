
#   Getting and Cleaning Data - Course Project


Running run_analysis.R script will complete the following steps:


#### 1. Download the origin data:

    The UCI HAR Dataset folder will be unziped into the assigned working directory.

#### 2. Each data file will be read and converted to a dataset:

    activitiesLabels <- activity_labels.txt
    features <- features.txt
    subjectTest <- subject_test.txt
    subjectTrain <- subject_train.txt
    xTest <- X_test.txt
    xTrain <- X_train.txt
    yTest <- y_test.txt
    yTrain <- y_train.txt
    
#### 3. The training and test datasets will be merged:    

    xBinded <- xTrain - xTest
    yBinded <- yTrain - yTest
    subject <- subjectTest - subjectTrain
    dataMerged <- subject - yBinded
    
#### 4. The mean and standard deviation will be extracted  from each measurement. 

    Will be selected the variables subject, code and the mean and standard deviation from each measurement to create the dataMeanStd dataset.
    
#### 5. Descriptive activity names will be assignet to the activities

    The second column of the activities variable will be the new name

#### 6. Descriptive variable names will be assigned to the columns.

    id        => "activity"
    Acc       => "Accelerometer"
    Gyro      => "Gyroscope"
    BodyBody  => "Body"
    Mag       => "Magnitude"
    ^t        => "Time"
    ^f        => "Frequency"
    tBody     => "TimeBody"
    -mean()   => "Mean"
    -std()    => "STD"
    -freq()   => "Frequency"
    angle     => "Angle"
    gravity   => "Gravity"

#### 7.  Independent tidy data set will be created with the average of each variable for each activity and each subject.

    The file will be named Data.txt
    
    