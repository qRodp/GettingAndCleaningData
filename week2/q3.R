unique(acs$AGEP)
sqldf("select AGEP where unique from acs")
sqldf("select unique * from acs")
sqldf("select distinct pwgtp1 from acs")
sqldf("select distinct AGEP from acs") #OK
