FROM tomcat
COPY target/app.war ${CATALINA_HOME}/webapps
# VOLUME ["/usr/local/tomcat/webapps"]
VOLUME ${CATALINA_HOME}/webapps

# FROM openjdk
# COPY target/corba-jar-with-dependencies.jar /usr/
# WORKDIR /usr/
# CMD ["java", "-jar", "corba-jar-with-dependencies.jar", "client"]