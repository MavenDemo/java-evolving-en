#!/usr/bin/env bash
clear

run() {
  echo -e "\e[1m\$ $*\e[0m"
  $*
}

readline() {
  echo ""
  echo -e "\e[32m// $*\e[0m"
  read
}

readline "compilation avec un JDK 8 et Maven configuré pour générer du bytecode Java 7..."
j8
run mvn clean compile

readline "puisque bytecode Java 7, exécution en JRE 7..."
j7
run java -showversion -cp target/classes animalsniffer.Main Maven is mega cool

readline "exécution en JRE 8..."
j8
run java -showversion -cp target/classes animalsniffer.Main Maven is mega cool



readline "Animal Sniffer à la rescousse pour valider que nous utilisons les bonnes APIs..."
run mvn clean install -Panimal


readline "Animal sniffer via enforcer..."
run mvn clean install -Panimal-enforcer
