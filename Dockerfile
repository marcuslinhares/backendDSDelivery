# Etapa 1: Construção
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copia o arquivo pom.xml e as dependências primeiro para aproveitar o cache do Docker
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia o código fonte da aplicação
COPY src ./src

# Compila o projeto e gera o arquivo JAR
RUN mvn clean package -DskipTests

# Etapa 2: Execução
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copia o JAR compilado da etapa de construção
COPY --from=build /app/target/*.jar app.jar

# Exponha a porta que sua aplicação utiliza
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
