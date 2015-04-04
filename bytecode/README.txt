// compilation directe en JDK 7
$ j7
$ javac -version src/main/java/bytecode/Display.java 
javac 1.7.0_71

// exécution en JDK(JRE) 7
$ java -showversion -cp src/main/java bytecode.Display
java version "1.7.0_71"
Java(TM) SE Runtime Environment (build 1.7.0_71-b14)
Java HotSpot(TM) 64-Bit Server VM (build 24.71-b01, mixed mode)

bytecode.Display -> cafe babe 0000 0033  : 0x33 = 51 = Java 7
java.lang.Object -> cafe babe 0000 0033  : 0x33 = 51 = Java 7

// exécution en JDK(JRE) 8 : compatibilité binaire
$ j8
$ java -showversion -cp src/main/java bytecode.Display
java version "1.8.0_25"
Java(TM) SE Runtime Environment (build 1.8.0_25-b17)
Java HotSpot(TM) 64-Bit Server VM (build 25.25-b02, mixed mode)

bytecode.Display -> cafe babe 0000 0033  : 0x33 = 51 = Java 7
java.lang.Object -> cafe babe 0000 0034  : 0x34 = 52 = Java 8

// exécution en JDK(JRE) 6 : incompatibilité binaire
$ j6
$ java -showversion -cp src/main/java bytecode.Display
java version "1.6.0_32"
Java(TM) SE Runtime Environment (build 1.6.0_32-b05)
Java HotSpot(TM) 64-Bit Server VM (build 20.7-b02, mixed mode)

Exception in thread "main" java.lang.UnsupportedClassVersionError: bytecode/Display : Unsupported major.minor version 51.0
        at java.lang.ClassLoader.defineClass1(Native Method)
        at java.lang.ClassLoader.defineClassCond(ClassLoader.java:631)
        at java.lang.ClassLoader.defineClass(ClassLoader.java:615)
        at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:141)
        at java.net.URLClassLoader.defineClass(URLClassLoader.java:283)
        at java.net.URLClassLoader.access$000(URLClassLoader.java:58)
        at java.net.URLClassLoader$1.run(URLClassLoader.java:197)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(URLClassLoader.java:190)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:306)
        at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:301)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:247)
Could not find the main class: bytecode.Display.  Program will exit.

// compilation avec Maven et JDK 7
$ j7
$ mvn clean compile

// exécution en JDK(JRE) 7
$ java -showversion -cp target/classes bytecode.Display
java version "1.7.0_71"
Java(TM) SE Runtime Environment (build 1.7.0_71-b14)
Java HotSpot(TM) 64-Bit Server VM (build 24.71-b01, mixed mode)

bytecode.Display -> cafe babe 0000 0031  : 0x31 = 49 = Java 5
java.lang.Object -> cafe babe 0000 0033  : 0x33 = 51 = Java 7
// le bytecode a été généré en version 5: fixé par le maven-compiler-plugin

// profile "properties" définit les properties maven.compiler.source et target à 1.6
$ mvn clean compile -Pproperties
$ java -showversion -cp target/classes bytecode.Display
java version "1.7.0_71"
Java(TM) SE Runtime Environment (build 1.7.0_71-b14)
Java HotSpot(TM) 64-Bit Server VM (build 24.71-b01, mixed mode)

bytecode.Display -> cafe babe 0000 0031  : 0x32 = 50 = Java 6
java.lang.Object -> cafe babe 0000 0033  : 0x33 = 51 = Java 7

// TODO : ajouter une dépendance à une classe Java 7
$j6
$ java -showversion -cp target/classes bytecode.Display
-> pb
// fait une intro à Animal Sniffer = contrôle des classes utilisées
