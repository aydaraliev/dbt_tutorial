# dbt (Data Build Tool) -- Учебное пособие

## Содержание

1. [Введение в dbt](#1-введение-в-dbt)
2. [Что такое dbt и зачем он нужен](#2-что-такое-dbt-и-зачем-он-нужен)
3. [Для кого предназначен dbt](#3-для-кого-предназначен-dbt)
4. [Установка dbt](#4-установка-dbt)
5. [Проект dbt: структура и создание](#5-проект-dbt-структура-и-создание)
6. [Профили и конфигурация (profiles.yml)](#6-профили-и-конфигурация-profilesyml)
7. [DuckDB как база данных для обучения](#7-duckdb-как-база-данных-для-обучения)
8. [Рабочий процесс в dbt](#8-рабочий-процесс-в-dbt)
9. [Команда dbt run](#9-команда-dbt-run)
10. [Стратегии материализации](#10-стратегии-материализации)
11. [Модели данных и модели в dbt](#11-модели-данных-и-модели-в-dbt)
12. [Создание простой модели](#12-создание-простой-модели)
13. [Чтение данных из Parquet](#13-чтение-данных-из-parquet)
14. [Обновление моделей dbt](#14-обновление-моделей-dbt)
15. [Конфигурационные файлы YAML](#15-конфигурационные-файлы-yaml)
16. [Тестирование данных](#16-тестирование-данных)
17. [Документация в dbt](#17-документация-в-dbt)
18. [Шаблоны Jinja](#18-шаблоны-jinja)
19. [Иерархия моделей и DAG](#19-иерархия-моделей-и-dag)
- [Шпаргалка по командам](#шпаргалка-по-командам-dbt)

---

## 1. Введение в dbt

### Цели курса

- Понять основные концепции dbt
- Освоить практическое применение dbt
- Понять, почему dbt важен для специалистов по данным
- Научиться ориентироваться в проекте dbt
- Писать и запускать базовые модели dbt
- Освоить один из самых востребованных инструментов в data engineering

### Предварительные требования

- Опыт работы с SQL (базовый уровень и выше)
- Знакомство с командной строкой (терминалом)
- Базовое понимание конвейеров данных или моделирования данных -- желательно, но не обязательно

Курс предполагает активное использование IDE -- практические задания рекомендуется выполнять параллельно с чтением.

---

## 2. Что такое dbt и зачем он нужен

**dbt** -- **Data Build Tool**, инструмент, который отвечает за букву **T** (Transform) в подходе **ELT**:

| Этап | Описание |
|------|----------|
| **Extract** | Данные извлекаются из источников (API, базы данных, файлы) |
| **Load** | Данные загружаются в хранилище "как есть" |
| **Transform** | Данные преобразуются в нужный формат -- **здесь работает dbt** |

```
ETL: Источник -> Извлечение -> Трансформация -> Загрузка -> Хранилище
ELT: Источник -> Извлечение -> Загрузка -> Хранилище -> Трансформация (dbt)
```

### Ключевые возможности

1. **Переключение между хранилищами** -- Snowflake, BigQuery, PostgreSQL, DuckDB, ClickHouse, Redshift и др.
2. **Совместная работа с SQL** -- через git, как с обычным кодом
3. **Трансляция между диалектами SQL** -- упрощает миграцию между хранилищами
4. **Определение моделей и трансформаций** -- SQL-запросы оформляются как модели. Области применения: e-Commerce, мобильные приложения, IoT и др.
5. **Определение связей между моделями** -- например, Клиенты → Адреса → Заказы
6. **Запуск трансформаций** -- выполняет SQL в нужном порядке, материализует результат. Пример: конвертация сырых лог-файлов в структурированные таблицы
7. **Тестирование качества данных** -- проверки на уникальность, NOT NULL и др.

---

## 3. Для кого предназначен dbt

dbt предназначен для **любых пользователей, которым нужно трансформировать данные**:

| Роль | Как использует dbt |
|------|-------------------|
| **Дата-инженеры (Data Engineers)** | Построение пайплайнов, оркестрация -- основные пользователи |
| **Аналитики-инженеры (Analytics Engineers)** | Моделирование, метрики, документация |
| **Аналитики данных (Data Analysts)** | Ad-hoc трансформации, отчёты |

**Analytics Engineer** -- роль, которая возникла во многом благодаря dbt. Это мост между data engineering и аналитикой: создаёт модели данных, описывает метрики, пишет тесты качества, ведёт документацию и обеспечивает надёжный self-service доступ к данным для аналитиков и бизнеса.

Предпосылка: пользователь должен уметь работать с SQL.

---

## 4. Установка dbt

**dbt написан на Python** и распространяется как Python-пакет через `pip`. Это означает, что для работы с dbt необходим установленный Python (рекомендуется 3.9+).

**dbt Core** -- open-source CLI, бесплатен. **dbt Cloud** -- проприетарная облачная платформа (платная). В курсе используется dbt Core.

```bash
# Создать виртуальное окружение (рекомендуется)
python -m venv dbt-env
source dbt-env/bin/activate  # Linux/Mac
# dbt-env\Scripts\activate   # Windows

# Установка (для DuckDB)
pip install dbt-duckdb

# Другие адаптеры: dbt-postgres, dbt-snowflake, dbt-bigquery, dbt-clickhouse

# Проверка
dbt --version
dbt -h
```

### Расширения для IDE

dbt активно поддерживается в популярных IDE через расширения, которые обеспечивают подсветку синтаксиса Jinja+SQL, автодополнение, навигацию по моделям и предпросмотр скомпилированного SQL.

**Установка**: в VS Code откройте панель Extensions (`Ctrl+Shift+X`), найдите расширение по имени и нажмите Install. В JetBrains: Settings → Plugins → Marketplace.

**Топ-5 популярных расширений:**

| Расширение | IDE | Описание |
|---|---|---|
| **[dbt Power User](https://marketplace.visualstudio.com/items?itemName=innoverio.vscode-dbt-power-user)** | VS Code | Навигация по моделям, предпросмотр SQL, автодополнение `ref()` и `source()`, lineage graph прямо в редакторе |
| **[Better Jinja](https://marketplace.visualstudio.com/items?itemName=samuelcolvin.jinjahtml)** | VS Code | Подсветка синтаксиса Jinja внутри SQL, HTML и других файлов |
| **[YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)** | VS Code | Валидация и автодополнение YAML-файлов (`schema.yml`, `dbt_project.yml`) |
| **[SQLFluff](https://marketplace.visualstudio.com/items?itemName=dorzey.vscode-sqlfluff)** | VS Code | Линтер SQL с поддержкой dbt-шаблонов и Jinja |
| **[dbt](https://plugins.jetbrains.com/plugin/19950-dbt)** | JetBrains | Поддержка dbt для PyCharm/IntelliJ: навигация, подсветка, автодополнение |

---

## 5. Проект dbt: структура и создание

Проект dbt -- **структурированная коллекция файлов**: конфигурация, источники данных, SQL-запросы, шаблоны, документация, тесты.

### Структура директорий

```
NYC_YELLOW_TAXI/
├── analyses/            # Аналитические запросы (не материализуются)
├── dbt_packages/        # Установленные пакеты (dbt deps)
├── logs/                # Логи выполнения (dbt.log)
├── macros/              # Макросы (переиспользуемые Jinja/SQL)
├── models/              # Модели -- основная рабочая директория
│   ├── taxi_rides/      # Поддиректория для группировки моделей
│   │   ├── taxi_rides_raw.sql
│   │   ├── avg_fare_per_day.sql
│   │   └── total_creditcard_rides_per_day.sql
│   └── model_properties.yml  # Свойства моделей (описания, тесты)
├── seeds/               # CSV-файлы для загрузки в хранилище
├── snapshots/           # Снапшоты (SCD Type 2)
├── target/              # Скомпилированный SQL и артефакты
├── tests/               # Пользовательские тесты
└── dbt_project.yml      # Главный конфигурационный файл
```

### Директория `models/taxi_rides/`

Модели группируются в поддиректории по смысловому признаку. В примере `taxi_rides/` содержит все модели, связанные с данными о поездках такси. Имя поддиректории -- произвольное, но рекомендуется отражать домен данных. Вложенность может быть любой глубины, например `models/staging/taxi/`, `models/marts/finance/`.

### Файл `model_properties.yml`

Этот файл описывает **свойства моделей**: их названия, описания, доступность, колонки и тесты. Имя файла может быть любым (например, `schema.yml`, `_taxi_rides.yml`), главное -- расширение `.yml` и расположение в `models/`. Таких файлов может быть несколько -- dbt автоматически находит все `.yml`-файлы в `models/` и объединяет их.

```yaml
version: 2

models:
  - name: taxi_rides_raw
    description: Yellow Taxi raw data
    access: public
    columns:
      - name: avg_fare_per_day
        description: Average ride per day
        tests:
          - not_null
          - unique
```

### Директория `~/.dbt/`

При первом запуске `dbt init` в домашней директории пользователя создаётся скрытая директория `~/.dbt/`. Она содержит:

| Файл | Описание |
|------|----------|
| `profiles.yml` | Профили подключения к базам данных (общий для всех проектов) |
| `packages.yml` | (необязательно) глобальная конфигурация пакетов |

Путь `~/.dbt/profiles.yml` -- это место по умолчанию, где dbt ищет настройки подключения. Его можно переопределить флагом `--profiles-dir` или переменной окружения `DBT_PROFILES_DIR`.

```bash
ls ~/.dbt/
# profiles.yml
```

### Скомпилированные файлы и артефакты

При выполнении команд `dbt run`, `dbt compile`, `dbt test` и других dbt создаёт скомпилированные файлы в директории `target/`:

```
target/
├── compiled/               # SQL после раскрытия Jinja-шаблонов
│   └── nyc_yellow_taxi/
│       └── models/
│           └── taxi_rides/
│               ├── taxi_rides_raw.sql      # чистый SQL без Jinja
│               └── avg_fare_per_day.sql
├── run/                    # SQL, который был выполнен (включая CREATE/INSERT)
│   └── nyc_yellow_taxi/
│       └── models/
│           └── taxi_rides/
│               ├── taxi_rides_raw.sql
│               └── avg_fare_per_day.sql
├── manifest.json           # Полное описание проекта (модели, тесты, зависимости)
├── run_results.json        # Результаты последнего запуска
├── catalog.json            # Метаданные (после dbt docs generate)
└── graph.gpickle           # Сериализованный DAG
```

- **`target/compiled/`** -- результат `dbt compile` или `dbt run`. Содержит SQL с раскрытыми Jinja-шаблонами (`ref()`, `source()`, переменные), но **без** обёрток `CREATE TABLE`/`CREATE VIEW`. Полезно для отладки -- можно увидеть, что именно dbt отправит в базу.
- **`target/run/`** -- финальный SQL, который dbt выполнил в базе данных, включая DDL-обёртки (`CREATE VIEW AS ...`, `CREATE TABLE AS ...`).
- **`manifest.json`** -- JSON-файл с полным описанием проекта: все модели, источники, тесты, макросы, зависимости. Используется для интеграции с другими инструментами.
- **`run_results.json`** -- результаты последнего выполнения: статус каждой модели, время выполнения, ошибки.

Директория `target/` добавляется в `.gitignore` -- это генерируемые артефакты, которые не должны попадать в git.

### Создание нового проекта

```bash
dbt init <имя_проекта>
```

Команда запрашивает имя проекта, тип базы данных и создаёт полную структуру директорий.

```bash
repl:~/workspace$ dbt init
16:38:37  Running with dbt=1.8.4
Enter a name for your project (letters, digits, underscores): test_project
Which database would you like to use? [1] duckdb
Enter a number: 1
```

---

## 6. Профили и конфигурация (profiles.yml)

**Профиль** -- набор настроек подключения к базе данных для определённого окружения.

| Окружение | Назначение |
|-----------|-----------|
| **Development (dev)** | Разработка и тестирование |
| **Staging / Test** | Интеграционное тестирование |
| **Production (prod)** | Финальные данные для потребителей |

### Пример profiles.yml с DuckDB

```yaml
nyc_yellow_taxi:
  outputs:
    dev:
      type: duckdb
      path: dbt.duckdb
  target: dev
```

### Пример profiles.yml с PostgreSQL

```yaml
nyc_yellow_taxi:
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: dbt_user
      password: "{{ env_var('DBT_PG_PASSWORD') }}"
      dbname: taxi_db
      schema: public
      threads: 4
    prod:
      type: postgres
      host: prod-db.example.com
      port: 5432
      user: dbt_prod
      password: "{{ env_var('DBT_PG_PASSWORD') }}"
      dbname: analytics
      schema: production
      threads: 8
  target: dev
```

### Профиль с несколькими адаптерами (DuckDB + PostgreSQL)

```yaml
nyc_yellow_taxi:
  outputs:
    dev-duckdb:
      type: duckdb
      path: dbt.duckdb
    dev-postgres:
      type: postgres
      host: localhost
      port: 5432
      user: dbt_user
      password: "{{ env_var('DBT_PG_PASSWORD') }}"
      dbname: taxi_db
      schema: public
      threads: 4
  target: dev-duckdb   # по умолчанию используется DuckDB
```

### Переключение между target-ами

Поле `target` в `profiles.yml` определяет, какое окружение используется по умолчанию. Переключиться можно несколькими способами:

```bash
# Использовать target по умолчанию (из profiles.yml)
dbt run

# Явно указать target при запуске
dbt run --target dev-postgres
dbt run --target dev-duckdb

# Это работает со всеми командами
dbt test --target dev-postgres
dbt compile --target dev-duckdb
```

В SQL-файлах моделей можно писать условную логику, зависящую от текущего target:

```sql
-- models/taxi_rides/taxi_rides_raw.sql
{{ config(materialized='table') }}

SELECT
    pickup_datetime,
    dropoff_datetime,
    fare_amount,
    tip_amount
FROM
{% if target.type == 'duckdb' %}
    read_parquet('data/yellow_taxi.parquet')
{% elif target.type == 'postgres' %}
    {{ source('raw', 'yellow_taxi') }}
{% endif %}
```

Переменная `target` доступна в Jinja и содержит информацию о текущем подключении:

| Свойство | Описание | Пример |
|----------|----------|--------|
| `target.type` | Тип адаптера | `'duckdb'`, `'postgres'` |
| `target.name` | Имя target-а | `'dev-duckdb'`, `'dev-postgres'` |
| `target.schema` | Схема по умолчанию | `'public'` |
| `target.database` | Имя базы данных | `'taxi_db'` |

- Имя профиля должно совпадать с `profile` в `dbt_project.yml`
- `target: dev` -- активное окружение по умолчанию
- Файл хранится в `~/.dbt/profiles.yml`
- Проект может иметь несколько окружений в одном профиле

---

## 7. DuckDB как база данных для обучения

**DuckDB** -- open-source аналитическая СУБД без сервера (как SQLite, но для аналитики).

| Свойство | Описание |
|----------|----------|
| **Serverless** | Не требует серверного процесса |
| **Аналитическая** | Оптимизирована для OLAP-запросов |
| **Векторизованная** | Работает *быстро* |
| **Простая** | Минимальная настройка, файл базы хранится локально |

Идеальна для обучения: не требует установки сервера, легко работает с dbt, читает Parquet и CSV напрямую.

```sql
-- DuckDB умеет читать файлы напрямую
SELECT * FROM 'data.parquet';
SELECT * FROM 'data.csv';
SELECT * FROM read_json('api.json');
```

---

## 8. Рабочий процесс в dbt

```
1. Создать проект          (dbt init)
2. Настроить конфигурацию  (profiles.yml)
3. Создать модели и шаблоны
4. Материализовать модели  (dbt run)
5. Проверить / протестировать (dbt test)
6. Повторить по мере необходимости
```

Большую часть времени вы будете проводить на **шагах 3-6** -- итеративная разработка моделей.

---

## 9. Команда dbt run

Основная команда для **материализации моделей**:

1. Берёт SQL-код моделей
2. Обрабатывает Jinja-шаблоны
3. Выполняет SQL в целевом хранилище
4. Создаёт таблицы или представления

```bash
repl:~$ dbt run

04:52:11  Running with dbt=1.8.4
04:52:13  1 of 1 START sql view model main.sales_data ...... [RUN]
04:52:13  1 of 1 OK created sql view model main.sales_data . [OK in 0.12s]
04:52:13  Completed successfully
```

**Полная пересборка** (когда обычный run не помогает):
```bash
dbt run -f    # или dbt run --full-refresh
```

---

## 10. Стратегии материализации

По умолчанию dbt создаёт **представления (views)**, а не таблицы. Чтобы создать таблицу, нужно явно указать материализацию.

| Стратегия | Описание | Когда использовать |
|-----------|----------|--------------------|
| **view** | Представление (по умолчанию) | Лёгкие трансформации, небольшие данные |
| **table** | Физическая таблица | Тяжёлые трансформации, частые запросы |
| **incremental** | Дозагрузка новых записей | Большие объёмы, полная пересборка слишком дорога |
| **ephemeral** | Встраивается как CTE, не создаёт объект в БД | Промежуточные трансформации |

### Как задать

В модели:
```sql
{{ config(materialized='table') }}

SELECT customer_id, SUM(amount) AS total_spent
FROM {{ ref('orders') }}
GROUP BY customer_id
```

Глобально в `dbt_project.yml`:
```yaml
models:
  my_project:
    materialized: view
    marts:
      materialized: table
```

### Incremental модели

```sql
{{ config(materialized='incremental') }}

SELECT order_id, order_date, amount
FROM {{ ref('raw_orders') }}
{% if is_incremental() %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
{% endif %}
```

При первом запуске загружаются все данные; при последующих -- только новые.

---

## 11. Модели данных и модели в dbt

### Концепция модели данных

Модель данных -- **логическое представление** данных: что они означают, как связаны, какие у них атрибуты.

Пример:

| Species | # of legs | Venomous |
|---|---|---|
| Cheetah | 4 | No |
| Duck | 2 | No |
| Platypus | 4 | Yes |
| Rattlesnake | 0 | Yes |

В e-commerce контексте модель данных связывает продажи, товары и оплаты; определяет отношения Клиенты → Адреса → Заказы.

### Модель в dbt

В dbt **модель** -- это конкретно:

- **SQL-файл** (обычно `SELECT`-запрос) с расширением `.sql`
- Располагается в директории `models/`
- При `dbt run` материализуется в таблицу или представление
- Имя файла = имя модели = имя объекта в базе данных
- Начиная с dbt 1.3+ поддерживаются и **Python-модели** (`.py` файлы)
- Каждая модель -- отдельный `.sql` или `.py` файл

---

## 12. Создание простой модели

```bash
# 1. Создать директорию
mkdir models/order

# 2. Создать файл
touch models/order/customer_orders.sql
```

```sql
-- models/order/customer_orders.sql
SELECT
    first_name,
    last_name,
    shipping_address,
    item_quantity
FROM source_table
```

```bash
# 3. Материализовать
dbt run
```

После выполнения в базе появится объект `customer_orders`.

### Соглашения по именованию

| Элемент | Правило | Пример |
|---------|---------|--------|
| Имя модели | `<тип>_<источник>__<контекст>` | `stg_stripe__payments` |
| Первичный ключ | `<объект>_id` | `order_id` |
| Timestamp | `<событие>_at` (UTC) | `created_at` |
| Дата | `<событие>_date` | `order_date` |
| Boolean | Префикс `is_` / `has_` | `is_active` |

---

## 13. Чтение данных из Parquet

**Apache Parquet** -- **колоночный бинарный формат** хранения данных. Данные хранятся по колонкам, что позволяет читать только нужные колонки, эффективнее сжимать и быстрее агрегировать.

```
Строковое (CSV):                Колоночное (Parquet):
Row1: id=1, name=A, val=10     id:   [1, 2, 3]
Row2: id=2, name=B, val=20     name: [A, B, C]
Row3: id=3, name=C, val=30     val:  [10, 20, 30]
```

> Parquet vs CSV: в 2-10x компактнее и значительно быстрее благодаря колоночному хранению и сжатию

DuckDB читает Parquet напрямую:
```sql
SELECT * FROM read_parquet('filename.parquet');
-- или просто:
SELECT * FROM 'filename.parquet';
```

---

## 14. Обновление моделей dbt

Причины обновления: итеративная разработка, исправление ошибок, миграция, изменение требований.

> Git не обязателен для dbt, но настоятельно рекомендуется.

### Рабочий процесс

| Шаг | Действие | Команда |
|-----|----------|---------|
| 1 | Клонировать проект | `git clone` |
| 2 | Обновить модель | -- |
| 3 | Перегенерировать | `dbt run` |
| 4 | Закоммитить | `git commit` |

**Флаг `--full-refresh` (`-f`)** -- пересоздаёт модель с нуля (дропает и строит заново). Нужен при изменении **схемы** или **логики**, затрагивающей исторические данные.

---

## 15. Конфигурационные файлы YAML

### dbt_project.yml

Главный файл проекта. **Один на проект.** Содержит имя, версию, пути к директориям, глобальные настройки материализации.

```yaml
name: 'nyc_yellow_taxi'
version: '1.0.0'
profile: 'nyc_yellow_taxi'
model-paths: ["models"]
test-paths: ["tests"]
macro-paths: ["macros"]
```

### model_properties.yml

Файл свойств моделей: описания, документация, тесты. Может иметь **любое имя** с расширением `.yml`, должен быть в `models/`. Может быть **несколько** таких файлов.

```yaml
version: 2

models:
  - name: taxi_rides_raw
    description: Yellow Taxi raw data
    access: public
    columns:
      - name: avg_fare_per_day
        description: Average ride per day
        tests:
          - not_null
```

---

## 16. Тестирование данных

dbt позволяет проверять качество данных. Тест считается **проваленным**, если возвращает хотя бы одну строку.

### Встроенные тесты (задаются в YAML)

| Тест | Проверяет |
|------|-----------|
| `unique` | Все значения уникальны |
| `not_null` | Нет NULL-значений |
| `accepted_values` | Значения из заданного списка |
| `relationships` | Ссылочная целостность (FK) |

### Пользовательские тесты (SQL в `tests/`)

```sql
-- tests/assert_positive_amounts.sql
SELECT order_id, amount
FROM {{ ref('orders') }}
WHERE amount <= 0
```

```bash
dbt test                          # Все тесты
dbt test --select orders          # Тесты для конкретной модели
```

---

## 17. Документация в dbt

### Что документируется

Модели, колонки, data lineage / DAG, тесты, типы и размеры данных в хранилище.

Документация добавляется в `model_properties.yml` через поля `description`.

### Генерация и доступ

```bash
dbt docs generate    # Генерирует статический сайт (запускать после dbt run)
dbt docs serve       # Локальный веб-сервер (только для разработки!)
```

Для продакшна: dbt Cloud, Amazon S3, Nginx / Apache.

Веб-интерфейс показывает:

| Раздел | Что содержит |
|--------|-------------|
| **View / Models** | Список всех моделей проекта |
| **Description** | Описание из `model_properties.yml` |
| **Column details** | Типы данных, описания колонок |
| **Lineage graphs** | Визуальный граф зависимостей (DAG) |

> Lineage-граф -- одна из самых полезных возможностей. Позволяет видеть, какие модели зависят друг от друга.

---

## 18. Шаблоны Jinja

**Jinja** -- текстовый шаблонизатор из экосистемы Python. В dbt позволяет вставлять программную логику в SQL. Используется также в Django, Flask, Airflow.

### Синтаксис

| Конструкция | Назначение | Пример |
|---|---|---|
| `{{ ... }}` | Подстановка значения | `{{ column_name }}` |
| `{% ... %}` | Управляющая конструкция | `{% for col in columns %}` |
| `{# ... #}` | Комментарий | `{# это комментарий #}` |

### Функции Jinja в dbt

#### `ref('model_name')` -- ссылка на другую модель

Самая важная функция в dbt. Создаёт зависимость между моделями и позволяет dbt строить DAG.

```sql
-- models/taxi_rides/avg_fare_per_day.sql
SELECT
    pickup_date,
    AVG(fare_amount) AS avg_fare
FROM {{ ref('taxi_rides_raw') }}
GROUP BY pickup_date
```

При компиляции `{{ ref('taxi_rides_raw') }}` заменяется на реальное имя таблицы в базе (например, `main.taxi_rides_raw` для DuckDB или `public.taxi_rides_raw` для PostgreSQL).

#### `source('source_name', 'table_name')` -- ссылка на внешний источник

Используется для обращения к таблицам, которые **не являются моделями dbt**, а существуют во внешних системах (сырые данные, загруженные через EL-процесс).

Сначала источник описывается в YAML:
```yaml
# models/sources.yml
version: 2

sources:
  - name: raw_taxi_data
    schema: raw
    tables:
      - name: yellow_taxi_trips
        description: Raw taxi trip records
```

Затем используется в SQL:
```sql
-- models/taxi_rides/taxi_rides_raw.sql
SELECT
    pickup_datetime,
    dropoff_datetime,
    fare_amount,
    tip_amount
FROM {{ source('raw_taxi_data', 'yellow_taxi_trips') }}
```

При компиляции `{{ source(...) }}` заменяется на `raw.yellow_taxi_trips`.

#### `config(...)` -- настройки модели

Задаёт параметры модели (материализация, схема, теги и др.) прямо внутри SQL-файла.

```sql
-- Базовый пример
{{ config(materialized='table') }}

-- Расширенный пример с несколькими параметрами
{{ config(
    materialized='incremental',
    schema='staging',
    tags=['daily', 'taxi'],
    unique_key='trip_id'
) }}

SELECT
    trip_id,
    pickup_datetime,
    fare_amount
FROM {{ source('raw_taxi_data', 'yellow_taxi_trips') }}
{% if is_incremental() %}
    WHERE pickup_datetime > (SELECT MAX(pickup_datetime) FROM {{ this }})
{% endif %}
```

Основные параметры `config()`:

| Параметр | Описание | Пример |
|----------|----------|--------|
| `materialized` | Стратегия материализации | `'table'`, `'view'`, `'incremental'` |
| `schema` | Целевая схема | `'staging'` |
| `tags` | Теги для фильтрации | `['daily', 'taxi']` |
| `unique_key` | Ключ для incremental | `'trip_id'` |
| `enabled` | Включить/выключить модель | `True`, `False` |

#### `doc('doc_name')` -- блоки документации

Позволяет выносить длинные описания в отдельные markdown-файлы и ссылаться на них в YAML.

```markdown
{# models/docs.md #}

{% docs taxi_rides_raw %}
Сырые данные о поездках Yellow Taxi в Нью-Йорке.

Источник: NYC Taxi & Limousine Commission.
Данные обновляются ежемесячно.

**Ключевые колонки:**
- `pickup_datetime` -- дата и время посадки
- `fare_amount` -- стоимость поездки (USD)
{% enddocs %}
```

```yaml
# models/model_properties.yml
version: 2

models:
  - name: taxi_rides_raw
    description: "{{ doc('taxi_rides_raw') }}"
```

### Пример: цикл Jinja

**Без Jinja:**
```sql
SELECT
    COALESCE(start_date, '2025-01-01') AS start_date,
    COALESCE(update_date, '2025-01-01') AS update_date,
    COALESCE(end_date, '2025-01-01') AS end_date
FROM Events
```

**С Jinja:**
```sql
SELECT
{% for column in ['start_date', 'update_date', 'end_date'] %}
    COALESCE({{ column }}, '2025-01-01') AS {{ column }}{% if not loop.last %},{% endif %}
{% endfor %}
FROM Events
```

Результат идентичен, но код компактнее. При `dbt run` Jinja компилируется в чистый SQL (результат в `target/compiled/`).

### Макросы

Макросы -- **переиспользуемые блоки Jinja-кода**, которые хранятся в директории `macros/`. Макрос -- это по сути функция: принимает аргументы и возвращает SQL-фрагмент. Макросы позволяют избежать дублирования кода и стандартизировать часто используемые паттерны.

#### Что делают макросы

- **Инкапсулируют повторяющуюся логику** -- одна формула используется в десятках моделей
- **Стандартизируют трансформации** -- все модели применяют одинаковый подход
- **Упрощают поддержку** -- изменение логики в одном месте меняет поведение везде
- **Абстрагируют различия диалектов SQL** -- один макрос генерирует разный SQL для разных баз

#### Пример 1: конвертация центов в доллары

```sql
-- macros/cents_to_dollars.sql
{% macro cents_to_dollars(column_name) %}
    ROUND({{ column_name }} / 100.0, 2)
{% endmacro %}
```

Использование в моделях:
```sql
-- models/orders/order_totals.sql
SELECT
    order_id,
    {{ cents_to_dollars('amount_cents') }} AS amount_dollars,
    {{ cents_to_dollars('tax_cents') }} AS tax_dollars,
    {{ cents_to_dollars('shipping_cents') }} AS shipping_dollars
FROM {{ ref('raw_orders') }}
```

При компиляции каждый вызов `{{ cents_to_dollars('amount_cents') }}` будет заменён на `ROUND(amount_cents / 100.0, 2)`.

#### Пример 2: безопасное деление (без деления на ноль)

```sql
-- macros/safe_divide.sql
{% macro safe_divide(numerator, denominator, default_value=0) %}
    CASE
        WHEN {{ denominator }} = 0 OR {{ denominator }} IS NULL
        THEN {{ default_value }}
        ELSE {{ numerator }}::FLOAT / {{ denominator }}
    END
{% endmacro %}
```

```sql
-- models/metrics/conversion_rates.sql
SELECT
    campaign_id,
    impressions,
    clicks,
    {{ safe_divide('clicks', 'impressions') }} AS click_rate,
    {{ safe_divide('purchases', 'clicks', 'NULL') }} AS purchase_rate
FROM {{ ref('campaign_stats') }}
```

#### Пример 3: макрос с условной логикой по target

```sql
-- macros/current_timestamp_utc.sql
{% macro current_timestamp_utc() %}
    {% if target.type == 'duckdb' %}
        CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    {% elif target.type == 'postgres' %}
        NOW() AT TIME ZONE 'UTC'
    {% elif target.type == 'snowflake' %}
        CONVERT_TIMEZONE('UTC', CURRENT_TIMESTAMP())
    {% endif %}
{% endmacro %}
```

```sql
-- Использование в любой модели
SELECT
    order_id,
    {{ current_timestamp_utc() }} AS loaded_at
FROM {{ ref('raw_orders') }}
```

#### Пример 4: генерация стандартных метрик

```sql
-- macros/date_spine.sql
{% macro aggregate_by_date(date_column, metric_column, agg_func='SUM') %}
    SELECT
        DATE_TRUNC('day', {{ date_column }}) AS metric_date,
        {{ agg_func }}({{ metric_column }}) AS metric_value,
        COUNT(*) AS record_count
    FROM
{% endmacro %}
```

```sql
-- models/metrics/daily_revenue.sql
{{ aggregate_by_date('order_date', 'amount') }}
    {{ ref('orders') }}
GROUP BY 1
```

#### Как применять макросы

1. Создайте файл в `macros/` с определением `{% macro имя(аргументы) %} ... {% endmacro %}`
2. Вызывайте в любой модели через `{{ имя(аргументы) }}`
3. dbt автоматически находит все макросы в `macros/` -- импорт не нужен
4. Макросы из установленных пакетов (`dbt_packages/`) также доступны автоматически

---

## 19. Иерархия моделей и DAG

**Иерархия** -- граф зависимостей между моделями, также называемый **DAG** (Directed Acyclic Graph) или **lineage graph**.

### Зачем нужна

dbt использует DAG для **определения порядка выполнения**. Без него модели строились бы в алфавитном порядке, что приводит к ошибкам.

### Пример

```
taxi_rides_raw
    ├── avg_fare_per_day
    └── total_creditcard_rides_per_day
```

dbt строит `taxi_rides_raw` первой. Без иерархии `avg_fare_per_day` (по алфавиту) попыталась бы построиться раньше -- и упала бы с ошибкой.

### Определение зависимостей через ref()

**Без ref (прямая ссылка):**
```sql
SELECT first_name, last_name
FROM taxi_rides_raw
```

**С ref (через Jinja):**
```sql
SELECT first_name, last_name
FROM {{ ref('taxi_rides_raw') }}
```

При `dbt run` Jinja подставляет реальное имя таблицы. dbt анализирует все `ref()` и строит DAG автоматически.

**Преимущества ref():**
- Автоматический порядок сборки
- Абстракция от имён таблиц
- Визуализация в `dbt docs`
- Параллельное выполнение независимых моделей

---

## Шпаргалка по командам dbt

| Команда | Описание |
|---------|----------|
| `dbt init <name>` | Создать новый проект |
| `dbt run` | Материализовать все модели |
| `dbt run -f` | Полная пересборка |
| `dbt run --select model_name` | Запустить конкретную модель |
| `dbt run --select +model` | Модель + все её зависимости (upstream) |
| `dbt run --select model+` | Модель + все зависящие от неё (downstream) |
| `dbt run --target prod` | Запустить с конкретным target |
| `dbt test` | Запустить все тесты |
| `dbt build` | run + test для всех моделей |
| `dbt docs generate` | Сгенерировать документацию |
| `dbt docs serve` | Локальный сервер документации |
| `dbt compile` | Скомпилировать SQL без выполнения |
| `dbt seed` | Загрузить CSV из seeds/ |
| `dbt deps` | Установить пакеты |
| `dbt debug` | Диагностика подключения |
| `dbt clean` | Удалить артефакты (target/) |
| `dbt --version` | Версия dbt |

