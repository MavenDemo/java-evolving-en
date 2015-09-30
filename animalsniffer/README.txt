# compilation with JDK 8 and Maven configured to generate Java 7 bytecode...
$ j8

$ mvn clean compile
...

# then since Java 7 bytecode, running with JRE 7...
$ j7
$ java -cp target/classes animalsniffer.Main Maven is mega cool
animalsniffer.Main.class -> cafe babe 0000 0033 ...
             major version = 0x33 = 51 = Java 7
Java 7 bytecode running on JVM 1.7
Exception in thread "main" java.lang.NoSuchMethodError: java.lang.String.join(Ljava/lang/CharSequence;[Ljava/lang/CharSequence;)Ljava/lang/String;
        at animalsniffer.Main.callJava7API(Main.java:22)
        at animalsniffer.Main.main(Main.java:15)

# breaks when calling a JRE 8 API...


# this code works only with JRE 8...
$ j8
$ java -showversion -cp target/classes animalsniffer.Main Maven is mega cool
java version "1.8.0_51"
Java(TM) SE Runtime Environment (build 1.8.0_51-b16)
Java HotSpot(TM) 64-Bit Server VM (build 25.51-b03, mixed mode)

animalsniffer.Main.class -> cafe babe 0000 0033 ...
             major version = 0x33 = 51 = Java 7
Java 7 bytecode running on JVM 1.8
Maven_is_mega_cool

# Animal Sniffer comes in to check that we use only supported APIs...
$ mvn clean install -f pom-animal.xml
[INFO] Scanning for projects...
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building Animal Sniffer Demo 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ animalsniffer ---
[INFO] Deleting /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/target
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ animalsniffer ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ animalsniffer ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/target/classes
[INFO] 
[INFO] --- animal-sniffer-maven-plugin:1.14:check (check-java-compat) @ animalsniffer ---
[INFO] Checking unresolved references to org.codehaus.mojo.signature:java17:1.0
[ERROR] /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/src/main/java/animalsniffer/Main.java:22: Undefined reference: String String.join(CharSequence, CharSequence[])
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1.817 s
[INFO] Finished at: 2015-09-30T15:59:12+02:00
[INFO] Final Memory: 14M/272M
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.codehaus.mojo:animal-sniffer-maven-plugin:1.14:check (check-java-compat) on project animalsniffer: Signature errors found. Verify them and ignore them with the proper annotation if needed. -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException


# Animal Sniffer via enforcer...
$ mvn clean install -f pom-enforcer-animal.xml
[INFO] Scanning for projects...
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building Animal Sniffer Demo 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ animalsniffer ---
[INFO] Deleting /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/target
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ animalsniffer ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ animalsniffer ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/target/classes
[INFO] 
[INFO] --- maven-enforcer-plugin:1.4:enforce (check-java-compat) @ animalsniffer ---
[INFO] Checking unresolved references to org.codehaus.mojo.signature:java17:1.0
[ERROR] /home/herve/projets/maven/java-evolving/java-evolving-en/animalsniffer/src/main/java/animalsniffer/Main.java:22: Undefined reference: String String.join(CharSequence, CharSequence[])
[WARNING] Rule 0: org.codehaus.mojo.animal_sniffer.enforcer.CheckSignatureRule failed with message:
Signature errors found. Verify them and ignore them with the proper annotation if needed.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 2.056 s
[INFO] Finished at: 2015-09-30T15:59:40+02:00
[INFO] Final Memory: 15M/265M
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-enforcer-plugin:1.4:enforce (check-java-compat) on project animalsniffer: Some Enforcer rules have failed. Look above for specific messages explaining why the rule failed. -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
