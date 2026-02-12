# mysql-tests

Środowisko testowe MySQL z dostępem przez tunel SSH (Docker Compose).

## Struktura

```
├── docker-compose.yml    # Definicja serwisów MySQL i SSH
├── ssh/Dockerfile        # Obraz kontenera SSH (Alpine + OpenSSH)
└── init/01-init.sql      # Skrypt inicjalizujący bazę danych
```

## Wymagania

- Docker + Docker Compose

## Uruchomienie

```bash
docker compose up -d
```

## Połączenie z bazą danych

### 1. Otwórz tunel SSH (terminal 1)

```bash
ssh -L 3306:mysql:3306 tunnel@192.168.10.226 -p 2222
```

Hasło: `tunnel`

### 2. Połącz się przez tunel (terminal 2)

```bash
mysql -h 127.0.0.1 -u root -prootpass devdb
```

## Dane dostępowe

| Parametr      | Wartość      |
|---------------|-------------|
| Host MySQL    | `mysql` (wewnątrz sieci Docker) |
| Port MySQL    | `3306`      |
| Baza danych   | `devdb`     |
| Root hasło    | `rootpass`  |
| Użytkownik    | `testuser`  |
| Hasło         | `testpass`  |
| SSH user      | `tunnel`    |
| SSH hasło     | `tunnel`    |
| SSH port      | `2222`      |

## Inicjalizacja bazy

Przy pierwszym uruchomieniu automatycznie tworzona jest tabela `testowa` z przykładowymi danymi (skrypt `init/01-init.sql`).
