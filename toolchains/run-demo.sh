set -v

read -p "build avec JDK 9..."
j9
mvn -V clean package exec:exec javadoc:javadoc
read -p "failure: JDK 9 refuse -target 1.5, trop ancien..."


read -p "build et exécution en JDK/JRE 7..."
j7
mvn -V clean package exec:exec javadoc:javadoc


read -p "profil toolchain => compilation JDK 6, Maven reste JRE 7..."
mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain


read -p "test cas d'erreur: version de JDK qui n'est pas configurée dans les toolchains..."
mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain-jdk5


read -p "démo bonus cas bizarre: la compilation avec un JDK 8 crée une dépendance à l'API JDK 8..."
j8
mvn -V clean package exec:exec javadoc:javadoc
read -p "Animal Sniffer détecte le problème (même s'il plante lamentablement avec un NPE)..."
j7
java -cp target/classes toolchains.Main
read -p "le problème est bien détecté par Animal Sniffer, mais cela ne le résoud pas: seul toolchain le peut..."


read -p "autre bonus: on peut exécuter jdeps du JDK 8/9 alors que Maven utilise JDK 7 (nécessite Maven 3.3)..."
mvn -V clean package exec:exec javadoc:javadoc -Pjdeps

set +v
