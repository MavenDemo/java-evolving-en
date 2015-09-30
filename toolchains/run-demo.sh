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
  #echo -en "\\033[92m"
  $* | pygmentize -l xml
  #echo -en "\\033[0m"
  enter
}

commentaire "build and run as usual with JDK/JRE 7..."
j7
run mvn -V clean package exec:exec javadoc:javadoc

enter

clear
commentaire "maven-toolchain-plugin => Maven runs with JRE 7 but asks for JDK 6 for use by toolchain-aware plugins..."
show grep -B 2 -A 16 maven-toolchains-plugin pom-toolchain.xml
commentaire "requires JDKs to be defined in toolchains.xml..."
show cat ~/.m2/toolchains.xml
run mvn -V clean package exec:exec javadoc:javadoc -f pom-toolchain.xml

enter

clear
commentaire "failure test: JDK version not configured in toolchain.xml..."
run mvn -V clean package exec:exec javadoc:javadoc -f pom-toolchain-jdk5.xml
