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

commentaire "compilation with JDK 8 and Maven configured to generate Java 7 bytecode..."
show grep -B 2 -A 2 maven.compiler.source pom.xml
j8
run mvn clean compile

commentaire "then since Java 7 bytecode, running with JRE 7..."
j7
run java -cp target/classes animalsniffer.Main Maven is mega cool
commentaire "breaks when calling a JRE 8 API..."

enter

commentaire "this code works only with JRE 8..."
j8
run java -showversion -cp target/classes animalsniffer.Main Maven is mega cool

enter

clear
commentaire "Animal Sniffer comes in to check that we use only supported APIs..."
show grep -B 2 -A 18 animal-sniffer-maven-plugin pom-animal.xml
run mvn clean install -f pom-animal.xml


enter

clear
commentaire "Animal Sniffer via enforcer..."
show grep -B 2 -A 29 maven-enforcer-plugin pom-enforcer-animal.xml
run mvn clean install -f pom-enforcer-animal.xml
