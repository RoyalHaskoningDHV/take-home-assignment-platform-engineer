FROM maven:3.5.3-jdk-8-alpine as build

# Setting Home Directory
WORKDIR /backend

# Copying src code to Container
COPY ./src ./src
COPY ./target ./target

# Building From Source Code
RUN mvn clean package
COPY . .

# Exposing Port
EXPOSE 8080

# Running Kotlin Application
CMD["mvn","spring-boot:run"]