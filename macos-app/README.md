# Periodensystem – macOS-App

Native SwiftUI-App für das Periodensystem der Elemente. Alle 118 Elemente, vier Sprachen (Deutsch, Französisch, Englisch, Latein), Aggregatzustände, Schmelz- und Siedepunkte, technische Anwendungen mit Schwerpunkt Elektrotechnik sowie häufige chemische Verbindungen.

Die Daten und das Farbschema entsprechen 1:1 der Web-Version unter <https://temmchen.github.io/Periodensystem/>.

## Voraussetzungen

- macOS 13 (Ventura) oder neuer
- Xcode 15+ **oder** die Command-Line-Tools (`xcode-select --install`)

## Bauen & Starten

Es gibt zwei Wege – wähle, was dir lieber ist.

### Variante A – Mit Xcode (Doppelklick & Run)

1. Den Ordner `macos-app` lokal auschecken.
2. In Xcode öffnen: **File → Open…** und `macos-app/Package.swift` wählen. Xcode lädt das Swift-Package automatisch als Projekt.
3. Oben links das Schema **Periodensystem** auswählen, Ziel **My Mac**.
4. **⌘R** drücken. Das Fenster öffnet sich.

### Variante B – Im Terminal (eigenständiges `.app`-Bundle)

```bash
cd macos-app
./build_app.sh
open Periodensystem.app
```

Das Skript baut den Release-Build, erzeugt das App-Bundle, fügt eine Ad-hoc-Code-Signatur hinzu und du erhältst eine eigenständige `Periodensystem.app`, die du z. B. nach `/Applications` kopieren kannst:

```bash
cp -R Periodensystem.app /Applications/
```

## Bedienung

- Klick auf ein Element öffnet den Detail-Dialog mit Namen, Atomaufbau, Aggregatzustand, Anwendungen und Verbindungen.
- Der Platzhalter „La-Lu" / „Ac-Lr" öffnet das jeweils erste Element der Reihe; alle Lanthanoide und Actinoide sind in den unteren beiden Zeilen einzeln klickbar.
- **Esc** oder **⌘W** schließt den Dialog.

## Projektstruktur

```
macos-app/
├── Package.swift                          Swift-Package-Definition
├── build_app.sh                           Baut .app-Bundle aus dem SPM-Build
├── README.md
└── Sources/Periodensystem/
    ├── PeriodensystemApp.swift            @main App-Entry
    ├── ContentView.swift                  Wurzel-View, Hintergrund, Sheet
    ├── PeriodicTableView.swift            18×7-Grid + Lanthanoide/Actinoide
    ├── ElementCellView.swift              Einzelne Zelle inkl. Hover-Effekt
    ├── ElementDetailView.swift            Detail-Sheet (Namen, Atom, Anwendungen, Verbindungen)
    ├── LegendView.swift                   Kategorien-Legende oben
    ├── FlowLayout.swift                   Wrap-Layout für die Legende
    ├── Element.swift                      Datentypen (Element, ElementCategory)
    └── ElementsData.swift                 Auto-generiert aus index.html – 118 Einträge
```

## Daten aktualisieren

`Sources/Periodensystem/ElementsData.swift` wurde aus dem JS-Objekt in `index.html` generiert. Wenn du in der HTML einen Wert änderst, kannst du die Swift-Datei mit dem Konverterskript (siehe Commit-History) neu erzeugen oder von Hand anpassen.
