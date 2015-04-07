#!/usr/bin/env bash

clear

run() {
  echo -e "\\033[1m\$ $*\\033[0m"
  $*
}

commentaire() {
  echo ""
  echo -e "\\033[32m# $*\\033[0m"
}

enter() {
  echo -en "\\033[31m[...]\\033[0m"
  read
}

commentaire "compilation avec un JDK 8 et Maven configuré pour générer du bytecode Java 7..."
j8
run mvn clean compile

commentaire "et puisque bytecode Java 7, exécution en JRE 7..."
j7
run java -cp target/classes animalsniffer.Main Maven is mega cool
commentaire "plante lors de l'appel d'une API JDK 8..."

enter

commentaire "ne fonctionne qu'en JRE 8..."
j8
run java -showversion -cp target/classes animalsniffer.Main Maven is mega cool

enter

clear
commentaire "Animal Sniffer à la rescousse pour valider que nous utilisons les bonnes APIs..."
run mvn clean install -Panimal


enter

clear
commentaire "Animal sniffer via enforcer..."
run mvn clean install -Panimal-enforcer
