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

# Setze die Umgebungsvariable für die deutsche Sprache, damit `date` die Wochentage auf Deutsch gibt
export LANG=de_DE.UTF-8

# Aktuellen Wochentag ermitteln (z.B. "Montag", "Dienstag", ...)
currentDay=$(date +%A)

# Erstelle eine Nachricht
message=""
#Eintraege fuer heute, $currentDay:\n\n"

# Benutzernamen der Familienmitglieder
family_members=("Mami" "Papi" "Yasmin" "Isabelle")

# Iteriere über die Familienmitglieder und extrahiere die Einträge für den aktuellen Tag
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
    message+="$member: $entry_text;\n"
done

# E-Mail-Empfänger (hier Beispiel-E-Mail-Adresse anpassen)
#emailRecipient="roger.aeppli@aeppli.org,mauricelia@aeppli.org,yasmin@aeppli.org,isabelle@aeppli.org"
emailRecipient="roger.aeppli@aeppli.org"
emailSubject="Familien Abendessen Plan fuer $currentDay"

heute=$(date +%A," "%d.%m.%4Y)
# Sende die E-Mail mit der Nachricht
echo -e "Subject: Anwesenheiten Nachtessen $currentDay\n\n$heute\n$message" | /usr/sbin/ssmtp "$emailRecipient"
echo -e "Heute ($heute) an/abwesend:\n$message" > /windusterdata/Nachtessen_heute.txt

echo "Die E-Mail wurde erfolgreich gesendet."
