## Uruchamianie aplikacji

### AndroidSDK

* Otwórz projekt w AndroidStudio
* Kliknij w przycisk "Build variants" w menu po lewej stronie
* Zmień "Active build variant" na "Release"
* Z menu wybierz: Run -> Run 'app'

### SwiftUI

* Otwórz projekt w XCode.
* Z menu wybierz: Product -> Scheme -> Edit scheme
* Zmień "Build configuration" na "Release"
* Wciśnij przycisk "Build and then run current scheme"

### ReactNative

Dla systemu iOS:
```
npx react-native run-ios --configuration Release --device
```

Dla systemu Android:
```
npx react-native run-android --variant=release
```

### Flutter

```
flutter run --release
```

## Zmiana parametrów testów

### Testy algorytmów

Po uruchomieniu aplikacja wybieramy algorytm, który chcemy przetestować z listy i wciskamy przycisk "Start". Test zostanie przeprowadzony autmatycznie, a wynik ukaże się na ekranie.

### Testy tnterfejsu użytkownika

Przed zbudowaniem aplikacji, w głównym pliku danego projektu można dostować typ testu. 

Zmienna `testType` określa jaki to rodzaj testu i może przyjąć następujące wartości:
* Visibility - test dodawania i usuwania elementów
* Swap - test zamiany kolejności elementów
* FullRebuild - test pełnej przebudowu interfejsu
* NoChange - test wydajności renderowania bez zmian interfejsu

Dodatkowo zmienną `componentType`, możemy określić testowany komponent. Do wyboru są `Text` oraz `Button`.

Po zbudowaniu i uruchomieniu aplikacji test zostanie automatycznie przeprowadzony, a wynik ukaże się na ekranie.

### Test rysowania fraktala

Przed zbudowaniem aplikacji, w głównym pliku danego projektu można dostować parametry testu tj. wymiary renderowanego fraktala. By tego dokonać, należy zmienić wartość zmiennych `width` oraz `height`.
Po uruchomieniu odczyt klatek na sekundę pojawi się w konsoli.

### Test rysowania prymitywów

Przed zbudowaniem aplikacji, w głównym pliku danego projektu można dostować parametry. Zmienna `mode` określa typ testu. Przyjmuje dwie wartości: `ovals` albo `rects` kolejno dla testu rysowania okręgów i dla testu rysowania kwadratów z rotacją. Zmienna `numberOfShapes` określa liczbę rysowanych prymitywów na ekranie. Po uruchomieniu aplikacji odczyt klatek na sekundę pojawi się w konsoli.