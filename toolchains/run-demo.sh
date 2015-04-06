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
