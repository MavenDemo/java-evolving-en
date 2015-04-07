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
  echo ""
  echo -e "\\033[31m[...]\\033[0m"
  read
}

commentaire "build et exécution classiques en JDK/JRE 7..."
j7
run mvn -V clean package exec:exec javadoc:javadoc

enter

clear
commentaire "profil toolchain => Maven s'exécute en JRE 7 mais utilise un JDK pour les plugins toolchain-aware..."
run mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain

enter

clear
commentaire "test cas d'erreur: version de JDK qui n'est pas configurée dans les toolchains..."
run mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain-jdk5
