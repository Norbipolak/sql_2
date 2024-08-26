/*
    Amikor van a WHERE és utána odaírjuk, hogy OR akkor többet is ki tudunk választani 
    pl. select * from users where UserID = 5 or UserID = 6;

    De van egy olyan is, hogy IN és ilyenkor nem kell felsorolni az OR-val, hanem csak egy zárójelbe beírjuk, mint amikor 
    INSERT INTO táblanév VALUES(valami) (valami2) (valami3) 
    csak itt az a különbség, hogy egy zárójelben fel tudjuk sorolni az összeset 
    ->
*/

select * from users WHERE Email = 'pista88@gmail.com' OR Email = 'kati96@citromail.hu';

/*Az IN-es megoldás, amikor egy zárójelben lekérdezünk több adatot!!!!! mintha az OR-val felsorolnánk*/

select * from users where Email IN ('pista88@gmail.com', 'kati96@citromail.hu');

/*
WHERE-nél kell meghatározni, hogy melyik mezőt nézük (itt Email) és az IN()-be kell felsorolni az értékeket és akkor megjeleníti azokat a rekordokat 
amikre ez igaz lesz 
************
*/

/*
Meg akarjuk változtatni az eredeti táblánkat, hozzá akarunk adni egy mezőt, tehét column-ot 
itt ez két részből fog állni, de viszont azt is meg lehet határozni, hogy hova akarjuk majd ezt a column-ot (after vagy before valamihez képest)
2 rész, ami mindig kell 
1. ALTER TABLE táblanév - mindig ezzel kezdünk, hogy alter table és utána meg kell adni, hogy melyik táblárókl van szó
2. ADD COLUMN column-ak a neve - ez mindig a második, hogy add column és utána meg kell határozni ,hogy mi legyen a mező neve!!!! 

Ha még azt is meg akarjuk határozni, hogy hova tegyük be, akkor kell az AFTER vagy a BEFORE 
->
AFTER mező neve -> pl. a LastName után akarjuk berakni -> AFTER LastName 

az egész 
->
*/

ALTER TABLE users ADD COLUMN BirthYear year AFTER LastName;
/*fontos, hogy itt meg is kell adni, hogy milyen típusú legyen a mező, amit csináltunk (year, de ez lehetne varchar vagy int is)*/

/*
Tehét ami fontos 
ALTER TABLE 
ADD COLUMN 
AFTER/BEFORE
és mindegyik után meg kell mondani, hogy melyik taábláról mezőről van szó
..................................
*/

/*
Ha azt akarjuk, hogy kihozza az összeset, de egy olyan feltétel alapján ami tól-ig, akkor kétféleképpen lehet 
1. relációs jelekkel, ahol megadjuk az értékeket AND-vel elválasztva!!! 
2. BETWEEN AND, ahol szintén megadjuk a BETWEEN után az értékeket AND-vel elválasztva!!!  
*/

/*1.*/
select * from users where BirthYear <= 1992 AND >= 1999;

/*2.*/
SELECT * FROM users WHERE BirthYear BETWEEN 1992 AND 1999;

/*
És akkor így kiadja az összes mezejét és rekordot is azoknak, amik a BirthYear-je 1992 és 1999 között van
****************************************************************
*/

/*
    LIKE 
    részleges egyezést keresünk 

    Ha elöl van a % jel, akkor mindegy, hogy mi van elöl, 
    de a vége a megadott érték kell, hogy legyen.

    Ha a végén van a % jel, akkor mindegy, hogy mi van hátul, 
    de elöl a megadott keresési feltétel kell, hogy megjelenjen.
*/

select * from users where Email LIKE '%gmail.com';
/*megkapjuk az összeset, amelyikeknek gmail.com-ra végződik az email-jük*/

SELECT * FROM users WHERE Email LIKE 't%';
/*megkapjuk az összeset, amelyikeknek az email címe t-vel kezdődik*/

select * from users where UserName like '%acs%';
/*
fontos, hogy lehet két % jel-et megadni, ilyenkor megkapjuk azokat amikben van valahol acs
itt pl. a UserName-ben kell, hogy legyen acs és azokat fogja majd kíirni!!! 

Fontos, hogy mindig a WHERE-nél meghatározzuk, hogy melyik mezőről van szó és utána jöhet a feltétel, hogy LIKE vagy BETWEEN vagy IN!!!!! 
***************
*/

/*
    Sorba rendezés 
    A sorba rendezés szám típusú, varchar típusú és date meg datetime típusú mezők alapján is végbemehet 

    Két formája van 
    1. ASC (ascending) -> növekvő rendezés (ez az alapbeállítás) 
    2. DESC (descending) -> csökkenő rendezés 

    Nagyon fontos, hogy az ORDER BY-val határozzuk meg, hogy melyik mezőt akarjuk sorba rendezni és utána kell írni, hogy ASC vagy DESC

    de lehet, többet is sorba rendezni, ilyenkor vesszővel választjuk el a mezőket és mindegyiknek meg kell adni, hogy DESC vagy ASC legyen 
    pl. 
    select * from users ORDER BY LastName ASC, FirstName DESC;   
*/

SELECT * FROM users 
ORDER BY BirthYear ASC;

SELECT * FROM users
ORDER BY BirthYear DESC;

select * from users
order by Created DESC;

SELECT * FROM users 
ORDER BY FirstName ASC, LastName DESC;

/*
**********************
Táblák öszzekapcsolása 
Az idegen kulcssal kapcsolunk össze táblákat egymással.
*/

create table addresses(
    AddressID int primary key auto_increment,
    UserID int, 
    PostalCode int not null,
    Settlement varchar(255) not null,
    Street varchar(255) not null, 
    HouseNumber int not null,
    FloorNumber int, 
    DoorNumber int
    foreign key (UserID) references users(UserID); 
);

/*
Meg lehet itt határozni, amikor csináltunk egy táblát, hogy mi legyen a foreign key-e, amivel majd összekapcsoljuk egy másik tablával 
->
foreign key (UserID) references users(UserID); 
tehét ebben az esetben az addresses-ék a UserID lesz a foreign key, amit majd összekapcsolunk a users táblánk UserID-jével 

nagyon fontos itt a REFERENCES, mert ezt kell írni mielött megadjuk, hogy a másik tábla melyik mezejével akarjuk majd összekapcsolni az itteni 
foreign key-ünket, amit itt megadtunk -> foreign key (UserID) 
Az is fontos, hogy mindegyik egy egyedi azonosító legyen 

De az is megoldás, hogy ezt nem a () belül adjuk meg, hogy melyik legyen nekünk itt a foreign key, meg hogy mivel akarjuk majd összekapcsolni 
hanem ez lehet egy ALTER TABLE is!!
->
*/

ALTER TABLE addresses FOREIGN KEY (UserID) REFERENCES users(UserID);

/*most ennek a addresses táblának, amit most csináltunk megadjuk az értékeket, rekordokat az INSERT INTO-val*/

insert into addresses (UserID, PostalCode, Settlement, Street, HouseNumber) 
values(2, 8770, 'Győr', 'Petőfi Sándor utca', 29);

INSERT INTO addresses (UserID, PostalCode, Settlement, Street, HouseNumber)
VALUES(3, 6520 'Kecskemét', 'Móricz Zsigmond sétány', 102);

insert into addresses (UserID, PostalCode, Settlement, Street, HouseNumber)
values(4, 1165, 'Budapest', 'Béla utca', 3);

/*
JOIN müvelettel lehet majd a táblákat összekapcsolni. 
van többféle JOIN -> INNER JOIN, LEFT JOIN, RIGHT JOIN
*/

SELECT users.*, addresses.* /*kiválasztjuk mindegyik táblákból az összes mezőt*/
FROM users /*itt meghatározzuk, hogy melyik lesz a fő táblánk*/
INNER JOIN addresses /*meghatározzuk, hogy melyik az a tábla, amit a fő táblához hozzá akarunk adni */
ON users.UserID = addresses.UserID; 
/*
ON-ba pedig meghatározzuk, hogy mi alapján
Tehát a users táblában a UserID az meg kell egyezzen a addresses táblában a UserID-vel (azzal a UserID-vel ami ott van) 
és elötte nagyon fontos, hogy meg kell adni, hogy melyik a foreign key és azt kell majd a másik tábla primary key-éhéez a references
hozzácsatolni és csak ez után tudjuk megcsinálni a JOIN müveletet!!!!!! 

JOIN-nál 4 dolognak kell ott lennie
1. SELECT - itt kiválasztjuk, hogy melyik tábláról mit akarunk majd lekérdezni, melyik mezőket ha van egyezés 
    itt mindegyik táblának mindegyik mezejét akarjuk ezért -> users.*, addresses.* (táblanév.*)
2. FROM - meghatározzuk, hogy melyik a főtáblánk, az ahol a primary key van, nem a foreign 
3. JOIN/INNER JOIN/RIGHT JOIN, LEFT JOIN - hogy melyik az a tábla amit hozzá akarunk adni, itt kell, hogy legyen egy foreign key
4. ON - meghatározzuk, hogy mi alapján kötjük össze a táblákat, tehát mindkét tábla azon mezejének ugyanaz az értéke kell, hogy legyen!!! 
    user.UserID = addresses.UserID (így hivatkozunk egy tábla mezejére, mint egy objektumnak JavaScript-ben)
*/

/*
Ebben a példában meg a users tábla összes mezejére illetve az addresses táblából csak a settlement-et akartuk megjeleníteni
->
*/

SELECT users.*, addresses.settlement
FROM users 
INNER JOIN addresses 
ON users.UserID = addresses.UserID;

/*
Ami a FROM után van a fő táblánk. (bal oldali halmaz) 
Ha LEFT JOIN-t használunk, akkor annyi rekord fog lejönni, amennyi a fő táblán megtalálható 

Ha meg right, akkor annyi fog lejönni, amennyi ott megtalálható mint a főtáblás és ha inner, akkor meg annyi 
amennyi egyezés van, tehát ez igaz ON users.UserID = addresses.UserID;
*/
select users.*, addresses.* 
from users
left join addresses 
on users.UserID = addresses.UserID;

SELECT users.*, addresses.* 
FROM users 
RIGHT JOIN addresses
ON users.UserID = addresses.UserID;

/*
Meg lehet ezt úgy is csinálni, hogy nem join-val, hanem egy sima select-nél meghatározzuk, hogy melyik két tábla mezejéről van szó 
from-ba beírjuk mindegyik táblát és a where-nél pedig megadjuk ugyanazt, ami az ON-ba van join-nál 
1. SELECT - megadjuk a tablák mezeit, amelyikeket le akarunk kérdezni 
2. FROM - megadjuk mindkét táblánkat 
3. WHERE - maegadjuk a feltételt, hogy mi alapján kell megegyezést keresni, melyik mezők alapján 
->
*/

SELECT users.*, addresses.* 
FROM users, addresses
WHERE users.UserID = addresses.UserID;

/*
    Allekérdezések 
*/

SELECT * FROM addresses 
WHERE UserID = (SELECT UserID FROM users WHERE Email = 'pista88@gmail.com');

/*
Itt megneveztük, hogy az addresses listáról annak akarjuk lekérdezni az adatait, ahol az addresses-es UserID az megegyezik a users tablán 
lévő UserID-vel ahol az email 'pista88@gmail.com'

Tehát 
SELECT * 
FROM (megadjuk, hogy melyik tábla)
WHERE (megadjuk, hogy melyik mező) 

utána jön a zárójel 
SELECT (azt kell itt selectelni, ami elötte a WHERE-ben van, tehét majd annak kell megegyezni) 
FROM (melyik tábla) 
WHERE (megadjuk, hogy annak a rekordnak kell, megegyezzen a mezeje(UserID) a users-ről az addresses-vel, ahol az Email az 'pista88@gmail.com') 
*/

SELECT * 
FROM addresses
WHERE UserID = (SELECT UserID FROM users WHERE Email = 'pista88@gmail.com');

/*
ugyanitt lehet a LIKE-ot, de így is csak egy megegyezés lesz, de ha azt akarjuk, hogy több is lehessen, akkor tudjuk az ANY-t használni
*/

select * from addresses
where UserID = (select UserID from users like 't%');

/*
    Az ANY-vel össze lehet hasonlítani egy mezőértéket több mezőértékkel 
    Az allekérdezések gyorsabbak mint a JOIN-ok.
*/

SELECT * FROM addresses
WHERE UserID = ANY(SELECT UserID FROM users WHERE UserName LIKE '%t');
/*
itt az összes le fog jönni az addresses-ből, ahol a users-nél t-vel kezdődik a UserName és ugy össze vannak kötve 
*/


/*IN*/
select * from addresses
where UserID IN(SELECT UserID FROM users WHERE Email LIKE '%gmail.com');

/*
EXISTS 
*/

SELECT * FROM addresses
WHERE UserID = EXISTS(SELECT * FROM users Email LIKE '%gmail.com' AND addresses.UserID = users.UserID);


