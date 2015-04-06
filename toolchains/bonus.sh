#!/usr/bin/env bash
clear

run() {
  echo -e "\\033[1m\$ $*\\033[0m"
  $*
}

readline() {
  echo ""
  echo -e "\\033[32m// $*\\033[0m"
  read
}

readline "démo bonus cas étonnant : la compilation avec un JDK 8 crée une dépendance à l'API JDK 8..."
j8
run mvn -V clean package exec:exec javadoc:javadoc
readline "Animal Sniffer détecte le problème (même s'il plante lamentablement avec un NPE)..."
j7
run java -cp target/classes toolchains.Main
readline "le problème est bien détecté par Animal Sniffer, mais cela ne le résoud pas: seul toolchain le peut..."


readline "autre bonus : on peut exécuter jdeps du JDK 8/9 alors que Maven utilise JDK 7 (nécessite Maven 3.3)..."
run mvn -V clean package exec:exec javadoc:javadoc -Pjdeps
