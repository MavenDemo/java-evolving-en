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

readline "build avec JDK 9..."
j9
run mvn -V clean package exec:exec javadoc:javadoc
readline "failure: JDK 9 refuse -target 1.5, trop ancien..."


readline "build et exécution en JDK/JRE 7..."
j7
run mvn -V clean package exec:exec javadoc:javadoc


readline "profil toolchain => compilation JDK 6, Maven reste JRE 7..."
run mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain


readline "test cas d'erreur: version de JDK qui n'est pas configurée dans les toolchains..."
run mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain-jdk5


readline "démo bonus cas étonnant : la compilation avec un JDK 8 crée une dépendance à l'API JDK 8..."
j8
run mvn -V clean package exec:exec javadoc:javadoc
readline "Animal Sniffer détecte le problème (même s'il plante lamentablement avec un NPE)..."
j7
run java -cp target/classes toolchains.Main
readline "le problème est bien détecté par Animal Sniffer, mais cela ne le résoud pas: seul toolchain le peut..."


readline "autre bonus : on peut exécuter jdeps du JDK 8/9 alors que Maven utilise JDK 7 (nécessite Maven 3.3)..."
run mvn -V clean package exec:exec javadoc:javadoc -Pjdeps
