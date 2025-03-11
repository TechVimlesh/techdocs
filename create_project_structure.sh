#!/bin/bash

# Define the project structure
mkdir -p kafka-test-app/src/main/java/com/example/kafkatest/config
mkdir -p kafka-test-app/src/main/java/com/example/kafkatest/controller
mkdir -p kafka-test-app/src/main/java/com/example/kafkatest/model
mkdir -p kafka-test-app/src/main/java/com/example/kafkatest/service
mkdir -p kafka-test-app/src/main/resources/static
mkdir -p kafka-test-app/src/test/java/com/example/kafkatest

# Create empty files
touch kafka-test-app/pom.xml
touch kafka-test-app/src/main/java/com/example/kafkatest/KafkaTestApplication.java
touch kafka-test-app/src/main/java/com/example/kafkatest/config/KafkaConfig.java
touch kafka-test-app/src/main/java/com/example/kafkatest/config/KafkaConfigProperties.java
touch kafka-test-app/src/main/java/com/example/kafkatest/controller/KafkaController.java
touch kafka-test-app/src/main/java/com/example/kafkatest/model/KafkaConfigRequest.java
touch kafka-test-app/src/main/java/com/example/kafkatest/model/KafkaMessageRequest.java
touch kafka-test-app/src/main/java/com/example/kafkatest/service/KafkaService.java
touch kafka-test-app/src/main/resources/application.properties
touch kafka-test-app/src/main/resources/static/index.html
touch kafka-test-app/src/test/java/com/example/kafkatest/KafkaTestApplicationTests.java
touch kafka-test-app/README.md

echo "Project structure created successfully."
