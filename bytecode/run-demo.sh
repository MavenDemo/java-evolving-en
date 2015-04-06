#!/usr/bin/env bash

\rm -f target src/main/java/bytecode/*.class

clear

run() {
  echo -e "\\033[1m\$ $*\\033[0m"
  $*
}

commentaire() {
  echo ""
  echo -e "\\033[32m// $*\\033[0m"
}

enter() {
  echo ""
  echo -e "\\033[31m[...]\\033[0m"
  read
}

commentaire "compilation javac en JDK 7..."
j7
run javac -version src/main/java/bytecode/Display.java 


commentaire "et exécution en JRE 7..."
run java -cp src/main/java bytecode.Display

enter

commentaire "exécution en JRE 8 : tout va bien car compatibilité binaire..."
j8
run java -cp src/main/java bytecode.Display

enter

commentaire "mais exécution en JRE 6 : incompatibilité binaire..."
j6
run java -cp src/main/java bytecode.Display

enter

clear
commentaire "compilation avec Maven et JDK 7..."
j7
run mvn clean compile


commentaire "et exécution en JRE 7..."
run java -cp target/classes bytecode.Display
commentaire "le bytecode a été généré en version 5, car fixé par le maven-compiler-plugin"

enter

clear
commentaire "compilation avec Maven et JDK 7 mais properties maven.compiler.source et target à 1.6..."
run mvn clean compile -Pproperties
run java -cp target/classes bytecode.Display

commentaire "donc tout se passe bien en exécution en JRE 6..."
j6
run java -cp target/classes bytecode.Display

enter

clear
commentaire "sauf quand une dépendance contient du bytecode de version 7..."
run java -cp target/classes:lib/* bytecode.Display2

enter

clear
commentaire "la règle enforceBytecodeVersion du maven-enforcer-plugin permet de vérifier la version de bytecode des dépendances..."
run mvn clean compile -Pproperties,enforcer
commentaire "détecte le problème à la compilation..."
