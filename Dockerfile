FROM maven:3.9.9-eclipse-temurin-11 AS BUILD_IMAGE
# Set a clear working directory
WORKDIR /vprofile-project
# Copy the project into the image
COPY . .
# Build the app (skip tests if you want faster builds)
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk11-temurin
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
