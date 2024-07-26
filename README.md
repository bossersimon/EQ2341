
All raw data used for model training and evaluation lies in the zipped 'drive' file and the existing code can be used to generate the results. The location of the folder containing the recordings has to be manually changed from 'sensorlogger' in the code.

Alternatively, the 'features.zip' file contains all the extracted features together with the corresponding state. Each row consists of an [X,S]-pair, so the rows can be appended to each other recreate the array.

For the train/test split, note that random_seed = 1.


