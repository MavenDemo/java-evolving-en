#!/usr/bin/env bash

clear

run() {
  echo -e "\\033[1m\$ $*\\033[0m"
  $*
}

commentaire() {
  echo ""
  echo -e "\\033[32m# $*\\033[0m"
}

enter() {
  echo -en "\\033[31m[...]\\033[0m"
  read
}

show() {
  #echo -en "\\033[92m"
  $* | pygmentize -l xml
  #echo -en "\\033[0m"
  enter
}

commentaire "surprising case: when compiling with JDK 8, which does aggressive optimizations, a dependency to JDK 8 API is created (not existing in source)..."
j8
run mvn -V clean package exec:exec
commentaire "Animal Sniffer detects the issue at build time (even if imploding with NPE)..."

enter

commentaire "running with JRE 7, we see more clearly the issue (which does not exist in source code)..."
j7
run java -cp target/classes toolchains.Main

commentaire "Animal Sniffer detects the issue, but does not fix it."
commentaire "Then you must take care not compiling this code with JDK 8..."
commentaire "Or use toolchains to be sure to never compile with JDK 8..."

enter

commentaire "JDK 9 adds a new feature for this: javac -release flag (july 2015, JEP 247 : Compile for Older Platform Versions)."
commentaire "Without this flag, JDK 9 has same aggressive optimization consequence as JDK 8"
mkdir target/j9
j9
run javac -version -target 1.6 -source 1.6 src/main/java/*/*.java -d target/j9
j7
run java -cp target/j9 toolchains.Main

enter

commentaire "but with this '-release 6' flag, no more issue"
mkdir target/j9-release6
j9
run javac -version -release 6 src/main/java/*/*.java -d target/j9-release6
j7
run java -cp target/j9-release6 toolchains.Main

enter

clear
commentaire "bonus: with Maven 3.3, even if Maven uses JDK 7 compiler, jdeps from JDK 8/9 can be used..."
commentaire "WARNING: this requires Maven 3.3"
show grep -B 2 -A 13 maven-jdeps-plugin pom-toolchain-jdeps.xml
run mvn -V clean package -f pom-toolchain-jdeps.xml
