#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#
#								                                                     #
#                       Project Assignment			                     #
#								              codeBook                               #
#								                                                     #
#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#

	# I have chosen to load the activity list first into a data.frame
	# variables used:
	  # act_list to hold the contents of activity_labels.txt
	  # test_who_per is a variable I have used to hold data from subject_test.txt
	    # Chose to set a name for both the above variables for the data that there is in them.
	      # activityValue, activityName
	      # PerformedActivities
		# Loading TEST data (which contains just numbers of all the stats gathered) into test_dt; file_name X_test.txt

		# Loading the subjects of Training into train_who_per
		# Setting column name as "Subject"
		# Loading data of Activities performed by the subjects of Training into train_act
		# Setting column name as PerformedActivities
		# Loading Training data (which contains just numbers of all the stats gathered) into train_dt

	  # Assign column names to the test and training data
		# Loading the column names provided in the downloaded data set, into memory structure into col_names; file_name: features.txt
			# I read from the discussion forums that there is duplication in the column data.
			# so I found a piece of code which apparently removes the duplication.
			# with or without the following lines the command to assign column_names finally worked
				x <- matrix(unlist(col_names), ncol = 1)
				x <- make.names(x, unique = T, allow_ = T)
		  # Just this one command it worked like a charm!!!!!!!
			  colnames(test_dt) <- x
			  colnames(train_dt) <- x

	# Next task would be to find replace Activity values with names:
	# I think as per the assignment activities will have to be renamed:
	# Used two functions 'x' and 'y' which would do the same, please refer to run_Analysis.R to view the same

	# Real work begins now
	# Cbind the different data structures and put them all together into variables test_cbind1 and train_cbind1
  # using variable xtract to hold the only columns as per the Assignment
	# Grouping the data into subject + PerformedActivities:
			by_subject <- group_by(xtract, Subject, PerformedActivities)
	# Gathering the mean values as suggested in the assignment:
		  tidied_data_set <- summarise_each(by_subject, funs(mean))
  # Finally wrote a csv file that contains just the required data into a file with name: tidy_data.csv


#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#
#								                                                     #
#                       Finished Assignment			                     #
#								                                                     #
#--------------------------///*** ***\\\-----------------------------#
#--------------------------///*** ***\\\-----------------------------#
