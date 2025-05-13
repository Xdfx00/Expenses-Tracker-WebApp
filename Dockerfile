# stage-1 - jar builder using maven 

# Maven+java image 
FROM maven:3.8.5-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy source code in container /app
COPY . /app


# Build maven application and skip test cases
RUN mvn clean install -DskipTests=true

#EXPOSE 8080

#ENTRYPOINT ["java", "-jar", "target/ExpensesTracker-0.0.1-SNAPSHOT.jar"]


##-----------------------------------------------
#	Stage-2
##-----------------------------------------------

# Import java small image
FROM openjdk:17-slim

# Copy application code from the builder stage-2
COPY --from=builder /app/target/*.jar /app/target/

# Expose port 8080
EXPOSE 8080


# Start application
ENTRYPOINT ["java", "-jar", "/app/target/ExpensesTracker-0.0.1-SNAPSHOT.jar"]


