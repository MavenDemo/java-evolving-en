// compilation avec Maven configuré pour génrer du J7 avec un JDK 8
$ j8

$ mvn clean compile
...

// puisque maven.compiler.source et target sont configurés pour 1.7 testons avec J7
// exécution en JDK(JRE) 8

$ j7
$ java -showversion -cp target/classes animalsniffer.Main Maven is mega cool

java version "1.7.0_75"
Java(TM) SE Runtime Environment (build 1.7.0_75-b13)
Java HotSpot(TM) 64-Bit Server VM (build 24.75-b04, mixed mode)

Exception in thread "main" java.lang.NoSuchMethodError: java.lang.String.join(Ljava/lang/CharSequence;[Ljava/lang/CharSequence;)Ljava/lang/String;
	at animalsniffer.Main.main(Main.java:27)

// WTF ?? et en J8 ??

// exécution en JDK(JRE) 8
$ java -showversion -cp target/classes animalsniffer.Main Maven is mega cool
java version "1.8.0_40"
Java(TM) SE Runtime Environment (build 1.8.0_40-b27)
Java HotSpot(TM) 64-Bit Server VM (build 25.40-b25, mixed mode)

Maven_is_mega_cool

// Malgré la compilation en J7, nous utilisons une API J8 d'où l'erreur

// Animal Sniffer à la rescousse pour valider que nous utilisons les bonnes APIs
// (cf profile animal dans le pom qui utilise le plugin enforcer)

$ mvn clean install -Panimal

[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Animal Sniffer Demo 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ animalsniffer ---
[INFO] Deleting /Users/arnaud/Code/MavenDevoxxFR2015/demos/animalsniffer/target
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ animalsniffer ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/arnaud/Code/MavenDevoxxFR2015/demos/animalsniffer/src/main/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ animalsniffer ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 1 source file to /Users/arnaud/Code/MavenDevoxxFR2015/demos/animalsniffer/target/classes
[INFO] -------------------------------------------------------------
[ERROR] COMPILATION ERROR :
[INFO] -------------------------------------------------------------
[ERROR] /Users/arnaud/Code/MavenDevoxxFR2015/demos/animalsniffer/src/main/java/animalsniffer/Main.java:[26,30] cannot find symbol
  symbol:   method join(java.lang.String,java.lang.String[])
  location: class java.lang.String
[INFO] 1 error
[INFO] -------------------------------------------------------------
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 2.400 s
[INFO] Finished at: 2015-04-01T00:40:24+02:00
[INFO] Final Memory: 12M/156M
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.1:compile (default-compile) on project animalsniffer: Compilation failure
[ERROR] /Users/arnaud/Code/MavenDevoxxFR2015/demos/animalsniffer/src/main/java/animalsniffer/Main.java:[26,30] cannot find symbol
[ERROR] symbol:   method join(java.lang.String,java.lang.String[])
[ERROR] location: class java.lang.String
[ERROR] -> [Help 1]
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException

