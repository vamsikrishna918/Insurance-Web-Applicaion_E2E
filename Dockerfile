FROM openjdk:11
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} insureme.jar
ENTRYPOINT ["java","-jar","/insureme.jar"]
