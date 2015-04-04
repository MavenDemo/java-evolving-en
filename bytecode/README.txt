// compilation directe en JDK 7...
$ j7
$ javac -version src/main/java/bytecode/*.java 
javac 1.7.0_71


// exécution en JRE 7...
$ java -cp src/main/java bytecode.Display
bytecode.Display -> cafe babe 0000 0033  : 0x33 = 51 = Java 7
Exécution sur Java Runtime Environment 1.7


// exécution en JRE 8 : compatibilité binaire...
$ j8
$ java -cp src/main/java bytecode.Display
bytecode.Display -> cafe babe 0000 0033  : 0x33 = 51 = Java 7
Exécution sur Java Runtime Environment 1.8


// mais exécution en JRE 6 : incompatibilité binaire...
$ j6
$ java -cp src/main/java bytecode.Display
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


// compilation avec Maven et JDK 7...
$ j7
mvn clean compile
[INFO] Scanning for projects...
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building Bytecode version display 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ bytecode ---
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ bytecode ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/herve/projets/maven/misc/demos/bytecode/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ bytecode ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to /home/herve/projets/maven/misc/demos/bytecode/target/classes
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1.166 s
[INFO] Finished at: 2015-04-04T18:45:29+02:00
[INFO] Final Memory: 12M/310M
[INFO] ------------------------------------------------------------------------


// exécution en JRE 7...
$ java -cp target/classes bytecode.Display
bytecode.Display -> cafe babe 0000 0031  : 0x31 = 49 = Java 5
Exécution sur Java Runtime Environment 1.7
// le bytecode a été généré en version 5, car fixé par le maven-compiler-plugin


// compilation avec Maven en définissant les properties maven.compiler.source et target à 1.6...
$ mvn clean compile -Pproperties
$ java -cp target/classes bytecode.Display
bytecode.Display -> cafe babe 0000 0032  : 0x32 = 50 = Java 6
Exécution sur Java Runtime Environment 1.7


// donc tout se passe bien en exécution en JRE 6...
$ j6
$ java -cp target/classes bytecode.Display
bytecode.Display -> cafe babe 0000 0032  : 0x32 = 50 = Java 6
Exécution sur Java Runtime Environment 1.6

// sauf quand du code qui a parfaitement compilé pose problème...
$ java -cp target/classes:lib/* bytecode.Display2
bytecode.Display2 -> cafe babe 0000 0032  : 0x32 = 50 = Java 6
Exécution sur Java Runtime Environment 1.6
Exception in thread "main" java.lang.NoSuchMethodError: java.sql.Driver.getParentLogger()Ljava/util/logging/Logger;
	at bytecode.Display2.callJava7API(Display2.java:54)
	at bytecode.Display2.main(Display2.java:44)
	at bytecode.Display2.main(Display2.java:36)
// compilé avec un JDK 7, du bytecode version 6 peut contenir des appels à des classes introduites en Java 7...

// la compilation avec un JDK 6 aurait montré le problème...
$ j6
$ mvn clean compile
[INFO] -------------------------------------------------------------
[ERROR] COMPILATION ERROR : 
[INFO] -------------------------------------------------------------
[ERROR] /home/herve/projets/maven/misc/demos/bytecode/src/main/java/bytecode/Display2.java:[54,14] cannot find symbol
symbol  : method getParentLogger()
location: interface java.sql.Driver
[INFO] 1 error
[INFO] -------------------------------------------------------------
