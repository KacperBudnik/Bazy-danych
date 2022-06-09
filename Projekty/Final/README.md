# Spis użytych technologii.
- Julia
    - MySQL
    - XLSX
    - Distributions
    - StatsBase
    - Dates
    - Random
- TeX Live
- Język programowania R wraz z pakietami
    - knitr
    - RMariaDB
    - DBI
    - lubridate
    - tidyverse
- GNU Make
- Powłoka POSIX
- ERD Editor

# Lista plików i ich zależności.
- README.md 
    - dokumentacja projektu
- main.RTEX
    - kod źródłowy raportu
- gen.jl
    -tworzenie oraz uzupełnianie bazy danych w języku programowania Julia
- diagram_erd.vuerd.json
    - diagram ERD
- 8_-_WYKAZ_IMION_MĘSKICH_OSÓB_ŻYJĄCYCH_WG_POLA_IMIĘ_PIERWSZE_WYSTĘPUJĄCYCH_W_REJESTRZE_PESEL_BEZ_ZGONÓW.XLSX     
- NAZWISKA_MĘSKIE-OSOBY_ŻYJĄCE_oAcmDus.XLSX
- Makefile
    - kod programu make do zbudowania projektu
- knitr
    - skrypt R inicjalizujący funkcję knit z pakietu knitr

# Kolejność i sposób uruchamiania plików, aby uzyskać gotowy projekt
- W korzeniu drzewa projektu, uruchom następujące polecenie:
    ``` sh
    make
    ```
# Schemat projektu bazy danych
- uruchom plik diagram_erd.vuerd.json w Visual Studio Code

# Dla każdej relacji listę zależności funkcyjnych z wyjaśnieniem
- personal_data
    - id -> first_name, last_name, birth_date, address_id,salary
    - id jest unikatowe, a pozostałe wiersze w kolumnach mogą się powtarzać
- employees
    - id -> personal_data_id, function
    - personal_data_id -> id, function
    - id oraz personal_data_id są unikatowe (każdy pracownik ma tylko jedne dane personalne)
    - wiersze w kolumnie function mogą się powtarzać
- players
    - id -> personal_data_id, team_id, joining_date, active
    - personal_data_id -> id, team_id, joining_date, active
    - id oraz personal_data_id są unikatowe (każdy gracz ma tylko jedne dane personalne)
    - wiersze w kolumnach team_id, joining_date, active mogą się powtarzać
- participation
    - id -> player_id, game_id
    - id jest unikatowe
    - wiersze w kolumnach player_id oraz game_id mogą się powtarzać
- addresses
    - id -> address, city
    - id jest unikatowe
    - wiersze w kolumnach city oraz address mogą się powtarzać (w dwóch miastach może być ta sama ulica)
- games
    - id -> our_team_id, enemy_team_id, rank, results, date, address_id
    - id jest unikatowe
    - wiersze w kolumnach our_team_id, enemy_team_id, rank, results, address_id mogą się powtarzać
- teams
    - id -> club_name, section
    - id jest unikatowe
    - wiersze w kolumnach club_name oraz section mogą się powtarzać
- customers
    - id -> phone_number, pesel
    - id jest unikatowe
    - wiersze w kolumnach phone_number oraz pesel mogą się powtarzać (Z historii wynika, że zdarzały się takie przypadki, że dwie osoby miały dokładnie taki sam numer PESEL przez błąd w systemie.)
- rental 
    - id -> rental_date, return_date, days, customer_id, quantity, equipment_id
    - id jest unikatowe, a pozostałe wiersze w kolumnach mogą się powtarzać
- equipment 
    - id -> kind, quantity, price_per_day, brand, target_group
    - id jest unikatowe, a pozostałe wiersze w kolumnach mogą się powtarzać

# Związki między relacjami
- relacja jeden do jednego między personal_data i employees
    - żaden z pracowników nie może mieć wielu danych personalnych
    - dane personalne mogą być przypisane tylko dla jednego pracownika
- relacja jeden do jednego między personal_data i players
    - żaden z graczy nie może mieć wielu danych personalnych
    - dane personalne mogą być przypisane tylko dla jednego gracza
- relacja jeden do wielu między addresses i personal_data
    - jeden adres może być przypisany do wielu danych personalnych,
    np. dwie osoby mieszkają w tym samym miejscu
    - każde dane personalne muszą mieć przypisany jeden adres.
- relacja jeden do wielu między addresses i games
    - każdy mecz musi mieć przypisany adres
    - jeden adres może być przypisany do wielu gier, np. jest 
    turniej który odbywa się pod danym adresem i tam się rozgrywa n gier
- relacja jeden do wielu między teams i games (występują tutaj 
dokładnie dwie takie relacje)
    - jedna drużyna może rozegrać wiele gier
    - gra może być rozegrana przez jedną drużynę (teoretycznie
    może być rozegrana przez dwie drużyny, ale tutaj występują dwa 
    klucze zewnętrzne our_team_id oraz enemy_team_id)
- relacja jeden do wielu między teams i players
    - jeden gracz może być przypisany tylko do jednej drużyny 
    - jedna drużyna może być przypisana do wielu graczy
- relacja jeden do wielu między players i participation
    - jeden gracz może uczestniczyć w wielu grach
    - uczestnictwo gracza w danej grze może być tylko jedno
- relacja jeden do wielu między games i participation
    - w jednej grze może potwierdzić obecność wielu graczy
    - potwierdzenie obecności dotyczy tylko jednej gry
- relacja jeden do wielu między rental i equipment 
    - jeden sprzęt może zostać wypożyczony przez wiele osób
    - wypożyczenie musi dotyczyć jednego sprzętu
- relacja jeden do wielu między customers i rental
    - jeden klient może dokonać wielu wypożyczeń
    - wypożyczenie musi być przypisane do jednego klienta

# Uzasadnienie, że baza jest w EKNF
Baza jest EKNF, ponieważ spełnia wszystkie 4 postacie normalne bazy
danych. 
- Pierwsza postać normalna jest spełniona, ponieważ w tabelach: 
    - nie ma grup powtarzających się informacji
    - znaczenie danych nie zależy od kolejności wierszy
    - każda kolumna jest wartością skalarną
    - każda tabela ma klucz główny
- Druga postać normalna jest spełniona, ponieważ:
    - pierwsza postać normalna jest spełniona
    - każda tabela przechowuje dane dotyczące tylko konkretnej klasy obiektów
- Trzecia postać normalna jest spełniona, ponieważ:
    - druga postać normalna jest spełniona
    - kolumna informacyjna nie należąca do klucza nie zależy też
    od innej kolumny informacyjnej
- Czwarta postać normalna jest spełniona, ponieważ:
    - trzecia postać normalna jest spełniona
    - tabele nie zawierają zależności wielowartościowych

# Opis, co było najtrudniejsze podczas realizacji projektu
- stworzenie schematu bazy danych
- normalizacja bazy danych
- uzyskanie precyzyjnych informacji na temat curlingu (KTO WPADŁ NA TAKI SUPER POMYSŁ?)