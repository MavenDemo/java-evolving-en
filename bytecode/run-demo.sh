#!/bin/bash

\rm -rf target src/main/java/bytecode/*.class

set -v

read -p "compilation directe en JDK 7..."
j7
javac -version src/main/java/bytecode/Display.java 


read -p "exécution en JRE 7..."
java -cp src/main/java bytecode.Display


read -p "exécution en JRE 8 : compatibilité binaire..."
j8
java -cp src/main/java bytecode.Display


read -p "mais exécution en JRE 6 : incompatibilité binaire..."
j6
java -cp src/main/java bytecode.Display


read -p "compilation avec Maven et JDK 7..."
j7
mvn clean compile


read -p "exécution en JRE 7..."
java -cp target/classes bytecode.Display
echo "le bytecode a été généré en version 5, car fixé par le maven-compiler-plugin"


read -p "compilation avec Maven en définissant les properties maven.compiler.source et target à 1.6..."
mvn clean compile -Pproperties
java -cp target/classes bytecode.Display


read -p "donc tout se passe bien en exécution en JRE 6..."
j6
java -cp target/classes bytecode.Display

read -p "sauf quand une dépendance contient du bytecode de version 7..."
java -cp target/classes:lib/* bytecode.Display2


read -p "la règle enforceBytecodeVersion du maven-enforcer-plugin permet de vérifier la version de bytecode des dépendances..."
mvn clean compile -Pproperties,enforcer


read -p "Mais si enforcer détecte bien un problème dans les dépendances, il ne détecte pas tout..."
j7
mvn clean compile -Pproperties
j6
java -cp target/classes bytecode.Display3
read -p "compilé avec un JDK 7, du bytecode version 6 peut contenir des appels à des APIs introduites en Java 7..."


read -p "la compilation avec un JDK 6 aurait montré le problème..."
j6
mvn clean compile

set +v
