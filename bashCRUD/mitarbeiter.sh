#!/bin/bash
# Mitarbeiter-Verwaltung
# Ein Script von Bernhard Mehler (19-9-2014)

###########################
# Definition of variables #
###########################

menu="Hauptmenü"
menuoptions=("Alle Mitarbeiter anzeigen" "Neuen Mitarbeiter anlegen" "Einen Mitarbeiter ändern" "Einen Mitarbeiter löschen" "Menü verlassen")

###########################################################################################
#showMenu - zeigt das Menü an und gibt die Möglichkeit zur Auswahl verschiedener Optionen #
###########################################################################################

showMenu() {
    z=0
    auswahl=0
    clear
    echo "********************************"
    echo "*                              *"
    echo "*    Mitarbeiter-Verwaltung    *"
    echo "*                              *"
    echo "********************************"
    echo
    echo "${menu}"
    echo
    for option in "${menuoptions[@]}"
    do
        z=$(($z+1))
        echo "["$z"]" $option;
    done
    echo "Bitte wählen Sie aus:"
    read -e -i 1 auswahl

    if [ $auswahl -eq 1 ]
        then showList
    elif [ $auswahl -eq 2 ]
        then addEmployee
    elif [ $auswahl -eq 3 ]
        then updateEmployee
    elif [ $auswahl -eq 4 ]
        then removeEmployee
    elif [ $auswahl -eq 5 ]
        then exit;
    else
        echo "Falsche Eingabe - Goodbye"
    fi
}

##############################################################################################
#showList - zeigt die Mitarbeiter in der Listenansicht. Diese ist nach dem Vornamen sortiert #
##############################################################################################

showList() {
    clear
    echo
    echo "Mitarbeiterliste 2014 - nach Vornamen sortiert"
    echo
    cat mitarbeiter.dat | sort
    echo
    echo "Hauptmenü[0]"
    read auswahl 
    if [ $auswahl -eq 0 ]
        then showMenu
    fi
}

########################################################################
#addEmployee - fügt der Mitarbeiterliste einen neuen Mitarbeiter hinzu #
########################################################################

addEmployee() {
    eingabe="nein"
    clear
    echo "Einen neuen Mitarbeiter anlegen"
    echo
    while [ $eingabe != 'ja' ]; do
        echo "Mitarbeiter anlegen:"
        read mitarbeiter  
        echo $mitarbeiter >> mitarbeiter.dat
        echo "Wollen Sie die Eingabe beenden? [ja/nein]"
        read -e -i "ja" eingabe
    done
    if [ $eingabe == "ja" ]
        then showMenu
    fi
}

##########################################################################
#updateEmployee - aktualisert einen Mitarbeiter aus der Mitarbeiterliste #
##########################################################################

updateEmployee() {
    eingabe="nein"
    clear 
    echo "Einen Mitarbeiter aktualisieren"
    echo
    echo "Aktuelle Mitarbeiterliste"
    cat mitarbeiter.dat | sort 
    echo
    while [ $eingabe != 'ja' ]; do
        echo "Welchen Mitarbeiter wollen Sie ändern?"
        read mitarbeiter
        echo "Bitte geben Sie die Aktualisierung ein:"
        read update
        sed -i "s/$mitarbeiter/$update/" mitarbeiter.dat
        echo "Wollen Sie die Aktualisierung beenden? [ja/nein]"
        read -e -i "ja" eingabe
    done
    if [ $eingabe == "ja" ]
        then showMenu
    fi
}

#####################################################################
#removeEmployee - löscht einen Mitarbeiter aus der Mitarbeiterliste #
#####################################################################

removeEmployee() {
    eingabe="ja"
    clear
    echo "Einen Mitarbeiter löschen"
    echo 
    echo "Aktuelle Mitarbeiterliste"
    echo
    cat mitarbeiter.dat | sort
    echo
    while [ $eingabe != 'nein' ]; do
        echo "Welchen Mitarbeiter wollen Sie löschen?"
        read mitarbeiter
        echo "Sind Sie sicher, dass Sie $mitarbeiter löschen wollen? [ja/nein]"
        read -e -i "nein" delete
        if [ $delete == 'ja' ]
            then sed -i "/$mitarbeiter/d" mitarbeiter.dat
        fi
        echo "Wollen Sie einen anderen Mitarbeiter löschen? [ja/nein]"
        read -e -i "nein" eingabe
    done
    if [ $eingabe == 'nein' ]
        then showMenu
    fi
}

################################
# Intitialisiert das Hauptmenü #
################################
init() {
    if  ! [ -w "mitarbeiter.dat" ]
    then 
       touch mitarbeiter.dat
       chmod 744 mitarbeiter.dat
    fi
    showMenu
}

init
