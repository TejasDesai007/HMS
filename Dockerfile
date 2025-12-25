FROM tomcat:9.0-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR
COPY webapps/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port (Render uses $PORT)
ENV PORT=8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
