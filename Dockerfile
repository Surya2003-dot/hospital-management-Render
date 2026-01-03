FROM eclipse-temurin:25-jdk

# Install Tomcat manually (Tomcat 9 supports Jakarta EE)
ENV TOMCAT_VERSION=9.0.113

RUN apt-get update && apt-get install -y curl \
    && curl -fSL https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o tomcat.tar.gz \
    && tar -xzf tomcat.tar.gz \
    && mv apache-tomcat-${TOMCAT_VERSION} /usr/local/tomcat \
    && rm tomcat.tar.gz \
    && rm -rf /usr/local/tomcat/webapps/ROOT

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

COPY tomcat/webapps/HospitalManagement.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]