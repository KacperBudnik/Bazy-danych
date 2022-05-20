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

using DataFrames

DataFrame(response)



















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