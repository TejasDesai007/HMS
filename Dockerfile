FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file (change the name if needed)
COPY build/web /usr/local/tomcat/webapps/ROOT

EXPOSE 8080