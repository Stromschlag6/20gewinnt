#!/bin/bash

#Marco Auer 16-05-2024

# Ein Spiel bei welchem man die Summe der Zahl, welche man will eingibt
# und nach gewissen kriterien auf 20 kommen muss.

# Farben definieren
WHITE='\033[47m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BLINK='\033[5m'
NC='\033[0m' # No Color

echo "Willkommen bei 20 Gewinnt!"
echo "Du musst die 20 erreichen in dem du die Summe von dem aktuellen Spielstand + 1 oder + 2 eingibst"

current_number=0

# Funktion, um den Zug des Computers auszuführen
computer_move() {
    remainder=$(( current_number % 3 ))

    if [[ $remainder -eq 0 ]] ; then
        current_number=$(( current_number + 2 ))
    else
        current_number=$(( current_number + 1 ))
    fi

    echo "Der Computer spielt $current_number."
}

# Funktion, um den Spielerzug auszuführen
player_move() {
    read -p "Dein Zug: " move

    # Überprüfe die Gültigkeit des Spielzugs des Spielers
    if !  (($move == ((current_number + 1))||$move == ((current_number + 2)))) ; then
        echo -e "${RED}${WHITE}${BLINK}Ungültige Eingabe! Bitte gib die Summe vom aktuellen Spielstand + 1 oder 2 ein.${NC}"
        player_move
    fi

    current_number=$move
}

# Runden-Schleife
while ((current_number < 20)); do
    computer_move

    if ((current_number > 17)); then
        echo -e "${RED}${BLINK}Der Computer gewinnt.${NC}"
        break
    fi

    if ((current_number == 20)); then
        echo -e "${GREEN}${WHITE}${BLINK}Herzlichen Glückwunsch! Du hast gewonnen!${NC}"
        break
    fi
    
    player_move
done