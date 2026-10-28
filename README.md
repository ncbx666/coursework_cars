# 🚗   Сервис подбора автомобилей

## 📋 Описание

Это база данных сервиса для удобного подбора автомобилей по различным параметрам. Пользователь может фильтровать авто по марке, модели, году выпуска, цене и другим характеристикам. Данные организованы в базе данных для быстрого и эффективного поиска.

## 📁 Файлы

- `report.pdf` — отчёт по курсовой работе;
- `cars_db.sql` — дамп базы PostgreSQL 15 (схема и данные).

Восстановить базу (дамп сам пересоздаёт базу `cars`):

```bash
psql -U postgres -f cars_db.sql
```

Дамп создан на Windows с локалью `Russian_Russia.1251`. На Linux и macOS замените её в строке `CREATE DATABASE` на доступную, например `ru_RU.UTF-8` или `C`.

## 📂 Модель данных
База данных построена с использованием SQL. Основные таблицы:

**Марки** (brands): Название бренда (например, BMW, Audi)

**Модели** (models): Название модели, тип кузова, количество сидений, привод

**Автосалоны** (dealerships): Название автосалона, его адрес, есть ли услуга трейд ин

**Двигатели** (engines): Название двигателя, тип, количество hp, количество цилиндров, объем 

**Покупки** (purchases): Проданные модели авто, их количество, автосалон, который продал авто

Связи между таблицами: многие ко многим, один ко многим. Так, например, у одной модели авто может быть несколько различных двигателей, а один двигателей может устанавливаться на несколько моделей авто(m:m). У одной марки авто может быть несколько моделей, однако у каждой модели только одна марка(1:m). 
Для реализации связей m:m были созданы вспомогательные таблицы:
1. dealership_brand
2. model_engine

База данных приведена к 3 нормальной форме.

![image](https://github.com/user-attachments/assets/3cdac845-f9c6-44e3-9d8e-a1607c5bd345)


## 📊 SQL-запросы для автосервиса

### 🔹 Легкие запросы  
- Немецкие марки авто  
- Самая старая модель авто  
- Средняя цена всех авто  
- Количество авто каждого типа  

### 🔸 Средние запросы  
- Авто, которое купили больше всех в один день  
- Автомобили, которые не покупали в 2023 году  
- Количество моделей авто, проданных в декабре 2023 года  

### 🔺 Сложные запросы  
- Общее количество моделей, купленных в 2023 году, отсортированное в порядке убывания  
- Автомобили с полным приводом и количеством сидений больше 5, а также дилерские центры, где они продаются  
- Цена и название авто с мощностью двигателя выше средней  


### Легкие запросы
**1. Немецкие марки авто**:
```sql
SELECT brand_name
FROM brands
WHERE country_of_foundation=’Германия’
```
**2. Самое старое авто**
```sql
SELECT model_name
FROM models
WHERE release_date =
  (SELECT MIN(release_date)
  FROM models);
```
**3. Средняя цена авто**
```sql
SELECT round(AVG(price),1)
FROM model_engine;
```
**4. Количество авто каждого типа**
```sql
SELECT type_of_car, COUNT(*) AS model_count
FROM models
GROUP BY type_of_car;
```

### Средние запросы
**1. Авто, которое купили больше всех в один день**
```sql
SELECT brand_name, model_name, amount
FROM
models
  INNER JOIN brands ON brands.id_brand=models.id_brand
  INNER JOIN purchases ON models.id_model=purchases.id_model
  WHERE amount = (SELECT MAX(amount) from purchases);
```
**2. Автомобили, которые не покупали в 2023 году.**
```sql
SELECT brand_name, model_name, amount
FROM
  models
  INNER JOIN brands ON brands.id_brand=models.id_brand
  LEFT JOIN purchases ON purchases.id_model=models.id_model
  WHERE amount IS NULL;
```
**3. Количество моделей авто, проданных в декабре 2023**
```sql
SELECT
  models.model_name,
  SUM(purchases.amount) AS count_sold
FROM
  models
  INNER JOIN purchases ON models.id_model = purchases.id_model
WHERE
  purchases.date_of_purchase>'30-11-2023'
GROUP BY
  models.model_name;
```

### Сложные запросы
**1. Общее количество моделей, купленных в 2023 году, отсортированное в
порядке убывания**
```sql
SELECT brand_name, model_name, total_purchases
FROM brands
INNER JOIN models ON brands.id_brand = models.id_brand
INNER JOIN (
SELECT id_model, SUM(amount) AS total_purchases
FROM purchases
GROUP BY id_model
) AS purchase_counts ON models.id_model = purchase_counts.id_model
ORDER BY total_purchases DESC;
```
**2. Вывести автомобили с полным приводом, количеством сиденей больше 5
и дилерские центры, в которых они продаются.**
```sql
SELECT dealership_name, brand_name, model_name, num_of_seats
FROM
dealerships
LEFT JOIN dealership_brand ON
dealerships.id_dealership=dealership_brand.id_dealership
LEFT JOIN brands ON dealership_brand.id_brand=brands.id_brand
LEFT JOIN models ON models.id_brand=brands.id_brand
WHERE
(drive='полный' and num_of_seats>5)
ORDER BY num_of_seats DESC;
```

**3. Вывести цену и название авто с мощностью двигателя выше средней)**
```sql
SELECT brand_name, model_name,engine_power, price
FROM
models
LEFT JOIN brands ON brands.id_brand=models.id_brand
LEFT JOIN model_engine ON models.id_model=model_engine.id_model
LEFT JOIN engines ON engines.id_engine=model_engine.id_engine
WHERE engine_power>(SELECT AVG(engine_power) FROM engines)
ORDER BY price;
```

