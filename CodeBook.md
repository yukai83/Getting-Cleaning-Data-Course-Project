#Description
run_analysis.R does the following:

1. Combine training & test datasets into one big dataset 
1.a: Download from website the zip file
1.b: Transfer downloaded data into R
1.c: Combine both datasets (Datasets are merged using the rbind() function)

2. Extract only the measurements on the mean and standard deviation for each measurement. 
2.a: Transfer the feature name into R and extract measurements

3. Rename activities in the dataset to be more meaningful

4. Create 2nd independent tidy data set with average of each variable for each activity & subject (Tidy_Data.txt)


#Variables Used
train.x, train.y, test.x, test.y, train.sub and test.sub are from the downloaded data
training_Data, testing_Data and Combined_Data are the combined datasets from the downloaded data
feature_Name, feature_Index and Complete_Data are the transferred feature names in R as well as extracted measurements
grouped_Data is the 2nd independent tidy data set with average of each variable for each activity & subject