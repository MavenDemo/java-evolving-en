#!/usr/bin/env bash
\rm -f target src/main/java/bytecode/*.class

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

readline "compilation directe en JDK 7..."
j7
run javac -version src/main/java/bytecode/Display.java 


readline "exécution en JRE 7..."
run java -cp src/main/java bytecode.Display


readline "exécution en JRE 8 : compatibilité binaire..."
j8
run java -cp src/main/java bytecode.Display


readline "mais exécution en JRE 6 : incompatibilité binaire..."
j6
run java -cp src/main/java bytecode.Display


readline "compilation avec Maven et JDK 7..."
j7
run mvn clean compile


readline "exécution en JRE 7..."
run java -cp target/classes bytecode.Display
readline "le bytecode a été généré en version 5, car fixé par le maven-compiler-plugin"


readline "compilation avec Maven en définissant les properties maven.compiler.source et target à 1.6..."
run mvn clean compile -Pproperties
run java -cp target/classes bytecode.Display


readline "donc tout se passe bien en exécution en JRE 6..."
j6
run java -cp target/classes bytecode.Display

readline "sauf quand une dépendance contient du bytecode de version 7..."
run java -cp target/classes:lib/* bytecode.Display2


readline "la règle enforceBytecodeVersion du maven-enforcer-plugin permet de vérifier la version de bytecode des dépendances..."
run mvn clean compile -Pproperties,enforcer


readline "Mais si enforcer détecte bien un problème dans les dépendances, il ne détecte pas tout..."
j7
run mvn clean compile -Pproperties
j6
run java -cp target/classes bytecode.Display3
readline "compilé avec un JDK 7, du bytecode version 6 peut contenir des appels à des APIs introduites en Java 7..."


readline "la compilation avec un JDK 6 aurait montré le problème..."
j6
run mvn clean compile
