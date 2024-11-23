#!/bin/bash
LANG=de_DE.UTF-8
PATH=/usr/local/bin:/usr/bin:/bin

# Pfad zur JSON-Datei
dataFile="/windusterdata/Nachtessen_Woche.json"

# Überprüfen, ob die JSON-Datei existiert
if [[ ! -f "$dataFile" ]]; then
    echo "Die Datei $dataFile existiert nicht."
    exit 1
fi

# Setze die Umgebungsvariable für die deutsche Sprache, damit `date` die Wochent                                                                                                                                   age auf Deutsch gibt
export LANG=de_DE.UTF-8

# Aktuellen Wochentag ermitteln (z.B. "Montag", "Dienstag", ...)
currentDay=$(date +%A)

# Erstelle eine Nachricht
message="Eintraege fuer heute, $currentDay:\n\n"

# Benutzernamen der Familienmitglieder
family_members=("Mami" "Papi" "Yasmin" "Isabelle")

# Iteriere über die Familienmitglieder und extrahiere die Einträge für den aktue                                                                                                                                   llen Tag
for member in "${family_members[@]}"; do
    # Überprüfen, ob der Eintrag für den aktuellen Tag vorhanden ist (mit jq)
    entry=$(jq -r ".\"$member\".\"$currentDay\"" "$dataFile")

    if [[ "$entry" == "yes" ]]; then
        entry_text="ja"
    elif [[ "$entry" == "no" ]]; then
        entry_text="nein"
    else
        entry_text="kein Eintrag"
    fi

    # Füge die Informationen zum Nachrichtentext hinzu
    message+="$member: $entry_text\n"
done

# E-Mail-Empfänger (hier Beispiel-E-Mail-Adresse anpassen)
emailRecipient="roger.aeppli@aeppli.org,mauricelia@aeppli.org,yasmin@aeppli.org,                                                                                                                                   isabelle@aeppli.org"
emailSubject="Familien Abendessen Plan fuer $currentDay"

heute=$(date +%A," "%d.%m.%4Y)
# Sende die E-Mail mit der Nachricht
echo -e "Subject: Anwesenheiten Nachtessen $heute\n\n$message" | /usr/sbin/ssmtp                                                                                                                                    "$emailRecipient"

echo "Die E-Mail wurde erfolgreich gesendet."
root@www-5ddcc5bf49-4845f:/var/www/html/winduster# cat Planner.php
<?php
// Datei zur Speicherung der Daten
$dataFile = '/windusterdata/Nachtessen_Woche.json';

// Wenn das Formular abgesendet wird, die Daten speichern
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents($dataFile), true);

    // Update der Daten basierend auf den Formularfeldern
    foreach ($_POST['family_members'] as $member => $days) {
        foreach ($days as $day => $value) {
            $data[$member][$day] = $value;
        }
    }

    // Speichern der Daten in der JSON-Datei
    file_put_contents($dataFile, json_encode($data, JSON_PRETTY_PRINT));
}

// Lade die gespeicherten Daten (falls vorhanden)
if (file_exists($dataFile)) {
    $data = json_decode(file_get_contents($dataFile), true);
} else {
    // Initialisieren, falls die Datei noch nicht existiert
    $data = [
        'Mami' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', 'Do                                                                                                                                   nnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no'],
        'Papi' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', 'Do                                                                                                                                   nnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no'],
        'Yasmin' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', '                                                                                                                                   Donnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no'],
        'Isabelle' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no',                                                                                                                                    'Donnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no']
    ];
}

?>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Familien Nachtessen</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 80%;
            max-width: 900px; /* Maximalbreite für den Container */
            margin: 20px auto; /* Zentrieren des Containers */
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%; /* Tabelle nimmt die volle Breite des Containers ein */
            border-collapse: collapse;
            margin-top: 0; /* Kein zusätzlicher Abstand oben */
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        input[type="radio"] {
            margin: 0 10px;
        }

        button {
            background-color: #4CAF50; /* Grüne Schaltfläche */
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Familien Abendessen Plan</h1>
    <form method="post">
        <table>
            <thead>
                <tr>
                    <th>Wochentag</th>
                    <th>Mami</th>
                    <th>Papi</th>
                    <th>Yasmin</th>
                    <th>Isabelle</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $days = ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freita                                                                                                                                   g', 'Samstag', 'Sonntag'];
                foreach ($days as $day) {
                    echo "<tr>";
                    echo "<td>$day</td>";
                    foreach ($data as $member => $daysData) {
                        // Wenn der Wert leer ist, setzen wir "no" als Standard
                        $value = $daysData[$day] ?? 'no';
                        $yesChecked = $value === 'yes' ? 'checked' : '';
                        $noChecked = $value === 'no' ? 'checked' : '';

                        echo "<td>
                                <label>
                                    <input type='radio' name='family_members[$me                                                                                                                                   mber][$day]' value='yes' $yesChecked> Ja
                                </label>
                                <label>
                                    <input type='radio' name='family_members[$me                                                                                                                                   mber][$day]' value='no' $noChecked> Nein
                                </label>
                              </td>";
                    }
                    echo "</tr>";
                }
                ?>
            </tbody>
        </table>
        <div style="text-align:center;">
            <button type="submit">Speichern</button>
        </div>
    </form>
</div>

</body>
</html>
