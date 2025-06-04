# Besos Frontend 🎮✨

Besos Frontend to graficzny interfejs użytkownika (frontend) dla projektu **Besos**, zbudowany w silniku do gier **Godot Engine**.  
Projekt zakłada modularną strukturę widoków i korzysta z mechanizmów oferowanych przez Godot do zarządzania scenami i instancjami.

## 🧠 Wymagana znajomość terminologii Godot

Aby sprawnie korzystać z projektu, przydatna będzie podstawowa znajomość pojęć z Godot Engine:

- **Node (węzeł)** – podstawowy blok budulcowy w silniku Godot.
- **Scene (scena)** – drzewo złożone z node'ów.
- **Instancja** – utworzenie obiektu (node'a) na podstawie sceny.
- **Changing scene (zmiana sceny)** – Godot operuje na jednej aktywnej scenie głównej, którą można dynamicznie zmieniać.

## 📦 Importowanie projektu

Aby zaimportować projekt do Godota:

1. Uruchom silnik Godot.
2. Kliknij zakładkę `Import`.
3. Wskaż folder z projektem.
4. Wybierz plik `project.godot`.

## 🛠️ Tworzenie builda

Aby stworzyć build:

1. Uruchom projekt w Godot.
2. Przejdź do `Project -> Export...`.
3. Dodaj preset dla systemu Windows.
4. Wybierz preset i kliknij `Export Project...`.

🖼️ _Zobacz: [obrazek 1]_ (tu możesz dodać link do screena, jeśli chcesz go wrzucić na repo)

## 🗂️ Struktura projektu

Projekt **Besos Frontend** ma modularną strukturę:

- Każdy **widok** to osobna scena (`.tscn`).
- Istnieją również tzw. **węzły globalne**, służące do zarządzania wspólnymi funkcjonalnościami.

Scena startowa to: `main_menu.tscn`  
Aby przejść do innego widoku, należy zmienić aktywną scenę główną w silniku.