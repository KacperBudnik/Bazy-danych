using MySQL
using XLSX
using Distributions
using StatsBase
using Dates
using Random

cd("D:\\GitHub\\Bazy-danych\\Projekty")
 ############################### Dane ###############################
    # Tworzenie wektorów
    begin
        players=[
            Int[], # id
            Int[], # personal_data_id
            Int[], # team_id
            Date[], # joinng_date
            Bool[] # active
        ]

        personal_data=[
            Int[], # id
            String[], # first_name
            String[], # last_name
            Date[], # birth_date
            Int[], # address_id
            Float64[] # salary
        ]

        employees=[
            Int[], # id
            Int[], # personal_data_id
            String[] # Function
        ]

        addresses=[
            Int[], # id
            String[], # adress
            String[] # city
        ]

        meetings=[
            Int[], # id
            Int[], # our_team_id
            Int[], # other_team_id
            Int[], # address_id
            Date[] # date
        ]

        teams=[
            Int[], # id
            String[], # club_name
            String[] # Section
        ]

        games=[
            Int[], # id
            Int[], # winning_team_id
            Int[], # lost_team_id
            Date[], # date
            String[], # rank
        ]

        participation=[
            Int[], # id
            Int[], # players_id
            Int[] # game_id
        ]

        customers=[
            Int[], # id
            Int[], # phone_number
            Int[] # pesel
        ]

        rental=[
            Int[], # id
            Date[], # rental_date
            Date[], # return_date
            Int[], # customer_id
            Int[], # days
            Int[], # equipment_id
            Int[] # quatity
        ]

        equipment=[
            Int[], # id
            String[], # name
            Int[], # quantity
            Float64[], # price_per_day
            String[], # producer
            String[], # target_group
            Int[] # quantity
        ]
    end

    # Dane do uzupełniania
    begin 
        begin # imiona
            name=[
                String[], # imie
                Int[] # liczba wystąpień
            ]

            file=XLSX.readxlsx("8_-_WYKAZ_IMION_MĘSKICH_OSÓB_ŻYJĄCYCH_WG_POLA_IMIĘ_PIERWSZE_WYSTĘPUJĄCYCH_W_REJESTRZE_PESEL_BEZ_ZGONÓW.XLSX")[1]
            name[1]=string.(file["A:A"][2:end])
            name[2]=Int.(file["C:C"][2:end])
            #name=hcat(name[1],name[2]);
            #size(name[1])==size(name[2])
        end

        begin # nazwiska
            surname=[
                String[], # imie
                Int[] # liczba wystąpień
            ]

            file=XLSX.readxlsx("NAZWISKA_MĘSKIE-OSOBY_ŻYJĄCE_oAcmDus.XLSX")[1]
            surname[1]=string.(file["A:A"][2:end])
            surname[2]=Int.(file["B:B"][2:end])
            #surname=hcat(surname[1],surname[2]);
            #size(name[1])==size(name[2])
        end


        rand_name()=sample(name[1], Weights(name[2]))
        rand_surname()=sample(surname[1],Weights(surname[2]))


        # hale curlingowe
        halls=[ 
            "Łódź" "Śnieżna 10" 15;
            "Giżycko" "Królowej Jadwigi 7D" 9;
            "Bełchatów" "Czapliniecka 96" 3;
            "Pawłowice" "Sportowa 14" 2;
            "Świdnica" "Śląska 35b" 1;
            "Katowice" "Nałkowskiej 11" 1;
            "Gliwice" "Akademicka 29" 1
        ]


        rank=[ # rank
            "tournament"
            #"provincial", 
            #"domestic",
            #"divisional", 
            "friendly"
        ]


        section=[ # sekcjie
            "junior", 
            "senior"
        ]

        target=[ # target group 
            "children",
            "teeneger",
            "adult"
        ]

        functions=[
            "CEO"
            "Junior coach"
            "Senior coach"
            "Seller"
            "IT"
            "Instructor"
            "Cleaner"
            "Receptoinist"
            "Psychologist / Medic"
        ]


        city=[ #miasta człowieków
            "Wrocław" 13
            "Warszawa" 9
            "Łódź" 20
            "Katowice" 5
            "Kraków" 9
            "Poznań" 3
            "Bydgoszcz" 2
            "Gdynia" 1
            "Częstochowa" 2
        ]

        street=[ #ulice człowieków
            "Polna"
            "Leśna"
            "Słoneczna"
            "Krótka"
            "Szkolna"
            "Ogrodowa"
            "Lipowa"
            "Łąkowa"
            "Brzozowa"
            "Kwiatowa"
            "Fabryczna"
            "Ślepa"
            "Porebska"
            "Aleja Chopina"
            "Aleja Litewska"
            "Aleja Małopolska"
            "Aleja Okrężna"
            "Aleja Szelągowska"
            "Ciasna"
            "Cytadela"
            "Czartoryja" 
            "Zwierzyniecka"
            "Wielkie Garbary"
            "Rybaki"
            "Dąbrowskiego" 
            "Topolowa"
            "Łukasiewicza"
            "Kujawska"
            "Dolina Św.-Jańska"
            "Przebieg"
            "Kraszewskiego"
            "Langiewicza"
            "Harcerska"
            "Małeckiego"
            "Mostowa"
            "Droga Dębińska"
            "Łączny Młyn"
            "Komandorja"
            "Grudzieniec"
            "Kopernika"
            "Piotrowo"
            "1 Maja"
            "10 Zakładników"
            "3 Maja"
            "7 Kamienic"
            "Adama Asnyka"
            "Adama Bienia"
            "Adama Mickiewicza"
            "Adama Naruszewicza"
            "Adama Próchnika"
            "Admiralska"
            "Adriana Głębockiego"
            "Akacjowa"
            "Akademicka"
            "Alberta Einsteina"
            "Aleksandra Czekanowskiego"
            "Aleksandra Fredry"
            "Aleksandra Gierymskiego"
            "Aleksandra Kamińskiego"
            "Aleksandra Szymona Grabary"
            "Aleksandra Zelwerowicza"
            "Aluminiowa"
            "Ambulatoryjna"
            "Amonitowa"
            "Andrzeja Struga"
            "Andrzeja Towiańskiego"
            "Aniołowska"
            "Anny Walentynowicz"
            "Antoniego Fertnera"
            "Antoniego i Władysława Krzemińskich"
            "Antoniego Słonimskiego"
            "Anyżkowa"
            "Arrasowa"
            "Artura Grottgera"
            "Artura Oppmana Or-Ota"
            "Artyleryjska"
            "Astronautów"
            "Augustowska"
            "Azaliowa"
            "Babia"
            "Bagienna"
            "Bajeczna"
            "Bakaliowa"
            "Balladyny"
            "Balonowa"
            "Bałtycka"
            "Bartnicza"
            "Bartosza Głowackiego"
            "Barwna"
            "Baśniowa"
            "Batalionów Chłopskich"
            "Bażantowa"
            "Bełchatowska"
            "Benedykta Dybowskiego"
            "Berka Joselewicza"
            "Bernarda Ludwika Hantkego"
            "Beskidzka"
            "Będzińska"
            "Bialska"
            "Biała"
            "Białostocka"
            "Białowieska"
            "Bieszczadzka"
            "Biskupa Teodora Kubiny"
            "Biurowa"
            "Biwakowa"
            "Blachowieńska"
            "Blaise Pascala"
            "Bliska"
            "bł. Jolanty"
            "bł. Salomei"
            "Bławatkowa"
            "Błotna"
            "Bocheńska"
            "Bociania"
            "Boczna"
            "Bohaterów Katynia"
            "Bohaterska"
            "Bohuna"
            "Bolesława Chrobrego"
            "Bolesława Leśmiana"
            "Bolesława Limanowskiego"
            "Bolesława Micińskiego"
            "Bolesława Prusa"
            "Bony Sforzy"
            "Borówkowa"
            "Botaniczna"
            "Bór"
            "Bratkowa"
            "Bratnia"
            "Broni"
            "Bronisława Czecha"
            "Bronisława Hubermana"
            "Bronisława Idzikowskiego"
            "Bruno Schulza"
            "Brzegowa"
            "Brzezińska"
            "Brzeźnicka"
            "Brzozowa"
            "Brzyszowska"
            "Budowlanych"
            "Bugaj"
            "Bugajska"
            "Bukowa"
            "Bursztynowa"
            "Busolowa"
            "Bydgoska"
            "Bystra"
            "Bytomska"
            "Cedrowa"
            "Cegielniana"
            "Ceglana"
            "Ceramiczna"
            "Chabrowa"
            "Chęcińska"
            "Chłodna"
            "Chłopska"
            "Chmielna"
            "Chochołowska"
            "Chorzowska"
            "Ciasna"
            "Cicha"
            "Ciechanowska"
            "Cienista"
            "Ciepła"
            "Cieszyńska"
            "Cisowa"
            "Cmentarna"
            "Cypriana Godebskiego"
            "Cypriana Kamila Norwida"
            "Cyprysowa"
            "Cyrklowa"
            "Czeremchowa"
            "Czereśniowa"
            "Czesława Miłosza"
            "Częstocha"
            "Czołgistów"
            "Czwartaków"
            "Czysta"
            "Daniela Chodowieckiego"
            "Danusi"
            "Dawna"
            "Dąbrówki"
            "Dedala"
            "Dekabrystów"
            "Deszczowa"
            "Dębowa"
            "Diamentowa"
            "Długa"
            "Dobra"
            "Dobrzyńska"
            "Dojazdowa"
            "Dolna"
            "Dominika Zbierskiego"
            "Dowódców"
            "dra Ludwika Zamenhofa"
            "dra Tytusa Chałubińskiego"
            "dra Witolda Orłowskiego"
            "Drogowców"
            "Drozdowa"
            "Druciana"
            "Drzewna"
            "Dusznicka"
            "Dymitra Mendelejewa"
            "Działowa"
            "Dzielna"
            "Dzika"
            "Dźbowska"
            "Edwarda Mąkoszy"
            "Edwarda Reszkego"
            "Ekonomiczna"
            "Elbląska"
            "Elektryków"
            "Elizy Orzeszkowej"
            "Emila Zegadłowicza"
            "Emilii Plater"
            "Energetyków"
            "Eugeniusza Kwiatkowskiego"
            "Eugeniusza Romera"
            "Eugeniusza Seifrieda"
            "Eugeniusza Żychlińskiego"
            "Ewy"
            "Fajansowa"
            "Falista"
            "Feliksa Nowowiejskiego"
            "Feliksa Perla"
            "Festynowa"
            "Filomatów"
            "Filtrowa"
            "Fiodora Dostojewskiego"
            "Fiołkowa"
            "Flisacka"
            "Forteczna"
            "Franciszka Dionizego Wilkoszewskiego"
            "Franciszka Karpińskiego"
            "Franciszka Żmurki"
            "Franciszka Żwirki i Stanisława Wigury"
            "Fromborska"
            "Fryderyka Chopina"
            "Gabrieli Zapolskiej"
            "Gajowa"
            "Galla Anonima"
            "Garbarska"
            "Garncarska"
            "Garwolińska"
            "Gazowa"
            "Gdańska"
            "Gdyńska"
            "gen. Antoniego Madalińskiego"
            "gen. Augusta Fieldorfa-Nila"
            "gen. bryg. Janusza Gąsiorowskiego"
            "gen. Franciszka Kleeberga"
            "gen. Henryka Dembińskiego"
            "gen. Ignacego Prądzyńskiego"
            "gen. Jakuba Jasińskiego"
            "gen. Jana Henryka Dąbrowskiego"
            "gen. Jana Skrzyneckiego"
            "gen. Józefa Bema"
            "gen. Józefa Chłopickiego"
            "gen. Józefa Hallera"
            "gen. Józefa Sowińskiego"
            "gen. Józefa Zajączka"
            "gen. Karola Kniaziewicza"
            "gen. Kazimierza Pułaskiego"
            "gen. Kazimierza Sosnkowskiego"
            "gen. Leopolda Okulickiego"
            "gen. Michała Tokarzewskiego-Karaszewicza"
            "gen. Mieczysława Dąbkowskiego"
            "gen. Romualda Traugutta"
            "gen. Stanisława Maczka"
            "gen. Stanisława Sosabowskiego"
            "gen. Tadeusza Komorowskiego-Bora"
            "gen. Tadeusza Kutrzeby"
            "gen. Wilhelma Orlik-Rückemanna"
            "gen. Władysława Andersa"
            "gen. Władysława Sikorskiego"
            "Geodetów"
            "Gerberowa"
            "Gerwazego"
            "Gęsia"
            "Gilowa"
            "Giuseppe Garibaldiego"
            "Giżycka"
            "Glebowa"
            "Glinowa"
            "Gliwicka"
            "Gładka"
            "Głęboka"
            "Głogowa"
            "Główna"
            "Gminna"
            "Gnaszyńska"
            "Gnieźnieńska"
            "Goplany"
            "Gorzowska"
            "Gościnna"
            "Goździków"
            "Górki"
            "Górna"
            "Górników"
            "Górnośląska"
            "Górska"
            "Grafików"
            "Graniczna"
            "Granitowa"
            "Grażyny"
            "Grażyny Bacewicz"
            "Grenadierów"
            "Grobla"
            "Gronowa"
            "Gruntowa"
            "Grunwaldzka"
            "Gruszowa"
            "Grzybowska"
            "Guglielmo Marconiego"
            "Gustawa Grackiego"
            "Gustawa Orlicz-Dreszera"
            "Gwardzistów"
            "Gwiezdna"
            "Gwintowa"
            "Haliny Poświatowskiej"
            "Hanny Malewskiej"
            "Hansa Christiana Andersena"
            "Harcerska"
            "Harfowa"
            "Hektarowa"
            "Heleny"
            "Helska"
            "Henryka Barona"
            "Henryka Jordana"
            "Henryka Rodakowskiego"
            "Henryka Siemiradzkiego"
            "Henryka Wieniawskiego"
            "Henryki"
            "Heraklesa"
            "Herbaciana"
            "Herbska"
            "hetm. Jana Karola Chodkiewicza"
            "hetm. Jana Tarnowskiego"
            "hetm. Jana Zamoyskiego"
            "hetm. Stefana Czarnieckiego"
            "hetm. Stefana Żółkiewskiego"
            "Hetmańska"
            "Hiacyntowa"
            "Hodowlana"
            "Horeszków"
            "Hoża"
            "Huculska"
            "Husarska"
            "Hutników"
            "Iglasta"
            "Ignacego Kozielewskiego"
            "Ignacego Łukasiewicza"
            "Ignacego Mościckiego"
            "Ignacego Paderewskiego"
            "Ikara"
            "Iławska"
            "Imbirowa"
            "Inowrocławska"
            "Inspektowa"
            "Inwalidów Wojennych"
            "Inżynieryjna"
            "Ireny Kosmowskiej"
            "Irydowa"
            "Irysowa"
            "Jabłonowa"
            "Jachtowa"
            "Jacka Kaczmarskiego"
            "Jacka Kuronia"
            "Jacka Malczewskiego"
            "Jagiellońska"
            "Jagienki"
            "Jagodowa"
            "Jałowcowa"
            "Jana Andrzeja Morsztyna"
            "Jana Brzechwy"
            "Jana Dzierżonia"
            "Jana Gutenberga"
            "Jana i Jędrzeja Śniadeckich"
            "Jana III Sobieskiego"
            "Jana Karłowicza"
            "Jana Karskiego"
            "Jana Kasprowicza"
            "Jana Kiepury"
            "Jana Kilińskiego"
            "Jana Kochanowskiego"
            "Jana Lechonia"
            "Jana Matejki"
            "Jana Nowaka-Jeziorańskiego"
            "Jana Olbrachta"
            "Jana Parandowskiego"
            "Jana Pietrusińskiego"
            "Jana Stanisława Jankowskiego"
            "Janiny Porazińskiej"
            "Jankiela"
            "Jantarowa"
            "Janusza Korczaka"
            "Janusza Kusocińskiego"
            "Jarosława Iwaszkiewicza"
            "Jarosławska"
            "Jarzębinowa"
            "Jaskółcza"
            "Jaskrowska"
            "Jasna"
            "Jasnogórska"
            "Jastrzębia"
            "Jaworowa"
            "Jazzowa"
            "Jeleniogórska"
            "Jemiołowa"
            "Jerzego Dudy-Gracza"
            "Jerzego Kukuczki"
            "Jerzego Lieberta"
            "Jerzego Szajnowicza-Iwanowa"
            "Jerzego Szaniawskiego"
            "Jerzego Waszyngtona"
            "Jesienna"
            "Jezioran"
            "Jeżynowa"
            "Jęczmienna"
            "Jędrzejowska"
            "Joachima Lelewela"
            "Jowiszowa"
            "Józefa Brandta"
            "Józefa Chełmońskiego"
            "Józefa Conrada-Korzeniowskiego"
            "Józefa Czapskiego"
            "Józefa Czechowicza"
            "Józefa Gaczkowskiego"
            "Józefa Ignacego Kraszewskiego"
            "Józefa Lompy"
            "Józefa Maksymiliana Ossolińskiego"
            "Józefa Marii Hoene-Wrońskiego"
            "Józefa Mehoffera"
            "Józefa Mireckiego"
            "Józefa Pankiewicza"
            "Józefa Parczyńskiego"
            "Józefa Sułkowskiego"
            "Józefa Wójcickiego"
            "Józefa Wybickiego"
            "Juliana Fałata"
            "Juliana Kalinki"
            "Juliana Krzyżanowskiego"
            "Juliana Tuwima"
            "Juliana Ursyna Niemcewicza"
            "Juliusza Osterwy"
            "Juliusza Słowackiego"
            "Junacka"
            "Jurajska"
            "Juranda"
            "Jutowa"
            "Kaczorowska"
            "Kadetów"
            "Kajakowa"
            "Kalinowa"
            "Kaliska"
            "Kamienna"
            "Kanał Kohna"
            "Kanonierów"
            "Kaprys"
            "Kapucyńska"
            "Kardynała Stefana Wyszyńskiego"
            "Karkonoska"
            "Karola Dickensa"
            "Karola Irzykowskiego"
            "Karola Miarki"
            "Karola Szajnochy"
            "Karola Szymanowskiego"
            "Karpacka"
            "Kartuska"
            "Kasztanowa"
            "Kaszubska"
            "Katedralna"
            "Kawalerzystów"
            "Kawia"
            "Kawodrzańska"
            "Kazimiery Iłłakowiczówny"
            "Kazimierza Knauera"
            "Kazimierza Przerwy-Tetmajera"
            "Kazimierza Pużaka"
            "Kazimierza Wielkiego"
            "Kazimierza Wierzyńskiego"
            "Kącik"
            "Kąkolowa"
            "Kątna"
            "Ketlinga"
            "Kędzierzyńska"
            "Kiedrzyńska"
            "Kielecka"
            "Klasztorna"
            "Klonowa"
            "Kluczborska"
            "Kłobucka"
            "Kłodzka"
            "Kłomnicka"
            "Kmicica"
            "Koksowa"
            "Kolarska"
            "Kolejowa"
            "Kolorowa"
            "Kołobrzeska"
            "Komandorska"
            "Komandosów"
            "Komornicka"
            "Koniecpolska"
            "Konińska"
            "Konstantego Ildefonsa Gałczyńskiego"
            "Konstruktorów"
            "Konwaliowa"
            "Kopalniana"
            "Kopcowa"
            "Korkowa"
            "Kornela Makuszyńskiego"
            "Korzenna"
            "Kosiarzy"
            "Kosmiczna"
            "Kosów"
            "Kosynierska"
            "Koszalińska"
            "Koszarowa"
            "Koszykowa"
            "Kościelna"
            "Kozia"
            "kpt. Jerzego Kurpińskiego-Ponurego"
            "kpt. Leona Sabatowskiego"
            "kpt. Stanisława Sojczyńskiego-Warszyca"
            "Krakowska"
            "Krańcowa"
            "Krasińskiego"
            "Kredowa"
            "Kresowa"
            "Kręta"
            "Krokusowa"
            "Krośnieńska"
            "Królewska"
            "Krótka"
            "Krucza"
            "Kruszwicka"
            "Krynicka"
            "Krystyny"
            "Krzemienna"
            "Krzepicka"
            "Krzysi"
            "Krzysztofa Kamila Baczyńskiego"
            "ks. Biskupa Franciszka Musiela"
            "ks. Bonawentury Metlera"
            "ks. Hugona Kołłątaja"
            "ks. Ignacego Skorupki"
            "ks. Jana Długosza"
            "ks. Jerzego Popiełuszki"
            "ks. Józefa Tischnera"
            "ks. Piotra Skargi"
            "ks. Piotra Ściegiennego"
            "ks. Stanisława Brzóski"
            "ks. Stanisława Grochowskiego"
            "ks. Stanisława Konarskiego"
            "ks. Stanisława Staszica"
            "Księcia Adama Jerzego Czartoryskiego"
            "Księcia Jeremiego Wiśniowieckiego"
            "Księcia Józefa Poniatowskiego"
            "Księcia Leszka Białego"
            "Księdza Wróblewskiego"
            "Księżycowa"
            "Kucelin Łąki"
            "Kucelińska"
            "Kujawska"
            "Kusięcka"
            "Kutnowska"
            "Kwatermistrzów"
            "Kwiatowa"
            "Lakowa"
            "Laurowa"
            "Lawendowa"
            "Lazurowa"
            "Lednicka"
            "Legendy"
            "Legionów"
            "Legnicka"
            "Leona Schillera"
            "Leona Wyczółkowskiego"
            "Leonida Teligi"
            "Leopolda Staffa"
            "Leszczynowa"
            "Leśna"
            "Letnia"
            "Letniskowa"
            "Ligii"
            "Liliowa"
            "Limanowska"
            "Limbowa"
            "Lipowa"
            "Lirowa"
            "Lisia"
            "Listonoszy"
            "Litewska"
            "Lniana"
            "Lodowa"
        ]

        producer=[ # producenci sprzętu
            "goldcurling"
            "balanceplus"
            "Olson"
            "asham"
            "hardline"
        ]

        rand_tournament_date(year)=rand()<3/4 ? rand(Date(year,8,26):Day(1):Date(year,12,3)) : rand(Date(year+1,2,2):Day(1):Date(year+1,3,14))
        rand_join_date(year)=rand(Date(year,3,14):Day(1):Date(year,4,16))
        rand_birthdate_junior(year)=rand(Date(year-19):Day(1):Date(year-16))
        rand_birthdate_senior(year)=rand(Date(year-35):Day(1):Date(year-20))
        rand_friendly_date(year)=rand()<3/4 ? rand(Date(year,4,29):Day(1):Date(year,8,3)) : rand(Date(year,12,8):Day(1):Date(year+1,1,26))


        team_names=[ #nazwy drużyn
            "Curling Masters"
            "Media Team"
            "Masters of Curling"
            "Curling Chempions"
            "Chempions of Curling"
            "Pantheras"
            "Thompson"
            "Archbishop"
            "Mater Dei"
            "Dutch Fork"
            "Bryant"
            "DeSoto"
            "Highland Park"
            "Hoover"
            "Cedar Park"
            "Westlake"
            "Grayson"
            "IMG Academy"
            "St. Josephs Prep"
            "North Shore"
            "Venice"
            "Oxford"
            "Cherry Creek"
            "Lone Peak"
            "Rockledge"
            "Cocoa"
            "Niceville"
            "Pulaski Academy"
            "Owasso"
            "Oak Grove"
        ]
    

        items=[
            "Brooms"
            "Stones"
            "Shoes"
            "Gloves"
            "Stop watch"
        ]

        items_price=[
            19.99
            29.99
            14.99
            5.20
            1.50
        ]

        prob=[
            [15.,1/2],
            [15.,1/2],
            [8.,1/2],
            [5.,1/2],
            [40.,1/2],
        ]
    end

############################# Generowanie #############################
    start_year=2015


    get_birthdate(id)=begin
        i=1
        while true
            if personal_data[1][i]==id
                break
            end
            i+=1
        end
        return personal_data[4][i]
    end

    time_to_die(id)=begin
        i=1
        while true
            if players[1][i]==id
                break
            end
            i+=1
        end
        players[3][i]=2
        j=1
        while true
            if personal_data[1][j]==players[2][i]
                break
            end
            j+=1
        end
        personal_data[6][j]+=rand(100:900)
    end



    begin # tabela teams
        push!(teams[1],1)
        push!(teams[1],2)
        push!(teams[2],team_names[1])
        push!(teams[2],team_names[1])
        push!(teams[3],section[1])
        push!(teams[3],section[2])


        for i in 2:length(team_names)
            x=rand(0:3)
            if x%2==1
                push!(teams[1],teams[1][end]+1)
                push!(teams[2],team_names[i])
                push!(teams[3],section[1])
            end
            if x>=2
                push!(teams[1],teams[1][end]+1)
                push!(teams[2],team_names[i])
                push!(teams[3],section[2])
            end
        end
    end

    begin # adress
        for i in 1:size(halls)[1] 
            push!(addresses[1],i)
            push!(addresses[3],halls[i,1])
            push!(addresses[2],halls[i,2])
        end
    end

    year=start_year

    junior_number=rand(Poisson(14))
    senior_number=rand(Poisson(11))

    # Początek juniorów
    for i in 1:junior_number
        # players
        push!(players[1],i)
        push!(players[2],i)
        push!(players[3],1)
        push!(players[4],rand_join_date(year))
        push!(players[5],true)

        # personal_data
        push!(personal_data[1],i)
        push!(personal_data[2], rand_name())
        push!(personal_data[3], rand_surname())
        push!(personal_data[4], rand_birthdate_junior(year))
        push!(personal_data[5], addresses[1][end]+1)
            push!(addresses[1], addresses[1][end]+1)
            push!(addresses[2], rand(street)*" "*string(rand(1:97)))
            push!(addresses[3], "Wrocław")
        push!(personal_data[6], max(3000.00, round(rand(Normal(5434.32,700)), digits=2)))
    end
    # Początek seniorów
    for i in 1:senior_number
        push!(players[1],junior_number+i)
        push!(players[2],junior_number+i)
        push!(players[3],2)
        push!(players[4],rand_join_date(year))
        push!(players[5],true)

        # personal_data
        push!(personal_data[1],junior_number+i)
        push!(personal_data[2], rand_name())
        push!(personal_data[3], rand_surname())
        push!(personal_data[4], rand_birthdate_senior(year))
        push!(personal_data[5], addresses[1][end]+1)
            push!(addresses[1], addresses[1][end]+1)
            push!(addresses[2], rand(street)*" "*string(rand(1:97)))
            push!(addresses[3], "Wrocław")
        push!(personal_data[6], max(3500.00, round(rand(Normal(7434.32,1000)), digits=2)))
    end

    # Pracownicy
    begin
        push!(employees[1],1)
        push!(employees[2],personal_data[1][end]+1)
            push!(personal_data[1],personal_data[1][end]+1)
            push!(personal_data[2],rand_name())
            push!(personal_data[3], rand_surname())
            push!(personal_data[4], rand_birthdate_senior(year))
            push!(personal_data[5], addresses[1][end]+1)
                push!(addresses[1], addresses[1][end]+1)
                push!(addresses[2], rand(street)*" "*string(rand(1:97)))
                push!(addresses[3], "Wrocław")
            push!(personal_data[6], max(3100.00, round(rand(Normal(3500,400)), digits=2)))
        push!(employees[3],functions[1])

        a=[0,1,1,2,1,4,2,2,1]
        for j in 1:length(a)
            for i in 1:a[j]
                push!(employees[1],employees[1][end]+1)
                push!(employees[2],personal_data[1][end]+1)
                    push!(personal_data[1],personal_data[1][end]+1)
                    push!(personal_data[2],rand_name())
                    push!(personal_data[3], rand_surname())
                    push!(personal_data[4], rand_birthdate_senior(year))
                    push!(personal_data[5], addresses[1][end]+1)
                        push!(addresses[1], addresses[1][end]+1)
                        push!(addresses[2], rand(street)*" "*string(rand(1:97)))
                        push!(addresses[3], "Wrocław")
                    push!(personal_data[6], max(3100.00, round(rand(Normal(3500,400)), digits=2)))
                push!(employees[3],functions[j])
            end
        end

    end



    year=start_year #rok 1 turnieje
    begin
        junior_games=sort([rand_tournament_date(year) for i in 1:rand(Poisson(6))+1])
        num=1
        while num<length(junior_games)
            if junior_games[num+1] - junior_games[num] <= Day(4)
                setdiff!(junior_games, [junior_games[num+1]])
            else
                num+=1
            end
        end
        #junior_games=junior_games[1:end-1][[junior_games[i+1] - junior_games[i] > Day(4) for i in 1:length(junior_games)-1]]
        for i in junior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
            n=rand(3:5)

            enemy=randperm(length(teams[1][teams[3].==section[1]][2:end]))
            enemy=teams[1][teams[3].==section[1]][2:end][enemy][1:n]

            ally =randperm(length(players[1][players[3].==1 .& players[5]]))[1:5]
            injury=Bool.(zeros(5))

            for j in 1:n
                w=rand()<0.65
                push!(games[1], length(games[1])>0 ? games[1][end]+1 : 1)
                if w
                    push!(games[2],1)
                    push!(games[3],enemy[j])
                else
                    push!(games[3],1)
                    push!(games[2],enemy[j])
                end
                push!(games[4], i+Day(round(Int,((j-1)/2))))
                push!(games[5],rank[1])


                complete=ally[.!injury]
                if length(complete)==5
                    complete=complete[1:4]
                end
                if size(complete)[1]<3
                    error("Brak graczy")
                end
                for i in complete
                    push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                    push!(participation[2], i)
                    push!(participation[3], games[1][end])
                end

                injury = injury .|| rand(5).<0.02
            end
        end


        #senior_games=push!(sort([rand_tournament_date(year) for i in 1:rand(Poisson(6))+1]),rand_tournament_date(year+3))
        #senior_games=senior_games[1:end-1][[senior_games[i+1] - senior_games[i] > Day(4) for i in 1:length(senior_games)-1]]
        senior_games=sort([rand_tournament_date(year) for i in 1:rand(Poisson(7))+1])
        num=1
        while num<length(senior_games)
            if senior_games[num+1] - senior_games[num] <= Day(4)
                setdiff!(senior_games, [senior_games[num+1]])
            else
                num+=1
            end
        end
        for i in senior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
            n=rand(3:5)

            enemy=randperm(length(teams[1][teams[3].==section[2]][2:end]))
            enemy=teams[1][teams[3].==section[2]][2:end][enemy][1:n]
            ally =randperm(length(players[1][players[3].==2 .&& players[5]]))[1:5]
            injury=Bool.(zeros(5))

            for j in 1:n
                w=rand()<0.65
                push!(games[1],games[1][end]+1)
                if w
                    push!(games[2],2)
                    push!(games[3],enemy[j])
                else
                    push!(games[3],2)
                    push!(games[2],enemy[j])
                end
                push!(games[4], i+Day(round(Int,((j-1)/2))))
                push!(games[5],rank[1])

                complete=ally[.!injury]
                if length(complete)==5
                    complete=complete[1:4]
                end
                if size(complete)[1]<3
                    error("Brak graczy")
                end
                for i in complete
                    push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                    push!(participation[2], i)
                    push!(participation[3], games[1][end])
                end

                injury = injury .|| rand(5).<0.02            
            end
        end

        
    end

    begin # swobodne 1 rok
            # Friendly Junior
            junior_games=sort([rand_friendly_date(year) for i in 1:rand(Poisson(5))+1])
            num=1
            while num<length(junior_games)
                if junior_games[num+1] - junior_games[num] <= Day(4)
                    setdiff!(junior_games, [junior_games[num+1]])
                else
                    num+=1
                end
            end
            for i in junior_games
                cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
        
                enemy=rand(teams[1][teams[3].==section[1]][2:end])
        
                ally =randperm(length(players[1][players[3].==1 .& players[5]]))[1:4]
        
                w=rand()<0.65
                push!(games[1],games[1][end]+1)
                if w
                    push!(games[2],1)
                    push!(games[3],enemy)
                else
                    push!(games[3],1)
                    push!(games[2],enemy)
                end
                push!(games[4], i)
                push!(games[5],rank[2])
        
        
                for i in ally
                    push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                    push!(participation[2], i)
                    push!(participation[3], games[1][end])
                end
        
            end
        
        
            # Friendly Senior 
            senior_games=sort([rand_friendly_date(year) for i in 1:rand(Poisson(6))+1])
            num=1
            while num<length(senior_games)
                if senior_games[num+1] - senior_games[num] <= Day(4)
                    setdiff!(senior_games, [senior_games[num+1]])
                else
                    num+=1
                end
            end
            for i in senior_games
                cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
        
                enemy=rand(teams[1][teams[3].==section[2]][2:end])
                ally =randperm(length(players[1][players[3].==2 .&& players[5]]))[1:4]
        
                w=rand()<0.65
                push!(games[1],games[1][end]+1)
                if w
                    push!(games[2],2)
                    push!(games[3],enemy)
                else
                    push!(games[3],2)
                    push!(games[2],enemy)
                end
                push!(games[4], i)
                push!(games[5],rank[2])
        
                for i in ally
                    push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                    push!(participation[2], i)
                    push!(participation[3], games[1][end])
                end
            end

    end



    for year in start_year+1:Dates.year(now())-1
        
        # Ilu dołączy
        junior_number = max(2,rand(Poisson(5)))
        senior_number=rand(Poisson(2))
        

        # Juniorzy dołączają
        for i in 1:junior_number
            push!(players[1],players[1][end]+1)
            push!(players[2],personal_data[1][end]+1)
            push!(players[3],1)
            push!(players[4],rand_join_date(year))
            push!(players[5],true)

            # personal_data
            push!(personal_data[1],personal_data[1][end]+1)
            push!(personal_data[2], rand_name())
            push!(personal_data[3], rand_surname())
            push!(personal_data[4], rand_birthdate_junior(year))
            push!(personal_data[5], addresses[1][end]+1)
                push!(addresses[1], addresses[1][end]+1)
                push!(addresses[2], rand(street)*" "*string(rand(1:97)))
                push!(addresses[3], sample(city[:,1], Weights([22, 3, 3, 2, 2, 1, 1, 1, 1])))
            push!(personal_data[6], min(3000.00, round(rand(Normal(5434.32,700)), digits=2)))
        end

        # Seniorzy dołączają
        for i in 1:senior_number
            push!(players[1],players[1][end]+1)
            push!(players[2],personal_data[1][end]+1)
            push!(players[3],2)
            push!(players[4],rand_join_date(year))
            push!(players[5],true)

            # personal_data
            push!(personal_data[1],personal_data[1][end]+1)
            push!(personal_data[2], rand_name())
            push!(personal_data[3], rand_surname())
            push!(personal_data[4], rand_birthdate_senior(year))
            push!(personal_data[5], addresses[1][end]+1)
                push!(addresses[1], addresses[1][end]+1)
                push!(addresses[2], rand(street)*" "*string(rand(1:97)))
                push!(addresses[3], sample(city[:,1], Weights([30, 3, 3, 2, 2, 1, 1, 1, 1])))
            push!(personal_data[6], max(3500.00, round(rand(Normal(7434.32,1000)), digits=2)))
        end

        # Seniorzy odchodzą
        leaft_number=rand(Poisson(4))
        a=1:length(players[5])
        a=sample(a[players[5].&& players[3].==2],leaft_number, replace=false)
        for i in a
            players[5][i]=false
        end

        # Juniorzy dorastają
        for i in players[1][players[3] .== 1][Date(year-1,6,30) .- get_birthdate.(players[1][players[3] .== 1]) .> Day(21*365)]
            time_to_die(i)
        end

        # Trunieje juniorzy
        junior_games=sort([rand_tournament_date(year) for i in 1:rand(Poisson(5))+1])
        num=1
        while num<length(junior_games)
            if junior_games[num+1] - junior_games[num] <= Day(4)
                setdiff!(junior_games, [junior_games[num+1]])
            else
                num+=1
            end
        end
        for i in junior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
            n=rand(3:5)

            enemy=randperm(length(teams[1][teams[3].==section[1]][2:end]))
            enemy=teams[1][teams[3].==section[1]][2:end][enemy][1:n]

            ally =randperm(length(players[1][players[3].==1 .& players[5]]))[1:5]
            injury=Bool.(zeros(5))

            for j in 1:n
                w=rand()<0.65
                push!(games[1],games[1][end]+1)
                if w
                    push!(games[2],1)
                    push!(games[3],enemy[j])
                else
                    push!(games[3],1)
                    push!(games[2],enemy[j])
                end
                push!(games[4], i+Day(round(Int,((j-1)/2))))
                push!(games[5],rank[1])


                complete=ally[.!injury]
                if length(complete)==5
                    complete=complete[1:4]
                end
                if size(complete)[1]<3
                    error("Brak graczy")
                end
                for i in complete
                    push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                    push!(participation[2], i)
                    push!(participation[3], games[1][end])
                end

                injury = injury .|| rand(5).<0.02
            end
        end

        # Turnieje seniorzy
        senior_games=sort([rand_tournament_date(year) for i in 1:rand(Poisson(6))+1])
        num=1
        while num<length(senior_games)
            if senior_games[num+1] - senior_games[num] <= Day(4)
                setdiff!(senior_games, [senior_games[num+1]])
            else
                num+=1
            end
        end
        for i in senior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
            n=rand(3:5)

            enemy=randperm(length(teams[1][teams[3].==section[2]][2:end]))
            enemy=teams[1][teams[3].==section[2]][2:end][enemy][1:n]
            ally =randperm(length(players[1][players[3].==2 .&& players[5]]))[1:5]
            injury=Bool.(zeros(5))

            for j in 1:n
                w=rand()<0.65
                push!(games[1],games[1][end]+1)
                if w
                    push!(games[2],2)
                    push!(games[3],enemy[j])
                else
                    push!(games[3],2)
                    push!(games[2],enemy[j])
                end
                push!(games[4], i+Day(round(Int,((j-1)/2))))
                push!(games[5],rank[1])

                complete=ally[.!injury]
                if length(complete)==5
                    complete=complete[1:4]
                end
                if size(complete)[1]<3
                    error("Brak graczy")
                end
                for i in complete
                    push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                    push!(participation[2], i)
                    push!(participation[3], games[1][end])
                end

                injury = injury .|| rand(5).<0.02       
            end
        end


        # Friendly Junior
        junior_games=sort([rand_friendly_date(year) for i in 1:rand(Poisson(6))+1])
        num=1
        while num<length(junior_games)
            if junior_games[num+1] - junior_games[num] <= Day(4)
                setdiff!(junior_games, [junior_games[num+1]])
            else
                num+=1
            end
        end
        for i in junior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))

            enemy=rand(teams[1][teams[3].==section[1]][2:end])

            ally =randperm(length(players[1][players[3].==1 .& players[5]]))[1:4]

            w=rand()<0.65
            push!(games[1],games[1][end]+1)
            if w
                push!(games[2],1)
                push!(games[3],enemy)
            else
                push!(games[3],1)
                push!(games[2],enemy)
            end
            push!(games[4], i)
            push!(games[5],rank[2])


            for i in ally
                push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                push!(participation[2], i)
                push!(participation[3], games[1][end])
            end

        end


        # Friendly Senior 
        senior_games=sort([rand_friendly_date(year) for i in 1:rand(Poisson(7))+1])
        num=1
        while num<length(senior_games)
            if senior_games[num+1] - senior_games[num] <= Day(4)
                setdiff!(senior_games, [senior_games[num+1]])
            else
                num+=1
            end
        end
        for i in senior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))

            enemy=rand(teams[1][teams[3].==section[2]][2:end])
            ally =randperm(length(players[1][players[3].==2 .&& players[5]]))[1:4]

            w=rand()<0.65
            push!(games[1],games[1][end]+1)
            if w
                push!(games[2],2)
                push!(games[3],enemy)
            else
                push!(games[3],2)
                push!(games[2],enemy)
            end
            push!(games[4], i)
            push!(games[5],rank[2])

            for i in ally
                push!(participation[1], length(participation[1])>0 ? participation[1][end]+1 : 1)
                push!(participation[2], i)
                push!(participation[3], games[1][end])
            end
        end
    end


    ## Przyszłość
    begin
        year=Dates.year(now())

        # Trunieje juniorzy
        junior_games=sort([rand_tournament_date(year) for i in 1:rand(Poisson(6))+1])
        num=1
        while num<length(junior_games)
            if junior_games[num+1] - junior_games[num] <= Day(4)
                setdiff!(junior_games, [junior_games[num+1]])
            else
                num+=1
            end
        end
        for i in junior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
            enemy=rand(teams[1][teams[3].==section[1]][2:end])

            push!(meetings[1], length(meetings[1]) > 0 ? meetings[1][end]+1 : 1)
            push!(meetings[2],1)
            push!(meetings[3], enemy)
            push!(meetings[4], cit)
            push!(meetings[5],i)
        end

        # Turnieje seniorzy
        senior_games=sort([rand_tournament_date(year) for i in 1:rand(Poisson(7))+1])
        num=1
        while num<length(senior_games)
            if senior_games[num+1] - senior_games[num] <= Day(4)
                setdiff!(senior_games, [senior_games[num+1]])
            else
                num+=1
            end
        end
        for i in senior_games
            cit=sample(1:length(halls[:,1]), Weights(Int.(halls[:,3])))
            enemy=rand(teams[1][teams[3].==section[2]][2:end])

            push!(meetings[1], length(meetings[1]) > 0 ? meetings[1][end]+1 : 1)
            push!(meetings[2],2)
            push!(meetings[3], enemy)
            push!(meetings[4], cit)
            push!(meetings[5],i)
        end

    end



    # Sklep
        ## equapment
            for itm in 1:4
                n=rand(2:5)
                for prod in sample(producer, n, replace=false)
                    for age in target
                        push!(equipment[1], length(equipment[1])>0 ? equipment[1][end]+1 : 1)
                        push!(equipment[2], items[itm])
                        push!(equipment[3], rand(NegativeBinomial(prob[itm][1],prob[itm][2])))
                        push!(equipment[4], items_price[itm])
                        push!(equipment[5], prod)
                        push!(equipment[6],age)
                    end
                end
            end 

            push!(equipment[1], length(equipment[1])>0 ? equipment[1][end]+1 : 1)
            push!(equipment[2], items[5])
            push!(equipment[3], rand(NegativeBinomial(prob[5][1],prob[5][2])))
            push!(equipment[4], items_price[5])
            push!(equipment[5], "NULL")
            push!(equipment[6], "NULL")

        ## rental
            stan=equipment[3]
            broom_id=equipment[1][equipment[2].=="Brooms"]
            stone_id=equipment[1][equipment[2].=="Stones"]
            shoes_id=equipment[1][equipment[2].=="Shoes"]
            glove_id=equipment[1][equipment[2].=="Gloves"]

            
            n=rand(Poisson(270))
            phone=sample(100000000:999999999,n,replace=false)
            pes_date=[rand_birthdate_senior(2022-5) for i in 1:n]
            pessel=["" for i in 1:n]
            pes_num=string.(sample(1000:9999,n,replace=false))
            g(n)= n==1 || n==5 || n==9 ? 1 : 
                    n==2 || n==6 || n==10 ? 3 :
                    n==3 || n==7 ? 7 : 9
            for i in 1:n
                pessel[i]=string(Dates.year(pes_date[i]))[3:4]*(length(string(Dates.month(pes_date[i]))) > 1 ? string(Dates.month(pes_date[i])) : "0"*string(Dates.month(pes_date[i])))*(length(string(Dates.day(pes_date[i]))) > 1 ? string(Dates.day(pes_date[i])) : "0"*string(Dates.day(pes_date[i])))*pes_num[i]
                k=sum((g(j)*Int(pessel[i][j]))%10 for j in 1:length(pessel[i]))
                pessel[i]*=string((9-k%10+3)%10)
            end


            for i in 1:n
                push!(customers[1], length(customers[1])>0 ? customers[1][end]+1 : 1)
                push!(customers[2], phone[i])
                push!(customers[3], parse(Int64,pessel[i]))
            end

            returns=[Any[] for i in 1:length(equipment[1])]

            for i in Date(start_year+1,6,24):Day(1):Date(2022,5,25)
                m=rand(9 <=Dates.month(i) <= 2 ? Poisson(5) : Poisson(3))
                cust=sample(1:n,m,replace=false)
                for j in cust
                    tim=min(rand(NegativeBinomial(2,1/2)),13)+1
                    if rand()<4/5
                        a=rand(broom_id)
                        b=rand(0:min(rand(Poisson(3)),stan[a]))
                        if b!=0
                            push!(rental[1], length(rental[1])>0 ? rental[1][end]+1 : 1)
                            push!(rental[2], i)
                            push!(rental[4],j)
                            push!(rental[5],tim)
                            push!(rental[6],a)
                            push!(rental[7],b)
                            stan[a]-=b

                            temp=rand()
                            if temp<95/100
                                push!(rental[3], rental[2][end]+Day(rental[5][end]))
                                push!(returns[a],[rental[3][end],b])
                            else
                                push!(rental[3], rental[2][end]+Day(rental[5][end]+rand(Poisson(1/3))+1))
                                push!(returns[a],[rental[3][end],b])
                            end
                        end
                    end
                    if rand()<4/5
                        a=rand(stone_id)
                        b=rand(0:min(rand(Poisson(3)),stan[a]))
                        if b!=0
                            push!(rental[1], length(rental[1])>0 ? rental[1][end]+1 : 1)
                            push!(rental[2], i)
                            push!(rental[4],j)
                            push!(rental[5],tim)
                            push!(rental[6],a)
                            push!(rental[7],b)
                            stan[a]-=b

                            temp=rand()
                            if temp<95/100
                                push!(rental[3], rental[2][end]+Day(rental[5][end]))
                                push!(returns[a],[rental[3][end],b])
                            else
                                push!(rental[3], rental[2][end]+Day(rental[5][end]+rand(Poisson(1/3))+1))
                                push!(returns[a],[rental[3][end],b])
                            end
                        end
                    end
                    if rand()<4/5
                        a=rand(shoes_id)
                        b=rand(0:min(rand(Poisson(3)),stan[a]))
                        if b!=0
                            push!(rental[1], length(rental[1])>0 ? rental[1][end]+1 : 1)
                            push!(rental[2], i)
                            push!(rental[4],j)
                            push!(rental[5],tim)
                            push!(rental[6],a)
                            push!(rental[7],b)
                            stan[a]-=b

                            temp=rand()
                            if temp<95/100
                                push!(rental[3], rental[2][end]+Day(rental[5][end]))
                                push!(returns[a],[rental[3][end],b])
                            else
                                push!(rental[3], rental[2][end]+Day(rental[5][end]+rand(Poisson(1/3))+1))
                                push!(returns[a],[rental[3][end],b])
                            end
                        end
                    end
                    if rand()<2/5
                        a=rand(glove_id)
                        b=rand(0:min(rand(Poisson(3)),stan[a]))
                        if b!=0
                            push!(rental[1], length(rental[1])>0 ? rental[1][end]+1 : 1)
                            push!(rental[2], i)
                            push!(rental[4],j)
                            push!(rental[5],tim)
                            push!(rental[6],a)
                            push!(rental[7],b)
                            stan[a]-=b

                            temp=rand()
                            if temp<95/100
                                push!(rental[3], rental[2][end]+Day(rental[5][end]))
                                push!(returns[a],[rental[3][end],b])
                            else
                                push!(rental[3], rental[2][end]+Day(rental[5][end]+rand(Poisson(1/3))+1))
                                push!(returns[a],[rental[3][end],b])
                            end
                        end
                    end
                    if rand()<2/5
                        a=equipment[1][end]
                        b=rand(0:min(rand(Poisson(3)),stan[a]))
                        if b!=0
                            push!(rental[1], length(rental[1])>0 ? rental[1][end]+1 : 1)
                            push!(rental[2], i)
                            push!(rental[4],j)
                            push!(rental[5],tim)
                            push!(rental[6],a)
                            push!(rental[7],b)
                            stan[a]-=b

                            temp=rand()
                            if temp<95/100
                                push!(rental[3], rental[2][end]+Day(rental[5][end]))
                                push!(returns[a],[rental[3][end],b])
                            else
                                push!(rental[3], rental[2][end]+Day(rental[5][end]+rand(Poisson(1/3))+1))
                                push!(returns[a],[rental[3][end],b])
                            end
                        end
                    end
                end

                for k in 1:length(returns)
                    while length(returns[k])>0 &&  returns[k][1][1]<=i
                        stan[k]+=returns[k][1][2]
                        popfirst!(returns[k])
                    end
                end
            end






############################### Push ###############################

    conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "team1", "te@m1P@ss", db="team1")

    begin 
        addresses_table="""INSERT INTO addresses (id, address, city)  VALUES\n"""
        customers_table="""INSERT INTO  customers (id, phone_number, pesel)  VALUES\n"""
        employees_table="""INSERT INTO employees (id, personal_data_id, function)  VALUES\n"""
        equipment_table="""INSERT INTO  equipment (id, name, quantity, price_per_day, producer, target_group)  VALUES\n"""
        games_table="""INSERT INTO games (id, winning_team_id, lost_team_id, date, rank)  VALUES\n"""
        meetings_table="""INSERT INTO meetings (id, our_team_id, other_team_id, address_id, date)  VALUES\n"""
        participation_table="""INSERT INTO  participation (id, player_id, game_id)  VALUES\n"""
        personal_data_table="""INSERT INTO personal_data (id, first_name, last_name, birth_date, address_id, salary)  VALUES\n"""
        players_table="""INSERT INTO players (id, personal_data_id, team_id, joining_date, active) VALUES\n"""
        rental_table="""INSERT INTO  rental (id, rental_date, return_date, customer_id,days, equipment_id, quantity)  VALUES\n"""
        teams_table="""INSERT INTO  teams (id, club_name, section)  VALUES\n"""
    end;


    begin
        for i in 1:length(addresses[1])
            txt="($(addresses[1][i]),'$(addresses[2][i])','$(addresses[3][i])')"
            txt*= i<length(addresses[1]) ? ",\n" : "\n;"
            addresses_table*=txt
        end
        
        for i in 1:length(customers[1])
            txt="($(customers[1][i]),$(customers[2][i]),$(customers[3][i]))"
            txt*= i<length(customers[1]) ? ",\n" : "\n;"
            customers_table*=txt
        end
        
        for i in 1:length(employees[1])
            txt="($(employees[1][i]),$(employees[2][i]),'$(employees[3][i])')"
            txt*= i<length(employees[1]) ? ",\n" : "\n;"
            employees_table*=txt
        end
        
        for i in 1:length(equipment[1])
            txt="($(equipment[1][i]),'$(equipment[2][i])',$(equipment[3][i]),$(equipment[4][i]),$(equipment[5][i]!="NULL" ? "'$(equipment[5][i])'" : equipment[5][i]),$(equipment[6][i]!="NULL" ? "'$(equipment[6][i])'" : equipment[6][i]))"
            #$(equipment[6][i]))"
            txt*= i<length(equipment[1]) ? ",\n" : "\n;"
            equipment_table*=txt
        end
        
        for i in 1:length(games[1])
            txt="($(games[1][i]),$(games[2][i]),$(games[3][i]),'$(games[4][i])','$(games[5][i])')"
            txt*= i<length(games[1]) ? ",\n" : "\n;"
            games_table*=txt
        end

        for i in 1:length(meetings[1])
            txt="($(meetings[1][i]),$(meetings[2][i]),$(meetings[3][i]),$(meetings[4][i]),'$(meetings[5][i])')"
            txt*= i<length(meetings[1]) ? ",\n" : "\n;"
            meetings_table*=txt
        end

        for i in 1:length(participation[1])
            txt="($(participation[1][i]),$(participation[2][i]),$(participation[3][i]))"
            txt*= i<length(participation[1]) ? ",\n" : "\n;"
            participation_table*=txt
        end

        for i in 1:length(personal_data[1])
            txt="($(personal_data[1][i]),'$(personal_data[2][i])','$(personal_data[3][i])','$(personal_data[4][i])',$(personal_data[5][i]),$(personal_data[6][i]))"
            txt*= i<length(personal_data[1]) ? ",\n" : "\n;"
            personal_data_table*=txt
        end

        for i in 1:length(players[1])
            txt="($(players[1][i]),$(players[2][i]),$(players[3][i]),'$(players[4][i])',$(players[5][i] ? 1 : 0))"
            txt*= i<length(players[1]) ? ",\n" : "\n;"
            players_table*=txt
        end
        
        for i in 1:length(rental[1])
            txt="($(rental[1][i]),'$(rental[2][i])','$(rental[3][i])',$(rental[4][i]),$(rental[5][i]),$(rental[6][i]),$(rental[7][i]))"
            txt*= i<length(rental[1]) ? ",\n" : "\n;"
            rental_table*=txt
        end
        
        for i in 1:length(teams[1])
            txt="($(teams[1][i]),'$(teams[2][i])','$(teams[3][i])')"
            txt*= i<length(teams[1]) ? ",\n" : "\n;"
            teams_table*=txt
        end
    end


    reset="""
        SET FOREIGN_KEY_CHECKS=0;

        CREATE OR REPLACE TABLE customers(
            id INT(4) PRIMARY KEY AUTO_INCREMENT,
            phone_number INT(10) NOT NULL,
            pesel BIGINT(11) NOT NULL
        );

        CREATE OR REPLACE TABLE equipment(
            id INT(3) PRIMARY KEY AUTO_INCREMENT,
            name VARCHAR(50) NOT NULL,
            quantity INT(10) NOT NULL,
            price_per_day DECIMAL(5,2) NOT NULL,
            producer VARCHAR(50),
            target_group ENUM('children', 'teeneger', 'adult')
        );


        CREATE OR REPLACE TABLE rental(
            id INT(5) PRIMARY KEY AUTO_INCREMENT,
            rental_date DATE NOT NULL,
            return_date DATE,
            days INT(2) NOT NULL,
            customer_id INT(4) NOT NULL,
            FOREIGN KEY(customer_id) REFERENCES customers(id),
            equipment_id INT(3) NOT NULL,
            quantity INT(2) NOT NULL,
            FOREIGN KEY(equipment_id) REFERENCES equipment(id)
        );

        CREATE OR REPLACE TABLE addresses(
            id INT(4) PRIMARY KEY AUTO_INCREMENT,
            address VARCHAR(255) NOT NULL,
            city VARCHAR(50) NOT NULL
        );

        CREATE OR REPLACE TABLE personal_data(
            id INT(3) PRIMARY KEY AUTO_INCREMENT,
            first_name VARCHAR(15) NOT NULL,
            last_name VARCHAR(16) NOT NULL,
            birth_date DATE NOT NULL,
            address_id INT NOT NULL,
            FOREIGN KEY(address_id)REFERENCES addresses(id),
            salary DECIMAL(7,2) NOT NULL
        );

        CREATE OR REPLACE TABLE employees(
            id INT(3) PRIMARY KEY AUTO_INCREMENT,
            personal_data_id INT(3) NOT NULL,
            function VARCHAR(20) NOT NULL,
            FOREIGN KEY(personal_data_id) REFERENCES personal_data(id)
        );

        CREATE OR REPLACE TABLE teams(
            id INT(4) PRIMARY KEY AUTO_INCREMENT,
            club_name VARCHAR(50) NOT NULL,
            section ENUM('junior', 'senior') NOT NULL
        );

        CREATE OR REPLACE TABLE meetings(
            id INT(3) PRIMARY KEY AUTO_INCREMENT,
            our_team_id INT(4) NOT NULL,
            other_team_id INT(4) NOT NULL,
            address_id INT(4),
            date DATE NOT NULL,
            FOREIGN KEY(our_team_id) REFERENCES teams(id),
            FOREIGN KEY(other_team_id) REFERENCES teams(id),
            FOREIGN KEY(address_id) REFERENCES addresses(id)
        );



        CREATE OR REPLACE TABLE games(
            id INT(4) PRIMARY KEY AUTO_INCREMENT,
            winning_team_id INT(4) NOT NULL,
            lost_team_id INT(4) NOT NULL,
            rank ENUM('tournament', 'friendly','1') NOT NULL,
            date DATE NOT NULL,
            FOREIGN KEY(winning_team_id) REFERENCES teams(id),
            FOREIGN KEY(lost_team_id) REFERENCES teams(id)
        );


        CREATE OR REPLACE TABLE players(
            id INT(3) PRIMARY KEY AUTO_INCREMENT,
            personal_data_id INT(3) NOT NULL,
            team_id INT(4) NOT NULL,
            joining_date DATE NOT NULL,
            active BIT NOT NULL,
            FOREIGN KEY(personal_data_id) REFERENCES personal_data(id),
            FOREIGN KEY(team_id) REFERENCES teams(id)
        );


        CREATE OR REPLACE TABLE participation(
            id INT(5) PRIMARY KEY AUTO_INCREMENT,
            player_id INT(3) NOT NULL,
            game_id INT(4) NOT NULL,
            FOREIGN KEY(player_id) REFERENCES players(id),
            FOREIGN KEY(game_id) REFERENCES games(id)
        );


        SET FOREIGN_KEY_CHECKS=1;
            
    """;
    conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "team1", "te@m1P@ss", db="team1")
    DBInterface.execute(conn, reset);

    conn=DBInterface.connect(MySQL.Connection, "giniewicz.it", "team1", "te@m1P@ss", db="team1")

    begin
        DBInterface.execute(conn, "SET FOREIGN_KEY_CHECKS=0;")
        DBInterface.execute(conn,addresses_table)
        DBInterface.execute(conn,customers_table)
        DBInterface.execute(conn,employees_table)
        DBInterface.execute(conn,equipment_table)
        DBInterface.execute(conn,games_table)
        DBInterface.execute(conn,meetings_table)
        DBInterface.execute(conn,participation_table)
        DBInterface.execute(conn,personal_data_table)
        DBInterface.execute(conn,players_table)
        DBInterface.execute(conn,rental_table)
        DBInterface.execute(conn,teams_table)
        DBInterface.execute(conn, "SET FOREIGN_KEY_CHECKS=1;")
    end

#=    
    addresses_table +
    customers_table ?
    employees_table +
    equipment_table ?
    games_table -
    meetings_table +
    participation_table +
    personal_data_table +
    players_table +
    rental_table ?
    teams_table +
=#

