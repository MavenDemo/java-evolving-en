// build JDK 9
$ j9
$ mvn -V clean package exec:exec javadoc:javadoc
// failure: JDK 9 refuse -target 1.5


// build et exécution en JDK/JRE 7
$ j7
$ mvn -V clean package exec:exec javadoc:javadoc


// profil toolchain => compilation JDK 6, Maven reste JRE 7
$ mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain


// test cas d'erreur
// version de JDK qui n'est pas installé
$ mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain-jdk5


// démo bonus cas bizarre: la compilation avec un JDK 8 crée une dépendance à l'API JDK 8
$ j8
$ mvn -V clean package exec:exec javadoc:javadoc
$ java -cp target/classes toolchains.Main
// le problème est bien détecté par Animal Sniffer, mais cela ne le résoud pas: seul toolchain le peut

// autre bonus: on peut exécuter jdeps du JDK 8/9 alors que Maven utilise JDK 7 (nécessite Maven 3.3)
$ j7
$ mvn -V clean package exec:exec javadoc:javadoc -Pjdeps
