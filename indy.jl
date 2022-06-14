# https://prezi.com/view/Miw7f7mSTuQtLDD4Y2WM/
using MySQL

conn=DBInterface.connect(
    MySQL.Connection, 
    "giniewicz.it", 
    "student",
     "57u>3n7",
     db="student")  



create="""CREATE OR REPLACE TEMPORARY TABLE equipment(
    id INT(3) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    quantity INT(10) NOT NULL,
    price_per_day DECIMAL(5,2) NOT NULL,
    producer VARCHAR(50),
    target_group ENUM('children', 'teeneger', 'adult')
);"""


DBInterface.execute(conn,create)


sql_add="""INSERT INTO equipment (name, quantity,price_per_day,producer,target_group) VALUES (?, ?, ?, ?, ?)"""


stm=DBInterface.prepare(conn, sql_add)

val=["Kij", 90, 45, "Kij s.a","teeneger" ]

DBInterface.execute(stm,val)


sql="Select * From equipment;"

results=DBInterface.execute(conn,sql)

for i in results
    println(i)
end

val=["Kamien", 10, 180, "kamien z.o.o.","teeneger" ]

DBInterface.execute(stm,val)

results=DBInterface.execute(conn,sql)

for i in results
    println(i)
end


it=10:1.:20
iterate(it)

iterate(it,1)
iterate(it,3)
iterate(it,90)
iterate(it,90)==nothing



for i in results
    println(i)
end

results=DBInterface.execute(conn,sql)

iterate(results,9090)




results=DBInterface.execute(conn,sql)
for i in results
    println(i)
end

results=DBInterface.execute(conn,sql)
for i in results
    println(i[5])
end

results=DBInterface.execute(conn,sql)
for i in results
    println(i[:producer])
end





















using DataFrames, MySQL
conn=DBInterface.connect(MySQL.Connection,
    "giniewicz.it", "student", "57u>3n7", db="sakila")
sql="SELECT title, length FROM film
    WHERE length <98
    Limit 30"
response=DBInterface.execute(conn,sql)
data=DataFrame(response)

data
data[!,1]
data[!,1:2]
data[!,:title]
data[1:3,:]
data[
    [4,5,12,28],
    :length
    ]
Int.(ans) #  zapis 16





#mapcols(zamowienia->sqrt.(zamowienia), d)
#select(d, :zamowienia, :id => maximum)
#transform(b, :zamowienia => maximum)

























































using MySQL
#using SQLite

conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "student", "57u>3n7", db="sakila")
#conn = mysql_connect("giniewicz.it", "student", "57u>3n7", "sakila")


query = """
SELECT title, rental_duration FROM film
WHERE rental_duration < 5;
"""

#response = mysql_query(conn, query)
response=DBInterface.execute(conn,query)

for i in response
    show(i)
end

using DataFrames

DataFrame(response)



a=1:4
iterate(response)


b=iterate(response)



Int(b[1][2])

next(response)


con = mysql_connect("giniewicz.it", "student", "57u>3n7", db="sakila")





MySQL
DBInterface
JDBC
ODBC
SQLite
DBDSQLite
DBPerf
MySQLBuilder
SQLiteBuilder2
SQLiteBuilder
Accumulo
DBAPI
Roadmap
Hive
PostgreSQL
ClickHouse
Redis























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


using DataFrames, MySQL
conn=DBInterface.connect(MySQL.Connection,
    "giniewicz.it", "student", "57u>3n7", db="sakila")
sql="SELECT title, length FROM film
    WHERE length <98
    Limit 30"
response=DBInterface.execute(conn,sql)
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