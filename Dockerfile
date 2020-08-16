FROM maven:3.5-jdk-8 AS build

# Setting Home Directory
#WORKDIR /backend

# Copying src code to Container
COPY ./src /usr/src/app/src
COPY ./target /usr/src/app/target
COPY pom.xml /usr/src/app

# Building From Source Code
RUN mvn -f /usr/src/app/pom.xml clean package

FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/demo-1.0.0-SNAPSHOT.jar /usr/app/demo-1.0.0-SNAPSHOT.jar  
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/demo-1.0.0-SNAPSHOT.jar"] 

