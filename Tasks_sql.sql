-- Схема БД состоит из четырех таблиц:
-- Product(maker, model, type)
-- PC(code, model, speed, ram, hd, cd, price)
-- Laptop(code, model, speed, ram, hd, price, screen)
-- Printer(code, model, color, type, price)
-- Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). 
-- Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. 
-- В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), 
-- скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), 
-- скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). 
-- Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). 
-- В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), 
-- тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.


-- 1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT Product.model, PC.speed, PC.hd 
FROM Product
JOIN PC ON Product.model = PC.model
WHERE PC.price < 500

-- 2. Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker 
FROM Product  
WHERE type = 'Printer'

-- 3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
SELECT Laptop.model, Laptop.ram, Laptop.screen 
FROM Laptop
WHERE laptop.price > 1000

-- 4. Найдите все записи таблицы Printer для цветных принтеров.
SELECT * 
FROM Printer
WHERE Printer.color = 'y'

-- 5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
Select PC.model, PC.speed, PC.hd 
from PC
where PC.cd in ('12x', '24x') and PC.price < 600

-- 6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
Select DISTINCT Product.maker, Laptop.speed 
from Product
join Laptop on Laptop.model = Product.model
where Laptop.hd >= 10

-- 7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
SELECT * FROM (SELECT model, price 
 FROM PC
 UNION
 SELECT model, price 
 FROM Laptop
 UNION
 SELECT model, price 
 FROM Printer
 ) AS a
WHERE a.model IN (SELECT model 
 FROM Product 
 WHERE maker = 'B'
 )

-- 8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.
Select distinct Product.maker from Product 
where product.type = 'PC'
EXCEPT 
Select distinct Product.maker from Product 
where product.type = 'laptop'

-- 9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
Select distinct product.maker from Product
join PC on PC.model = Product.model
where PC.speed >= 450 and Product.type = 'PC'

-- 10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
Select printer.model, printer.price
from printer
where printer.price = (select max(price) from printer)

-- 11. Найдите среднюю скорость ПК.
Select avg(pc.speed) from PC

-- 12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
Select avg(laptop.speed) from laptop
where laptop.price > 1000



