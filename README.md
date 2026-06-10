# mysql-tests

Środowisko testowe MySQL z dostępem przez tunel SSH (Docker Compose).

## Struktura

```
├── docker-compose.yml    # Definicja serwisów MySQL i SSH
├── ssh/Dockerfile        # Obraz kontenera SSH (Alpine + OpenSSH)
├── ssh/keys/             # Testowe klucze SSH (wypiekane w obraz przez authorized_keys)
└── init/01-init.sql      # Skrypt inicjalizujący bazę danych
```

## Wymagania

- Docker + Docker Compose

## Uruchomienie

```bash
docker compose up -d
```

## Połączenie z bazą danych

### Bezpośrednio (bez proxy)

```bash
mysql -h 127.0.0.1 -P 3307 -u root -prootpass devdb
```

### Przez tunel SSH

#### 1. Otwórz tunel SSH (terminal 1)

```bash
ssh -L 3306:mysql:3306 tunnel@192.168.10.226 -p 22022
```

Hasło: `tunnel`

Albo kluczem (klucze testowe wypiekane w obraz z `ssh/keys/authorized_keys`):

```bash
ssh -i ssh/keys/id_key -L 3306:mysql:3306 tunnel@192.168.10.226 -p 22022       # bez passphrase
ssh -i ssh/keys/id_keypass -L 3306:mysql:3306 tunnel@192.168.10.226 -p 22022   # passphrase: smokepass1
```

#### 2. Połącz się przez tunel (terminal 2)

```bash
mysql -h 127.0.0.1 -u root -prootpass devdb
```

## Dane dostępowe

| Parametr      | Wartość      |
|---------------|-------------|
| Host MySQL    | `mysql` (wewnątrz sieci Docker) |
| Port MySQL    | `3306` (wewnętrzny) / `3307` (bezpośredni) |
| Baza danych   | `devdb`     |
| Root hasło    | `rootpass`  |
| Użytkownik    | `testuser`  |
| Hasło         | `testpass`  |
| SSH user      | `tunnel`    |
| SSH hasło     | `tunnel`    |
| SSH port      | `22022`     |
| SSH klucz     | `ssh/keys/id_key` (bez passphrase) |
| SSH klucz z passphrase | `ssh/keys/id_keypass` (passphrase: `smokepass1`) |

> Klucze w `ssh/keys/` to fixtures wyłącznie do lokalnych testów — dają dostęp tylko do tego
> kontenera (ten sam poziom co jawne hasło `tunnel/tunnel` powyżej). Nie używać poza tym env.

## Inicjalizacja bazy

Przy pierwszym uruchomieniu automatycznie tworzona jest tabela `testowa` z przykładowymi danymi (skrypt `init/01-init.sql`).
