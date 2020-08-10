# Ensure the contrast security jar is downloaded and available as "contrast.jar" in the appropriate directory.
FROM openjdk:8-slim
RUN mkdir /webgoat7.1
WORKDIR /webgoat7.1
ADD ./webgoat-container/target/webgoat-container-7.1-war-exec.jar /webgoat7.1/webgoat-container-7.1-exec.jar
RUN mkdir /opt/contrast
ADD contrast.jar /opt/contrast
ADD contrast_security.yaml /opt/contrast
EXPOSE 8080
ENV JAVA_TOOL_OPTIONS "-javaagent:/opt/contrast/contrast.jar -Dcontrast.java.agent.standalone_app_name=ws-webgoat -Dcontrast.config.path=/opt/contrast/contrast_security.yaml -Dcontrast.application.tags=workshop,webgoat,dockerfile"
ENTRYPOINT ["java","-jar","/webgoat7.1/webgoat-container-7.1-exec.jar"]
