# Periodensystem der Elemente

Interaktives Periodensystem mit allen 118 Elementen — verfügbar als **Web-Seite** und als **native macOS-App**.

Datenumfang pro Element:
- Namen in vier Sprachen (Deutsch, Französisch, Englisch, Latein)
- Atomarer Aufbau (Protonen, Neutronen, Elektronen, Atommasse, Ordnungszahl)
- Aggregatzustand bei 20 °C, Schmelz- und Siedepunkt (in °C und K)
- Technische Anwendungen mit Schwerpunkt **Elektrotechnik**
- Häufige chemische Verbindungen

> **Web-Version:** <https://temmchen.github.io/Periodensystem/> — läuft direkt im Browser, keine Installation.

---

## Inhaltsverzeichnis

1. [Schnellstart: macOS-App herunterladen](#schnellstart-macos-app-herunterladen)
2. [Erster Start (Gatekeeper)](#erster-start-gatekeeper)
3. [Bedienung der App](#bedienung-der-app)
4. [Alternative: selbst kompilieren](#alternative-selbst-kompilieren)
5. [Projektstruktur](#projektstruktur)
6. [Fehlerbehebung](#fehlerbehebung)
7. [Credits](#credits)

---

## Schnellstart: macOS-App herunterladen

**Voraussetzungen:**
- Mac mit **macOS 13 (Ventura)** oder neuer
- **Apple-Silicon-Mac** (M1/M2/M3/M4 — also alle modernen Macs inkl. Mac Studio)
- Kein Xcode, kein Terminal, keine Entwickler-Tools nötig

### Schritt 1 — Download von GitHub Actions

1. Gehe zu <https://github.com/temmchen/Periodensystem/actions>
2. Klick auf den neuesten erfolgreichen Lauf von **„Build macOS app"** (grüner Haken)
3. Scrolle bis ganz nach unten zum Abschnitt **„Artifacts"**
4. Klick auf **`Periodensystem-macOS`** — eine `.zip`-Datei wird in deinen Downloads-Ordner geladen

> Falls die Liste leer ist oder du den Lauf manuell auslösen willst: oben auf dem Actions-Tab links auf **„Build macOS app"** klicken, dann rechts **„Run workflow" → „Run workflow"**. Nach 3-5 Min ist er fertig.

### Schritt 2 — Entpacken

Du hast jetzt eine `Periodensystem-macOS.zip`. Doppelklick darauf entpackt sie und du bekommst:

```
Periodensystem.app.zip
```

Doppelklick auch auf diese zweite `.zip` — danach hast du die fertige App:

```
Periodensystem.app
```

> Ja, das ist eine geschachtelte ZIP. Das ist Absicht: die innere Datei wird mit `ditto` gepackt, damit macOS das App-Bundle korrekt erkennt. Die äußere ZIP fügt GitHub automatisch hinzu.

### Schritt 3 — Installieren

Ziehe `Periodensystem.app` in den **Programme**-Ordner (`/Applications`). Fertig.

Doppelklick zum Starten.

---

## Erster Start (Gatekeeper)

> **Wichtig:** Beim allerersten Start zeigt macOS sehr wahrscheinlich eine Warnung wie:
>
> *„Periodensystem.app kann nicht geöffnet werden, da Apple sie nicht auf Schadsoftware überprüfen konnte"* oder
> *„Die App ist beschädigt und kann nicht geöffnet werden"*.

Das ist **kein Defekt**, sondern Apples Gatekeeper. Die App ist nur ad-hoc signiert (kein 99 $/Jahr Apple-Developer-Account hinter dem Build). Du hast drei Möglichkeiten, sie trotzdem zu starten — alle sind ungefährlich, weil du den Quellcode hier siehst:

### Variante A — Rechtsklick (am einfachsten, einmal nötig)

1. **Rechtsklick** (oder Ctrl-Klick) auf `Periodensystem.app`
2. Im Kontextmenü **„Öffnen"** wählen
3. Im Dialog nochmal **„Öffnen"** bestätigen

Danach erkennt macOS die App und du kannst sie immer per Doppelklick starten.

### Variante B — Systemeinstellungen

1. App per Doppelklick starten (es kommt die Warnung)
2. **Systemeinstellungen → Datenschutz & Sicherheit** öffnen
3. Ganz nach unten scrollen, dort steht *„Periodensystem.app wurde blockiert…"*
4. Auf **„Trotzdem öffnen"** klicken

### Variante C — Terminal (Quarantäne entfernen)

Falls die Warnung *„App ist beschädigt"* lautet, hat macOS das Quarantäne-Attribut gesetzt. Im Terminal:

```bash
xattr -dr com.apple.quarantine /Applications/Periodensystem.app
```

Danach normal per Doppelklick starten.

---

## Bedienung der App

| Aktion | Effekt |
| --- | --- |
| **Klick auf ein Element** | Detail-Dialog mit allen Infos |
| **Hover** über eine Zelle | Zelle wächst leicht und wirft Schatten |
| **Klick auf „57-71 La-Lu"** bzw. **„89-103 Ac-Lr"** | Öffnet das erste Element der Reihe (Lanthan / Actinium). Die einzelnen Lanthanoide und Actinoide sind in den zwei Zeilen unter der Haupttabelle direkt klickbar. |
| **Esc** oder **⌘W** | Detail-Dialog schließen |
| **⌘Q** | App beenden |

Die App funktioniert komplett offline und braucht keine Netzwerkverbindung.

---

## Alternative: selbst kompilieren

Falls du den Build selbst machen willst (z. B. nach lokalen Änderungen):

### Voraussetzungen

- macOS 13+
- Entweder **Xcode 15+** (App Store) **oder** die schlanken Command-Line-Tools:
  ```bash
  xcode-select --install
  ```

### Variante 1 — Mit Xcode (grafisch)

1. Repo klonen oder als ZIP herunterladen
2. In Xcode **File → Open…** und `macos-app/Package.swift` auswählen
3. Schema **Periodensystem** und Ziel **My Mac** wählen (oben in der Toolbar)
4. **⌘R** drücken

Xcode startet die App im Debug-Modus. Beim ersten Mal lädt es Swift-Abhängigkeiten — kann eine Minute dauern.

### Variante 2 — Im Terminal

```bash
git clone https://github.com/temmchen/Periodensystem.git
cd Periodensystem/macos-app
./build_app.sh
open Periodensystem.app
```

Das Skript:
- baut den Release-Build mit Swift Package Manager
- erzeugt das `.app`-Bundle mit `Info.plist`
- signiert es ad-hoc, damit Gatekeeper es akzeptiert
- legt `Periodensystem.app` direkt im `macos-app/`-Ordner ab

Installieren per:
```bash
cp -R Periodensystem.app /Applications/
```

---

## Projektstruktur

```
Periodensystem/
├── index.html                              Web-Version (GitHub Pages)
├── README.md                               dieses Dokument
├── .github/workflows/
│   └── build-macos-app.yml                 CI: baut & verpackt die App auf macOS-Runner
└── macos-app/                              native SwiftUI-App
    ├── Package.swift                       SPM-Definition (Swift 5.9, macOS 13+)
    ├── build_app.sh                        Build-Script: SPM → .app-Bundle
    ├── README.md                           Entwickler-README
    └── Sources/Periodensystem/
        ├── PeriodensystemApp.swift         @main Entry-Point
        ├── ContentView.swift               Wurzel-View, Hintergrundverlauf, Sheet-Logik
        ├── PeriodicTableView.swift         18×7-Grid + Lanthanoide/Actinoide-Zeilen
        ├── ElementCellView.swift           Einzelne Zelle inkl. Hover-Effekt
        ├── ElementDetailView.swift         Detail-Sheet (5 Sektionen)
        ├── LegendView.swift                Kategorien-Legende (Capsule-Badges)
        ├── FlowLayout.swift                Wrap-Layout für die Legende
        ├── Element.swift                   Datenmodell: Element + ElementCategory
        ├── ElementsData.swift              Aggregator: liefert alle 118 Elemente
        ├── ElementsData_1_30.swift         Wasserstoff (H) bis Zink (Zn)
        ├── ElementsData_31_60.swift        Gallium (Ga) bis Neodym (Nd)
        ├── ElementsData_61_90.swift        Promethium (Pm) bis Thorium (Th)
        └── ElementsData_91_118.swift       Protactinium (Pa) bis Oganesson (Og)
```

Die Element-Daten wurden aus `index.html` (dem JavaScript-Objekt) automatisch in Swift-Strukturen übersetzt. Die Web-Version bleibt damit die Quelle der Wahrheit für Inhalte.

---

## Fehlerbehebung

### „Die App ist beschädigt und kann nicht geöffnet werden"

Quarantäne-Attribut entfernen:
```bash
xattr -dr com.apple.quarantine /Applications/Periodensystem.app
```

### „App stammt von einem nicht verifizierten Entwickler"

Rechtsklick auf die App → **Öffnen** → im Dialog nochmal **Öffnen**. Siehe [Erster Start](#erster-start-gatekeeper).

### Beim Doppelklick passiert gar nichts

Stelle sicher, dass dein Mac Apple Silicon hat (M1 oder neuer). Im Apple-Menü → **Über diesen Mac** prüfen. Der CI-Build erzeugt ein arm64-Binary; Intel-Macs würden eine andere Build-Konfiguration brauchen.

Falls du einen Intel-Mac hast, bau die App lokal:
```bash
cd macos-app && ./build_app.sh
```

### GitHub Actions zeigt keinen erfolgreichen Build

- Prüfe <https://github.com/temmchen/Periodensystem/actions>
- Falls Builds rot sind: ich (Claude) bin in der PR eingebunden und reagiere auf CI-Fehler — schreib einfach in den PR oder mir
- Falls noch nie ein Build lief: oben links auf **„Build macOS app"** → rechts **„Run workflow"** → Branch wählen → **„Run workflow"** klicken

### Xcode öffnet das Package, aber das Run-Schema fehlt

Erstes Mal nach dem Öffnen dauert es einen Moment — Xcode muss die Pakete auflösen. Warte bis oben in der Toolbar links das Schema-Dropdown von „No Scheme" auf **Periodensystem** wechselt. Falls das nicht passiert: **Product → Scheme → Periodensystem** manuell auswählen.

### App startet, aber Fenster ist winzig oder leer

Fenster größer ziehen (Mindestgröße ist 1100 × 760, aber je nach Skalierung sieht es darunter komisch aus). Falls weiterhin leer: in Konsole.app nach „Periodensystem" filtern und schauen, ob ein Crash-Log existiert.

### Update der App

GitHub Actions baut die App bei jedem Push auf `main` oder `claude/**` neu. Lade einfach den neuesten Artifact und ersetze die alte `.app` in `/Applications`.

---

## Credits

- **Inhalte & Web-Version:** © Tom BLEYER, 05/2026 — Alle Rechte vorbehalten
- **macOS-App-Portierung:** SwiftUI-Implementierung, getreu am Original-Layout und -Farbschema
- **Lizenz:** siehe Repository-Inhaber

Bei Fragen oder Bugs einen Issue auf GitHub eröffnen: <https://github.com/temmchen/Periodensystem/issues>
