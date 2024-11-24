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
        'Mami' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', 'Donnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no'],
        'Papi' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', 'Donnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no'],
        'Yasmin' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', 'Donnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no'],
        'Isabelle' => ['Montag' => 'no', 'Dienstag' => 'no', 'Mittwoch' => 'no', 'Donnerstag' => 'no', 'Freitag' => 'no', 'Samstag' => 'no', 'Sonntag' => 'no']
    ];
}

?>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anwesenheitsplan Nachtessen</title>
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
    <h1>Anwesenheitsplan Nachtessen</h1>
<?php
   $heute = file_get_contents("/windusterdata/Nachtessen_heute.txt");
   echo "$heute<br/>";
?>
    <h2>Weitere Planung</h2>
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
                $days = ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'];
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
                                    <input type='radio' name='family_members[$member][$day]' value='yes' $yesChecked> Ja
                                </label>
                                <label>
                                    <input type='radio' name='family_members[$member][$day]' value='no' $noChecked> Nein
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
