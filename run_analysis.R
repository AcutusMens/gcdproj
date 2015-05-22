## GETTING AND CLEANING DATA ##
## COURSE PROJECT REQUIREMENT 1 AND 4##

library(data.table)
library(dplyr)

#READ DATA FILE, SUBJECT FILE, ACTIVITY FILE OF TRAIN SET

        dtdatatrain <- read.table("./gcdproj/train/X_train.txt")                
        dtsubjtrain <- read.table("./gcdproj/train/subject_train.txt")
        dtacttrain <- read.table("./gcdproj/train/y_train.txt")

#COMBINE INTO PT 1 OF COMPLETE DATASET AND CLEAN UP

        dtpt1 <- cbind(dtsubjtrain, dtacttrain, dtdatatrain)                            
        rm(dtsubjtrain, dtacttrain, dtdatatrain)

#READ DATA FILE, SUBJECT FILE, ACTIVITY FILE OF TEST SET

        dtdatatest <- read.table("./gcdproj/test/X_test.txt")
        dtsubjtest <- read.table("./gcdproj/test/subject_test.txt")
        dtacttest <- read.table("./gcdproj/test/y_test.txt")

#COMBINE INTO PT 2 OF COMPLETE DATASET AND CLEAN UP

        dtpt2 <- cbind(dtsubjtest, dtacttest, dtdatatest)
        rm(dtsubjtest, dtacttest, dtdatatest)

#COMBINE PT 1 AND 2, USE FEATURES FILE AS COLUMN NAMES (REQ #4), CLEAN UP

        dtfeats <- as.character((read.table("./gcdproj/features.txt"))$V2)
        dtfeats <- append(c("subject", "activity"), dtfeats)
        dtlist <- list(dtpt1, dtpt2)
        dataset <- rbindlist(dtlist)
        setnames(dataset, dtfeats)
        rm(dtfeats, dtpt1, dtpt2, dtlist)       

## COURSE PROJECT REQUIREMENT 2##

#LOOK THROUGH COLUMN NAMES AND EXTRACT INDEXES OF -MEAN() AND -STD() VARS ONLY
#ADD 1:2 AS INDEXES OF SUBJECT COLUMN AND ACTIVITY COLUMN TO KEEP THEM

        vars <- append(grep("mean[(][)]", colnames(dataset)), 
                       grep("std", colnames(dataset)))
        datasetselect <- select(dataset, append(1:2, vars))

## COURSE PROJECT REQUIREMENT 3##
#READ ACTIVITY LABELS FILE, LOOP THROUGH #S AND REPLACE WITH LABELS

        dtactnames <- (read.table("./gcdproj/activity_labels.txt"))
        for (i in 1:nrow(dtactnames)) { 
                datasetselect$activity <- gsub(dtactnames[i,1], tolower(dtactnames[i,2])
                                               , datasetselect$activity) }

## COURSE PROJECT REQUIREMENT 5##

        grpcols <- names(datasetselect)[1:2]
        dots <- lapply(grpcols, as.symbol)
        tidydataset <- datasetselect %>%
        group_by_(.dots=dots) %>%
        summarise_each(funs(mean)) %>%
        arrange(subject, activity)
        write.table(tidydataset, "tidydataset.txt", row.name=FALSE)
