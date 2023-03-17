library(RMySQL)
MySqlConnection = dbConnect(MySQL(),
                            user = 'root',
                            password = '123456',
                            dbname = 'demo',
                            host = 'localhost')
dbListTables(MySqlConnection)