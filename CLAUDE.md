# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Проект

Icebreaker Talk — бэкенд на Strapi 5 (v5.12.4) с PostgreSQL. Управляет коллекциями вопросов-ледоколов для общения.

## Команды

```bash
npm run dev          # Запуск Strapi в режиме разработки (порт 1337)
npm run build        # Сборка админ-панели
npm run start        # Запуск production-сервера (требует предварительного build)
```

### Docker

```bash
docker-compose up -d          # PostgreSQL + Strapi (production)
docker-compose -f docker-compose.development.yml up -d  # Development
```

БД PostgreSQL 17.2 на порту 5432, Strapi на порту 1337. Данные БД в volume `strapi-data`.

## Архитектура

### Контент-типы и связи

- **Collection** — коллекция вопросов: `name` (string), `description` (text), `color` (color-picker, hex), связь oneToMany → Question
- **Question** — вопрос: `title` (string), `text` (text, required, unique), связь manyToOne → Collection

Все контент-типы используют `draftAndPublish: true`.

### Структура API

Каждый контент-тип в `src/api/{name}/` содержит стандартную структуру Strapi:
- `content-types/{name}/schema.json` — схема
- `controllers/{name}.ts` — контроллер (используют фабрики `createCoreController`)
- `services/{name}.ts` — сервис (используют фабрики `createCoreService`)
- `routes/{name}.ts` — маршруты (используют фабрики `createCoreRouter`)

### Конфигурация

- БД: настраивается через env-переменные, поддерживает postgres/mysql/sqlite (`config/database.ts`)
- Плагины: `@strapi/plugin-color-picker` для поля `color` в Collection
- Точка входа: `src/index.ts` — хуки `register` и `bootstrap` (пока пустые)

## Переменные окружения

Основные: `DATABASE_CLIENT`, `DATABASE_HOST`, `DATABASE_PORT`, `DATABASE_NAME`, `DATABASE_USERNAME`, `DATABASE_PASSWORD`. Пример в `.env.example`.
