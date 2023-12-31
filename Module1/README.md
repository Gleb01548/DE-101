# Домашнее задание по модулю 1
[Ссылка на задание](https://github.com/Data-Learn/data-engineering/tree/master/DE-101%20Modules/Module01/DE%20-%20101%20Lab%201.1)

## Архитектура Аналитического Решения
Решение в файле - [analytical_solution.dio](https://github.com/Gleb01548/DE-101/blob/main/Module1/analytical_solution.dio)

![Архитектура Аналитического Решения](/Module1/image/арх.png)


### Цель проекта:

создание открытой базы данных для государственных и муниципальных контрактов (далее - контрактов), на ее основе создать информационный ресурс, который будет предоставлять гражданам сведения о контрактах на локальном уровне.

Проект нацелен на две категории: исследователи (или же аналитики) и простые граждане, которые не умеют применять инструменты анализа данных, не владеют sql и т.д. (далее - пользователи). 

Исследователям этот проект возможно будет интересен, потому что у них будет возможность выгружать актуальные данные за конкретный промежуток времени с учетом организации, территории, уровня организации (федеральный, субъектовый, местный). На это нацелено создание открытой базы данных на основе PostgreSQL. 
Также у исследователей будет возможность скачивать сырые (сразу после парсинга) и/или обработанные данные по прямой ссылке за определенный год. 

Для пользователя же главная задача проекта ответить, что происходит у него по месту жительства в сфере закупок. Ответить ему в доступной и наглядной форме, например, на такие вопросы: сколько денег потрачено в сфере ЖКХ через закупки, что закуплено, кем и у кого. 
Для этого в будущем планируется на основе PostgreSQL создать ресурс с аналитикой. 

### Задачи проекта:
- создать парсер контрактов (сделано);
реализовать обработку сырых данных (тестирование);
- создать базу данных контрактов (в проекте);
- реализовать актуализацию данных (в проекте);
- создание визуализаций на основе, имеющихся данных (в проекте).

### Реализация
Уже реализованные задачи можно разделить на несколько этапов: 
1. Скачивание данные с портала [Госрасходы Beta](https://spending.gov.ru) и выделения из них данных для дальнейшего парсинга*.
2. Парсинг данных с сайта [ЕИС Закупки](https://zakupki.gov.ru) о контрактах и заказчиках. 
3. Обработка сырых данных (заполнение пропусков, приведение дат к стандартному виду, декомпозиция адресов и т.д.).  
   
Далее планируется 
   1. Приведение данных к нормальной форме и загрузка их в PostgreSQL. 
   2. Периодическая актуализация данных (цены контракта, стадии его исполнения). 
   3. Создание витрин данных.
   4. Создание ресурса с их аналитикой для пользователей. 


[git проекта](https://github.com/Gleb01548/contract_database/blob/main/README.md)

*Использовать данные с Госрасходы Beta сразу для загрузки в PostgreSQL представляется нецелезообразным, так как они дублируют и противоречат друг другу, неполные и все равно состояния контрактов пришлось бы как-то обновлять, то есть парсить сайт. 

## Аналитика excel
Решение в файле [homework.xlsx](https://github.com/Gleb01548/DE-101/blob/main/Module1/homework.xlsx) 

![Сравнение сумм продаж по штатам](/Module1/image/дашборд1.png)

![Сравнение прибыли с продаж по штатам](/Module1/image/дашборд2.png)

![Прибыль ро мясецам](/Module1/image/дашборд3.png)