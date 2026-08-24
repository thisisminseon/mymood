FROM tomcat:11-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY mymood/src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY mymood/src/main/java   /tmp/src

# db.properties はリポジトリに含めないため、サンプルから作る
RUN if [ ! -f /tmp/src/db.properties ]; then \
      cp /tmp/src/db.properties.example /tmp/src/db.properties; \
    fi \
 && javac -encoding UTF-8 \
      -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*" \
      -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
      $(find /tmp/src -name "*.java") \
 && cp /tmp/src/db.properties /tmp/src/init-h2.sql \
       /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/ \
 && rm -rf /tmp/src

EXPOSE 8080
CMD ["catalina.sh", "run"]
