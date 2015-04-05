set -v

read -p "compilation avec un JDK 8 et Maven configuré pour générer du bytecode Java 7..."
j8
mvn clean compile

read -p "puisque bytecode Java 7, exécution en JRE 7..."
j7
java -showversion -cp target/classes animalsniffer.Main Maven is mega cool

read -p "exécution en JRE 8..."
j8
java -showversion -cp target/classes animalsniffer.Main Maven is mega cool



read -p "Animal Sniffer à la rescousse pour valider que nous utilisons les bonnes APIs..."
mvn clean install -Panimal


read -p "Animal sniffer via enforcer..."
mvn clean install -Panimal-enforcer


set +v
