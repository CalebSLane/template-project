FROM maven:3.9.9-eclipse-temurin-21-alpine AS build

WORKDIR /build/
COPY pom.xml /build/
RUN --mount=type=cache,target=/root/.m2 \
    mvn dependency:go-offline
COPY src /build/src/
RUN --mount=type=cache,target=/root/.m2 \
    mvn package -DskipTests

#Run maven tests (Unit)
FROM build AS mvn-test
CMD ["mvn", "clean", "test", "-Djacoco.skip=true"]

#Run maven tests (Integration)
FROM build AS mvn-verify
CMD ["mvn", "clean", "verify", "-DskipTests", "-Djacoco.skip=true"]

#Run maven tests (Unit and Integration)
FROM build AS mvn-test-all
CMD ["mvn", "clean", "verify", "-Djacoco.skip=true"]

#Run maven tests (Unit and Integration) with coverage
FROM mvn-test-all AS testcoverage
CMD ["mvn", "clean", "verify"]

#Production runtime 
FROM eclipse-temurin:21-alpine AS runtime
# needed for helathcheck
RUN apk add --no-cache curl 
WORKDIR /
ENV SPRING_PROFILES_ACTIVE=prod
COPY --from=build /build/target/*.jar /app.jar
RUN mkdir /tmp/tomcat static
EXPOSE 8080 
# Run the application
CMD ["java", "-jar", "app.jar"]

#Developer runtime (extension of production runtime)
FROM runtime AS dev
ENV SPRING_PROFILES_ACTIVE=dev

#Test runtime (extension of production runtime)
FROM runtime AS test
ENV SPRING_PROFILES_ACTIVE=test

#default to production runtime
FROM runtime AS prod
RUN adduser -D backend_template_user
USER backend_template_user
