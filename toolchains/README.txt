// build JDK 9
$ j9
$ mvn -V clean package exec:exec javadoc:javadoc
// failure: JDK 9 refuse -target 1.5

// build et exécution en JDK/JRE 8
$ j8
$ mvn -V clean package exec:exec javadoc:javadoc

// profile toolchain => build JDK 6, Maven reste JRE 8
$ mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain

// test cas d'erreur
// version de JDK qui n'est pas installé
$ mvn -V clean package exec:exec javadoc:javadoc -Ptoolchain-jdk5


// et en bonus, on peut exécuter jdeps 9 alors que Maven utilise JRE 8 et le compilateur JDK 6