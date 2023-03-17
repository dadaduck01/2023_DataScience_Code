library(RMySQL)
MySqlConnection = dbConnect(MySQL(),
                            user = 'root',
                            password = '123456',
                            dbname = 'demo',
                            host = 'localhost')
dbListTables(MySqlConnection)
SQLquery <- "select * from paper"
data_from_mysql = dbGetQuery(MySqlConnection, SQLquery)
print(dim(data_from_mysql))
summary(MySqlConnection)
paper <- read.csv("D:/RLanguage/RProject/2023_DataScience_Code/exercise3/paper.csv")
head(paper)
dbCreateTable(MySqlConnection,"paper",paper)
dbWriteTable(MySqlConnection,"paper",paper,row.names=FALSE,append=TRUE)
#-------------------------------------------------------------------------------------------
MySqlConnection = dbConnect(MySQL(),
                            user = 'root',
                            password = '123456',
                            dbname = 'demo',
                            host = 'localhost')

dbCreateTable(MySqlConnection,"paper",paper)
dbWriteTable(MySqlConnection,"paper",paper,row.names=FALSE,append=TRUE)

sql_sentence <- "SELECT * FROM paper WHERE st_title LIKE '%viruse%' OR st_abstract LIKE '%viruse%'"
viruse_data_paper <- dbGetQuery(MySqlConnection,sql_sentence)
dim(viruse_data_paper)

dbCreateTable(MySqlConnection,"viruse_data",viruse_data_paper)
dbWriteTable(MySqlConnection,"viruse_data",viruse_data_paper,row.names = FALSE,append = TRUE)
dbListTables(MySqlConnection)

dbRemoveTable(MySqlConnection,'paper')
dbRemoveTable(MySqlConnection,'viruse_data')
dbListTables(MySqlConnection)


dbDisconnect(MySqlConnection)
#----------------------------------------------------------------------------------------------
dbRemoveTable(MySqlConnection,'paper')
dbListTables(MySqlConnection)

dbDisconnect(MySqlConnection)
