using MySQL
#using SQLite

conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="sakila")
#conn = mysql_connect("giniewicz.it", "student", "57u>3n7", "sakila")


query = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;
"""

#response = mysql_query(conn, query)
response=DBInterface.execute(conn,query)






























using MySQL
using DataFrames

conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="sakila")



query1 = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;
"""
response1=DBInterface.execute(conn,query1)
DataFrame(response1)


query2 = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;

SELECT title, rental_duration From film
WHERE rental_duration >4;
"""
response2=DBInterface.execute(conn,query2)
DataFrame(response2)



query3 = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;

SELECT title, rental_duration From film
WHERE rental_duration >4;
"""
response3=DBInterface.executemultiple(conn,query3)
DataFrame(response3)


a=Any[]
response3=DBInterface.executemultiple(conn,query3)
for i in response3
    push!(a,DataFrame(i))
end

a
a[1]
a[2]







#=
conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="sakila")
query = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;
"""
response=DBInterface.execute(conn,query)

for i in MySQLRowIterator(conn,query)
    println(i)
end
=#






















using MySQL

conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="piaskownica")


create="""CREATE OR REPLACE TEMPORARY TABLE test(
        id INT UNSIGNED AUTO_INCTEMENT PRIMARY KEY,
        user VARCHAR(40) COMMENT "name",
        plec ENUM("kobieta","mezczyzna") NOT NULL,
        "liczba zamowien" INT UNSIGNET NOT NULL DEFAULT 0
        )"""



create="""CREATE OR REPLACE TEMPORARY TABLE test (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user VARCHAR(40) ,
    plec ENUM("kobieta", "mezczyzna") NOT NULL,
    zamowienia INT UNSIGNED NOT NULL DEFAULT 0
    )
"""    



create="""CREATE OR REPLACE TEMPORARY TABLE test (
    id INT UNSIGNED,
    user VARCHAR(40) ,
    plec ENUM("kobieta", "mezczyzna") NOT NULL,
    zamowienia INT UNSIGNED NOT NULL DEFAULT 0
    )
"""    
response=DBInterface.execute(conn,create)


conn

Name=["Kamil", "Bartek", "Tomasz", "Zbigniew", "Marcin", "Kacper", "Patryk", "Marek", "Mariusz"]

query="""INSERT INTO test (id,user, plec, zamowienia) VALUES\n"""
for i in 1:10
    query*="""($i,"$(rand(Name))", "$(rand(["kobieta", "mezczyzna"]))",$(rand(1:10^4))),\n"""
end
query*="""(11,"$(rand(Name))", "$(rand(["kobieta", "mezczyzna"]))", $(rand(1:10^4)));"""

print(query)

response=DBInterface.execute(conn,query)



query="SELECT * FROM test;"

response=DBInterface.execute(conn,query)


using DataFrames

DataFrame(response)


d=ans


d[3]
d.plec
d[!, :plec]

propertynames(d)
size(d)

using Statistics
mean(d[:zamowienia])

#mapcols(zamowienia->sqrt.(zamowienia), d)
d.zamowienia


first(d,2)

last(d,1)


d

d[4:2:end, [:user, :plec, :id]]

d[4:6,:]

d[[1,2,5,9],:]

d[end:-1:1]

d[end:-1:1,:]


#select(d, :zamowienia, :id => maximum)

b=copy(d)

#transform(b, :zamowienia => maximum)
:c










































using MySQL



conn = DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="sakila") # create a connection to a specific database T; required parameters are database-specific

sql= """
SELECT title, rental_duration FROM film
WHERE rental_duration < 4;
"""

stmt = DBInterface.prepare(conn, sql) # prepare a sql statement against the connection; returns a statement object

results = DBInterface.execute(stmt) # execute a prepared statement; returns an iterator of rows (property-accessible & indexable)

rowid = DBInterface.lastrowid(results) # get the last row id of an INSERT statement, as supported by the database

# example of using a query resultset
for row in results
    #@show propertynames(row) # see possible column names of row results
    row.title # access the value of a column named `title`
    row[1] # access the first column in the row results
end



results.valuehelpers




using DataFrames

DataFrame(results)







































