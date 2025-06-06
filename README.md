# Besos Frontend 🎮✨

Besos Frontend to graficzny interfejs użytkownika (frontend) dla projektu **Besos**, zbudowany w silniku do gier **Godot Engine**.
Projekt zakłada modularną strukturę widoków i korzysta z mechanizmów oferowanych przez Godot do zarządzania scenami i instancjami.

## 💡 Architektura HTTP i modularność

Z powodu modularnej konstrukcji Besosa każda scena sama odpowiada za przetwarzanie zapytań HTTP.
Aby ułatwić to zadanie, projekt dostarcza specjalne komponenty i klasy bazowe, które upraszczają ten proces.

---

## 🧰 Kluczowe komponenty

### `progPanel`

* Dziedziczy po `Control`
* W metodzie `ready()` ustawia `custom_minimum_size` na bieżący `size`
* Zawiera metodę:

  ```gdscript
  set_label_text(nodeName: String, value: String)
  ```

  Która:

  * Wyszukuje dziecko typu `Label` o nazwie `nodeName`
  * Ustawia jego tekst na `value`

### `view`

* Dziedziczy po `Control`
* Zapewnia zautomatyzowany mechanizm wyświetlania odpowiedzi dla zapytań GET

#### Właściwości:

* `useDefaultLogic: bool` – czy używać wbudowanej logiki
* `endpoint: String` – adres endpointa do pobrania danych
* `defaultPanel: PackedScene` – prefab `progPanel`, który będzie używany do prezentacji danych
* `translationTable: Dictionary` – mapuje nazwy `Label` z `progPanel` na pola JSON
* `responseArrayName: String` – nazwa tablicy JSON z odpowiedzi serwera, zawierającej dane do wyświetlenia

#### Wymagane dzieci `view` (jeśli używamy domyślnej logiki):

* `VBoxContainer` o nazwie `VBoxContainer`
* `Label` o nazwie `errorLabel`
* Dowolny węzeł (np. `TextureRect`, `ProgressBar`) o nazwie `loading`
* `Button` o nazwie `returnButton`

---

## 🔎 Wymagana znajomość terminologii Godot

Aby sprawnie korzystać z projektu, przydatna będzie podstawowa znajomość pojęć z Godot Engine:

* **Node (węzeł)** – podstawowy blok budulcowy w silniku Godot.
* **Scene (scena)** – drzewo złożone z node'ów.
* **Instancja** – utworzenie obiektu (node'a) na podstawie sceny.
* **Changing scene (zmiana sceny)** – Godot operuje na jednej aktywnej scenie głównej, którą można dynamicznie zmieniać.

---

## 📆 Importowanie projektu

Aby zaimportować projekt do Godota:

1. Uruchom silnik Godot
2. Kliknij zakładkę `Import`
3. Wskaż folder z projektem
4. Wybierz plik `project.godot`

---

## 🛠️ Tworzenie builda

1. Uruchom projekt w Godot
2. Przejdź do `Project -> Export...`
3. Dodaj preset dla systemu Windows
4. Wybierz preset i kliknij `Export Project...`

---

## 📂 Struktura projektu

* Każdy **widok** to osobna scena (`.tscn`)
* W projekcie występują także **węzły globalne** odpowiedzialne za ogólną logikę:

  * `Globals` – przechowuje zmienne globalne
  * `SceneChanger` – odpowiada za zmianę aktywnej sceny
* Scena startowa: `main_menu.tscn`
* Przejście do innego widoku odbywa się poprzez zmianę sceny głównej
