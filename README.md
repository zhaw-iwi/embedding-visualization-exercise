# Übung 2: Embeddings, Chunking und PCA

Dieses Labor verwendet ausgewählte, seitenbeschriftete Passagen aus zwei offiziellen Abstimmungsbüchlein:

- `H2016`: Volksinitiative «Für Ehe und Familie – gegen die Heiratsstrafe», Abstimmung vom 28. Februar 2016
- `C2026`: Volksinitiative «Ja zu fairen Bundessteuern auch für Ehepaare», Abstimmung vom 29. November 2026

Die Teilnehmenden vergleichen drei vorbereitete Chunking-Strategien. Die Chunks, eine Frage und eine kurze Beispielantwort werden mit demselben mehrsprachigen Embedding-Modell eingebettet und gemeinsam in einer PCA-Karte dargestellt.

## Empfohlener Start: lokaler Docker-Container

### Was ihr vorher braucht

- Docker Desktop für Windows oder macOS beziehungsweise Docker Engine mit Compose unter Linux
- mindestens ungefähr 4 GB freier Speicherplatz
- beim ersten Start eine Internetverbindung zum Herunterladen des Python-Basis-Images und der Pakete
- den vollständigen Kursordner auf dem eigenen Computer

Python muss **nicht** lokal installiert werden. Beim ersten Start baut Docker das Image und installiert darin automatisch alle festgelegten Python-Abhängigkeiten aus `requirements.txt`. Die vorbereiteten Embeddings liegen bereits im Kursordner; für die Übung ist kein API-Key erforderlich.

### 1. Docker starten

Startet Docker Desktop und wartet, bis dort **Docker Desktop is running** angezeigt wird. Öffnet danach PowerShell beziehungsweise ein Terminal und prüft:

```text
docker --version
docker compose version
```

Beide Befehle müssen eine Versionsnummer ausgeben. Falls `docker` nicht gefunden wird, Docker Desktop schliessen, neu starten und das Terminal erneut öffnen.

### 2. Terminal im Kursordner öffnen

Der aktuelle Ordner muss der Repository-Stamm `CAS-HAIC-Slides` sein. Dort befinden sich unter anderem `README.md`, `.devcontainer` und `exercises`.

Windows: Im Datei-Explorer den Ordner `CAS-HAIC-Slides` öffnen, in die Adresszeile `powershell` schreiben und Enter drücken.

macOS/Linux: Ein Terminal öffnen und mit `cd` in den Ordner wechseln, beispielsweise:

```bash
cd ~/Downloads/CAS-HAIC-Slides
```

### 3. Container bauen und JupyterLab starten

Unter Windows, macOS und Linux wird derselbe Befehl verwendet:

```text
docker compose -f exercises/embedding_lab/compose.yaml up --build
```

Beim ersten Start lädt Docker das Python-Image und installiert die Abhängigkeiten. Das kann je nach Verbindung einige Minuten dauern. Spätere Starts verwenden den gebauten Container und sind deutlich schneller.

Das Terminal bleibt während der Übung geöffnet. Der Container führt zuerst automatisch

```text
python exercises/embedding_lab/scripts/prepare_lab.py --reuse-cache
```

aus und startet danach JupyterLab. Die Meldung

```text
Jupyter Server ... is running at:
```

zeigt, dass das Labor bereit ist.

### 4. Notebook im Browser öffnen

Öffnet diese Adresse:

<http://localhost:8888/lab/tree/exercises/embedding_lab/uebung_2_embeddings_pca.ipynb>

Es ist kein Token und kein Passwort nötig. Der Port ist nur auf dem eigenen Computer erreichbar.

Im Notebook:

1. Falls Jupyter nach einem Kernel fragt: **Python 3** wählen.
2. Im Menü **Run → Run All Cells** wählen.
3. Warten, bis links neben den Codezellen keine Sternchen `[*]` mehr stehen.
4. Nur die drei Werte in der Zelle **Einstellungen** verändern.
5. Nach jeder Änderung die Einstellungszelle und die beiden folgenden Analysezellen erneut ausführen – mit `Shift+Enter` oder dem ▶-Knopf.

Änderungen am Notebook werden direkt im Kursordner auf dem Computer gespeichert, weil dieser Ordner in den Container eingebunden ist.

### 5. Labor beenden

Im Terminal, in dem Jupyter läuft:

1. `Ctrl+C` drücken;
2. die Rückfrage gegebenenfalls mit `y` bestätigen;
3. danach aus dem Repository-Stamm ausführen:

```text
docker compose -f exercises/embedding_lab/compose.yaml down
```

Der Kursordner und gespeicherte Notebook-Änderungen bleiben erhalten. Beim nächsten Mal genügt derselbe Startbefehl aus Schritt 3.

### Häufige Probleme

**`docker` wird nicht gefunden:** Docker Desktop vollständig starten und danach ein neues Terminal öffnen.

**Verbindung zu Docker nicht möglich:** Prüfen, ob Docker Desktop noch startet oder eine Fehlermeldung anzeigt.

**Port 8888 ist bereits belegt:** Einen früheren Jupyter- oder Docker-Prozess beenden. Mit `docker ps` prüfen, welche Container laufen.

**Die Browserseite lädt nicht:** Im Terminal auf die Meldung warten, dass der Jupyter Server läuft. Danach die Adresse erneut öffnen.

**Eine Notebook-Zelle zeigt einen Fehler:** Zuerst **Kernel → Restart Kernel and Run All Cells** wählen. Bleibt der Fehler bestehen, Container mit `Ctrl+C` stoppen und den Startbefehl erneut ausführen.

## Alternative: GitHub Codespaces

1. Repository in Codespaces öffnen.
2. Als Dev-Container-Konfiguration **CAS HAIC – Embedding-Labor** wählen.
3. `exercises/embedding_lab/uebung_2_embeddings_pca.ipynb` öffnen.
4. Als Kernel **Python 3** wählen und **Run → Run All Cells** ausführen.

## Nur für die Vorbereitung: Artefakte neu erzeugen

Im Container:

```bash
python exercises/embedding_lab/scripts/prepare_lab.py
python exercises/embedding_lab/scripts/make_notebook.py
```

Die Daten entstehen unter `data/processed/`, die HTML- und PNG-Ansichten unter `output/`.

## Didaktisch wichtige Grenze

Die Rangliste wird mit Kosinusähnlichkeit in allen 384 Dimensionen berechnet. Die zweidimensionale PCA ist nur eine Projektion zur Anschauung. Sichtbare Abstände in der Karte dürfen deshalb nicht als Retrieval-Rang oder als Wahrscheinlichkeit für Wahrheit interpretiert werden.
