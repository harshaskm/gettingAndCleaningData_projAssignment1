#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#
#								                                                     #
#                       Project Assignment			                     #
#								                                                     #
#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#

	rm(list=ls())
	library(dplyr)
	library(tidyr)

	# I have chosen to load the activity list first into a data.frame
	setwd("/home/ruser/coursera_courses/gettingAndCleaningData/prog_assign_1/uci_har_dataset")
		act_list <- read.csv("activity_labels.txt", sep = "", header = F)
		colnames(act_list) <- c("activityValue", "activityName")

	# 2nd step to load the details of TEST data
	setwd("/home/ruser/coursera_courses/gettingAndCleaningData/prog_assign_1/uci_har_dataset/test")
		# Loading the subjects into memory structures:
			test_who_per <- read.csv("subject_test.txt", sep = "", header = F)
		# Setting a column name:
			colnames(test_who_per) <- "Subject"

		# Loading data of Activities performed by the subjects:
			test_act <- read.csv("y_test.txt", sep = "", header = F)
		# Setting column name:
			colnames(test_act) <- "PerformedActivities"

		# Loading TEST data (which contains just numbers of all the stats gathered):
		test_dt <- read.csv("X_test.txt", sep = "", header = F)

	# 3rd step to load all the Training data provided:
	# Currently I am not sure how to change folders within the folder that I am in right now, so I am setting the setwd many times:
	setwd("/home/ruser/coursera_courses/gettingAndCleaningData/prog_assign_1/uci_har_dataset/train")
		# Loading the subjects into memory structures:
			train_who_per <- read.csv("subject_train.txt", sep = "", header = F)
		# Setting column name:
			colnames(train_who_per) <- "Subject"

		# Loading data of Activities performed by the subjects:
			train_act <- read.csv("y_train.txt", sep = "", header = F)
		# Setting column name:
			colnames(train_act) <- "PerformedActivities"

		# Loading Training data (which contains just numbers of all the stats gathered):
			train_dt <- read.csv("X_train.txt", sep = "", header = F)

	# 4th Step to Assign column names to the test and training data:
	setwd("/home/ruser/coursera_courses/gettingAndCleaningData/prog_assign_1/uci_har_dataset")
		# Loading the column names provided in the downloaded data set, into memory structure:
		col_names <- read.csv("features.txt", sep = "", header = F,colClasses = c("NULL",NA))
			# Trying to set the column names for the imported data, but found it very difficult
			# I read from the discussion forums that there is duplication in the column data.
			# so I found this piece of code which apparently removes the duplication.
			# with or without the following lines the command to assign column_names finally worked
				x <- matrix(unlist(col_names), ncol = 1)
				x <- make.names(x, unique = T, allow_ = T)
		# Just this one command it worked like a charm!!!!!!!
			colnames(test_dt) <- x
			colnames(train_dt) <- x

	# Just notes for me:
		# A sudden revelation, to bind columns of different sized data frames, use cbind.
		# and to bind rows you would: rbind :))))))) muhahahahahahahahahahahaha

	# 5th Step to find replace Activity values with names:
	# I think as per the assignment activities will have to be renamed:
	# Through the following 2 functions I am doing a find replace of the activity values with their respective text, as provided:
		x <- function() {
		  for (i in 1:nrow(test_act)){
		    for (j in 1:nrow(act_list)){
		      if ((test_act$PerformedActivities[[i]]) == (act_list$activityValue[[j]])){
			#I don't know yet, but I had to use the [[]] (double square brace) and as.vector
			# else this wouldn't happen
			test_act$PerformedActivities[[i]] <<- as.vector(act_list$activityName[[j]])
		      }
		    }
		  }
		}
		x()

		y <- function() {
		  for (i in 1:nrow(train_act)){
		    for (j in 1:nrow(act_list)){
		      if ((train_act$PerformedActivities[[i]]) == (act_list$activityValue[[j]])){
			#I don't know yet, but I had to use the [[]] (double square brace) and as.vector
			# else this wouldn't happen
			train_act$PerformedActivities[[i]] <<- as.vector(act_list$activityName[[j]])
		      }
		    }
		  }
		}
		y()

	#Real work begins now:
	# 6th step: to cbind the different data structures and put them all together:
		# 1. I will have to bind the activity to the data dataset:
			test_cbind1 <- cbind(test_act, test_dt)
			test_cbind1 <- cbind(test_who_per, test_cbind1)

			train_cbind1 <- cbind(train_act, train_dt)
			train_cbind1 <- cbind(train_who_per, train_cbind1)

			rb <- rbind(test_cbind1, train_cbind1)
			xtract <- rb[, 1:8]
			xtract <- tbl_df(xtract)

		# Grouping the data into subject + PerformedActivities:
			by_subject <- group_by(xtract, Subject, PerformedActivities)

		# Gathering the mean values as suggested in the assignment:
		tidied_data_set <- summarise_each(by_subject, funs(mean))

	setwd("/home/ruser/coursera_courses/gettingAndCleaningData/prog_assign_1/uci_har_dataset")
		# About to write a csv file to hard disk which will contain the Tidied data :))
		write.csv(tidied_data_set, file = "tidy_data.csv")


#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#
#								                                                     #
#                       Finished Assignment			                     #
#								                                                     #
#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#
