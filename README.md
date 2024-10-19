# 🚗  — Сервис подбора автомобилей

## 📋 Описание

Это база данных сервиса для удобного подбора автомобилей по различным параметрам. Пользователь может фильтровать авто по марке, модели, году выпуска, цене и другим характеристикам. Данные организованы в базе данных для быстрого и эффективного поиска.

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

## 📋 Примеры запросов
###🔹 Легкие запросы
Немецкие марки авто
Самая старая модель авто
Средняя цена всех авто
Количество авто каждого типа

###🔸 Средние запросы
Авто, которое купили больше всех в один день
Автомобили, которые не покупали в 2023 году
Количество моделей авто, проданных в декабре 2023 года

###🔺 Сложные запросы
Общее количество моделей, купленных в 2023 году, отсортированное в порядке убывания
Автомобили с полным приводом и количеством сидений больше 5, а также дилерские центры, где они продаются
Цена и название авто с мощностью двигателя выше средней


