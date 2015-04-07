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

show() {
  echo -en "\\033[92m"
  $*
  echo -en "\\033[0m"
}

commentaire "cas étonnant : la compilation avec un JDK 8, du fait d'optimisation aggressives, crée une dépendance à l'API JDK 8..."
j8
run mvn -V clean package exec:exec javadoc:javadoc
commentaire "Animal Sniffer détecte le problème (même s'il plante lamentablement avec un NPE)..."

enter

commentaire "L'exécution avec un JRE 7 montre plus clairement le problème (qui ne provient pas du source)..."
j7
run java -cp target/classes toolchains.Main

commentaire "le problème est bien détecté par Animal Sniffer, mais cela ne le résoud pas."
commentaire "il faut donc faire attention à ne jamais compiler ce code source avec un JDK 8..."
commentaire "les toolchains permettent d'être sûrs de l'éviter..."

enter

clear
commentaire "bonus : alors que Maven utilise un JDK 7, on peut exécuter jdeps du JDK 8/9 (nécessite Maven 3.3)..."
show grep -B 2 -A 13 maven-jdeps-plugin pom-toolchain-jdeps.xml
run mvn -V clean package exec:exec javadoc:javadoc -f pom-toolchain-jdeps.xml
