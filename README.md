# Geeruh

## Konfiguracja projektu i środowiska programistycznego

System wspomagania zarządzania projektami i śledzenia błędów.

### Instalacja fluttera
[Instrukcja](https://docs.flutter.dev/get-started/install)


### Środowiska

Geeruh wspiera obecnie 3 platformy: Linux, Windows oraz Web. W przypadku Windowsa i Linuksa budowane są odpowiednie pliki wykonywalne. Dla platformy webowej tworzony jest plik JS, którego można uruchomić poprzez `python3 -m http.server` w katalogu /build/web. Aplikacja będzie dostępna pod adresem [http://localhost:8000](http://localhost:8000)

### Budowanie projektu

```sh
flutter run build_runner build --delete-conflicting-outputs
```

### Uruchamianie projektu

```sh
flutter run lib/main.dart
```

Użytkownik zostanie poproszony o wybranie środowiska uruchomieniowego, jeśli dostępne jest więcej niż jedno.

### Testy

1. Jednostkowe: 
    ```sh
    flutter test test/widget_test.dart
    ```
2. Integracyjne:
    ```sh
    flutter config --enable-linux-desktop
    xvfb-run flutter test integration_test/automatic_test.dart -d Linux
    ```
\* zamiast buildu Linux można wybrać dowolny preferowany
