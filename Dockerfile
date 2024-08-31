# Etapa 1: Construção do projeto
FROM maven:3.8.5-openjdk-11 AS build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo pom.xml e os arquivos de código-fonte para o diretório de trabalho
COPY pom.xml .
COPY src ./src

# Executa o Maven para compilar o projeto e gerar o arquivo JAR
RUN mvn clean package -DskipTests

# Etapa 2: Execução
FROM openjdk:11-jre-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o JAR gerado da etapa de construção para o diretório de trabalho do novo container
COPY --from=build /app/target/dsdeliver-0.0.1-SNAPSHOT.jar ./app.jar

# Expõe a porta em que a aplicação será executada
EXPOSE 8080

# Define o comando para executar a aplicação
CMD ["java", "-jar", "app.jar"]
