FROM ndeloof/java

RUN apt-get update

# Forbid daemon to start
RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d 
RUN chmod +x /usr/sbin/policy-rc.d

#######################
#   SonarQube
#######################
RUN apt-get install -y unzip wget

RUN wget http://dist.sonar.codehaus.org/sonarqube-4.3.2.zip 
RUN unzip sonarqube-*.zip
RUN rm sonarqube-*.zip 

RUN sed -i 's/^sonar.jdbc.username.*$/sonar.jdbc.username=\${env:SONAR_JDBC_USERNAME}/' /sonarqube-4.3.2/conf/sonar.properties
RUN sed -i 's/^sonar.jdbc.password.*$/sonar.jdbc.password=\${env:SONAR_JDBC_PASSWORD}/' /sonarqube-4.3.2/conf/sonar.properties
RUN sed -i 's/^sonar.jdbc.url.*$/sonar.jdbc.url=\${env:SONAR_JDBC_URL}/' /sonarqube-4.3.2/conf/sonar.properties

ENV SONAR_JDBC_USERNAME sonar
ENV SONAR_JDBC_PASSWORD sonar
ENV SONAR_JDBC_URL jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true

#######################
# MySQL
#######################
RUN apt-get update
RUN apt-get install -y mysql-server && \
    sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf

####################
# Supervisord
####################
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-n"]

EXPOSE 9000 3306
