using MySQL
using SQLite

conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="sakila")
#conn = mysql_connect("giniewicz.it", "student", "57u>3n7", "sakila")


query = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;
"""

#response = mysql_query(conn, query)
response=DBInterface.execute(conn,query)

using DataFrames

DataFrame(response)
