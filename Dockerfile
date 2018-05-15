FROM tomcat
COPY /target/app.war ${CATALINA_HOME}/webapps/app.war
# COPY *.jar ${CATALINA_HOME}/lib/ 