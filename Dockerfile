FROM openjdk:17

ADD target/auth-service.jar auth-service.jar

ENTRYPOINT ["java", "-jar", "/auth-service.jar"]