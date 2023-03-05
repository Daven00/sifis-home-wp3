#!/bin/bash

# Builds DHT-enabled standalone Jar files for the Group Applications
# OscoreAsServer: ACE Authorization Server
# OscoreRsServer: Group Manager
# OscoreAsRsClient: Group OSCORE Server/Client which will join the group(s)
# Adversary: Adversary for testing attacks against the group(s)

# Build Californium (if needed)
FILE=californium-extended/cf-oscore/target/cf-oscore-3.1.0-SNAPSHOT.jar
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    cd californium-extended
    mvn -DskipTests clean install
    cd ..
fi

# Build ACE (if needed)
FILE=ace/target/ace-0.0.1-SNAPSHOT.jar
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    
    # Copy library Jar files from Californium to ACE lib folder
    mkdir ace/lib
    cp californium-extended/cf-oscore/target/cf-oscore-3.1.0-SNAPSHOT.jar ace/lib
    cp californium-extended/californium-core/target/californium-core-3.1.0-SNAPSHOT.jar ace/lib
    cp californium-extended/scandium-core/target/scandium-3.1.0-SNAPSHOT.jar ace/lib
    cp californium-extended/element-connector/target/element-connector-3.1.0-SNAPSHOT.jar ace/lib
    
    cd ace
    mvn -DskipTests clean install
    cd ..
fi

# Copy library Jar files from Californium to Group Apps lib folder
# Dependencies for building with Maven
mkdir group-applications/lib
cp californium-extended/cf-oscore/target/cf-oscore-3.1.0-SNAPSHOT.jar group-applications/lib

cp californium-extended/californium-core/target/californium-core-3.1.0-SNAPSHOT.jar group-applications/lib

cp californium-extended/scandium-core/target/scandium-3.1.0-SNAPSHOT.jar group-applications/lib

cp californium-extended/element-connector/target/element-connector-3.1.0-SNAPSHOT.jar group-applications/lib

#Remove?
#cp californium-extended/cf-edhoc/target/cf-edhoc-3.1.0-SNAPSHOT.jar group-applications/lib

cp ace/target/ace-0.0.1-SNAPSHOT.jar group-applications/lib

# Run Group Apps JUnit tests
# https://stackoverflow.com/questions/65092032/maven-build-failed-but-exit-code-is-still-0

cd group-applications
echo "*** Building Group Applications ***"
# mvn clean install | tee mvn_res
mvn clean org.jacoco:jacoco-maven-plugin:0.8.6:prepare-agent install org.jacoco:jacoco-maven-plugin:0.8.6:report | tee mvn_res
if grep 'BUILD FAILURE' mvn_res;then exit 1; fi;
if grep 'BUILD SUCCESS' mvn_res;then echo "BUILD SUCCESS"; else exit 1; fi;
rm mvn_res
cd ..

# Copy necessary dependencies
# Dependencies for running
cp -n ~/.m2/repository/org/bouncycastle/bcpkix-jdk15on/1.67/bcpkix-jdk15on-1.67.jar group-applications/lib
cp -n ~/.m2/repository/org/bouncycastle/bcprov-jdk15on/1.67/bcprov-jdk15on-1.67.jar group-applications/lib
cp -n ~/.m2/repository/com/upokecenter/cbor/4.3.0/cbor-4.3.0.jar group-applications/lib
cp -n ~/.m2/repository/net/i2p/crypto/eddsa/0.3.0/eddsa-0.3.0.jar group-applications/lib
cp -n ~/.m2/repository/com/sun/activation/jakarta.activation/2.0.0/jakarta.activation-2.0.0.jar group-applications/lib
cp -n ~/.m2/repository/jakarta/websocket/jakarta.websocket-api/2.0.0/jakarta.websocket-api-2.0.0.jar group-applications/lib
cp -n ~/.m2/repository/jakarta/xml/bind/jakarta.xml.bind-api/3.0.0/jakarta.xml.bind-api-3.0.0.jar group-applications/lib
cp -n ~/.m2/repository/com/github/peteroupc/numbers/1.4.3/numbers-1.4.3.jar group-applications/lib
cp -n ~/.m2/repository/org/glassfish/tyrus/tyrus-client/2.0.0/tyrus-client-2.0.0.jar group-applications/lib
cp -n ~/.m2/repository/org/glassfish/tyrus/tyrus-container-grizzly-client/2.0.0/tyrus-container-grizzly-client-2.0.0.jar group-applications/lib
cp -n ~/.m2/repository/javax/websocket/javax.websocket-api/1.1/javax.websocket-api-1.1.jar group-applications/lib
cp -n ~/.m2/repository/org/glassfish/tyrus/tyrus-core/2.0.0/tyrus-core-2.0.0.jar group-applications/lib #TODO: Add in pom?
cp -n ~/.m2/repository/org/glassfish/tyrus/tyrus-spi/2.0.0/tyrus-spi-2.0.0.jar group-applications/lib #TODO: Add in pom?

cp -n ~/.m2/repository/org/slf4j/slf4j-api/1.7.5/slf4j-api-1.7.5.jar group-applications/lib
cp -n ~/.m2/repository/org/slf4j/slf4j-log4j12/1.7.5/slf4j-log4j12-1.7.5.jar group-applications/lib
cp -n ~/.m2/repository/org/slf4j/slf4j-simple/1.7.5/slf4j-simple-1.7.5.jar group-applications/lib
cp -n ~/.m2/repository/mysql/mysql-connector-java/5.1.47/mysql-connector-java-5.1.47.jar group-applications/lib
cp -n ~/.m2/repository/org/json/json/20180813/json-20180813.jar group-applications/lib
cp -n ~/.m2/repository/junit/junit/4.12/junit-4.12.jar group-applications/lib
cp -n ~/.m2/repository/org/postgresql/postgresql/9.3-1104-jdbc4/postgresql-9.3-1104-jdbc4.jar group-applications/lib

# For Californium's logging
cp -n ~/.m2/repository/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar group-applications/lib
cp -n ~/.m2/repository/org/slf4j/jul-to-slf4j/1.7.36/jul-to-slf4j-1.7.36.jar group-applications/lib
cp -n ~/.m2/repository/org/slf4j/slf4j-simple/1.7.36/slf4j-simple-1.7.36.jar group-applications/lib

# Printing of where Jar ended up and how to run it
#echo "Jar file containing Group Applications built under group-applications/target/group-applications-0.0.2-SNAPSHOT.jar" 
#echo "Run using (from folder target): "
#echo "java -cp group-applications-0.0.2-SNAPSHOT.jar:../lib/* se.sics.prototype.apps.OscoreAsServer"
#echo "java -cp group-applications-0.0.2-SNAPSHOT.jar:../lib/* se.sics.prototype.apps.OscoreRsServer"
#echo "java -cp group-applications-0.0.2-SNAPSHOT.jar:../lib/* se.sics.prototype.apps.OscoreAsRsClient -help"
#echo "java -cp group-applications-0.0.2-SNAPSHOT.jar:../lib/* se.sics.prototype.apps.Adversary"

# TODO: Take care of db.pwd
echo "Warning: A MySQL server must be installed with the root password in db.pwd in the folder the Jars are launched from"

# Build individual Jar files
cd group-applications/target
echo "Main-Class: se.sics.prototype.apps.OscoreAsServer" > Manifest.addition
echo "Class-Path: lib/cf-oscore-3.1.0-SNAPSHOT.jar" >> Manifest.addition
echo "  lib/scandium-3.1.0-SNAPSHOT.jar" >> Manifest.addition
echo "  lib/slf4j-simple-1.7.5.jar" >> Manifest.addition
echo "  lib/slf4j-api-1.7.36.jar" >> Manifest.addition
echo "  lib/cf-edhoc-3.1.0-SNAPSHOT.jar" >> Manifest.addition
echo "  lib/eddsa-0.3.0.jar" >> Manifest.addition
echo "  lib/jakarta.activation-2.0.0.jar" >> Manifest.addition
echo "  lib/californium-core-3.1.0-SNAPSHOT.jar" >> Manifest.addition
echo "  lib/bcpkix-jdk15on-1.67.jar" >> Manifest.addition
echo "  lib/mysql-connector-java-5.1.47.jar" >> Manifest.addition
echo "  lib/slf4j-api-1.7.5.jar" >> Manifest.addition
echo "  lib/bcprov-jdk15on-1.67.jar" >> Manifest.addition
echo "  lib/jul-to-slf4j-1.7.36.jar" >> Manifest.addition
echo "  lib/ace-0.0.1-SNAPSHOT.jar" >> Manifest.addition
echo "  lib/cbor-4.3.0.jar" >> Manifest.addition
echo "  lib/junit-4.12.jar" >> Manifest.addition
echo "  lib/slf4j-log4j12-1.7.5.jar" >> Manifest.addition
echo "  lib/postgresql-9.3-1104-jdbc4.jar" >> Manifest.addition
echo "  lib/jakarta.xml.bind-api-3.0.0.jar" >> Manifest.addition
echo "  lib/jakarta.websocket-api-2.0.0.jar" >> Manifest.addition
echo "  lib/json-20180813.jar" >> Manifest.addition
echo "  lib/slf4j-simple-1.7.36.jar" >> Manifest.addition
echo "  lib/numbers-1.4.3.jar" >> Manifest.addition
echo "  lib/element-connector-3.1.0-SNAPSHOT.jar" >> Manifest.addition
echo "  lib/tyrus-client-2.0.0.jar" >> Manifest.addition
echo "  lib/tyrus-container-grizzly-client-2.0.0.jar" >> Manifest.addition
echo "  lib/javax.websocket-api-1.1.jar" >> Manifest.addition
echo "  lib/tyrus-core-2.0.0.jar" >> Manifest.addition
echo "  lib/tyrus-spi-2.0.0.jar" >> Manifest.addition
echo -e "\n" >> Manifest.addition >> Manifest.addition

cp group-applications-0.0.2-SNAPSHOT.jar group-applications-0.0.2-SNAPSHOT.jar.bk
unzip -o group-applications-0.0.2-SNAPSHOT.jar META-INF/MANIFEST.MF
head -c -1 -q META-INF/MANIFEST.MF Manifest.addition > META-INF/MANIFEST.MF

zip group-applications-0.0.2-SNAPSHOT.jar META-INF/MANIFEST.MF
cp group-applications-0.0.2-SNAPSHOT.jar ../OscoreAsServer.jar

sed -i "s/OscoreAsServer/OscoreRsServer/" META-INF/MANIFEST.MF
zip group-applications-0.0.2-SNAPSHOT.jar META-INF/MANIFEST.MF
cp group-applications-0.0.2-SNAPSHOT.jar ../OscoreRsServer.jar

sed -i "s/OscoreRsServer/OscoreAsRsClient/" META-INF/MANIFEST.MF
zip group-applications-0.0.2-SNAPSHOT.jar META-INF/MANIFEST.MF
cp group-applications-0.0.2-SNAPSHOT.jar ../OscoreAsRsClient.jar

sed -i "s/OscoreAsRsClient/Adversary/" META-INF/MANIFEST.MF
zip group-applications-0.0.2-SNAPSHOT.jar META-INF/MANIFEST.MF
cp group-applications-0.0.2-SNAPSHOT.jar ../Adversary.jar

cp group-applications-0.0.2-SNAPSHOT.jar.bk group-applications-0.0.2-SNAPSHOT.jar

rm -rf META-INF
rm Manifest.addition
cd ..
cd ..

echo "Jar files containing Group Applications built under group-applications/. Execute them with lib in the same folder. Use -help to see possible arguments when applicable."
