#!/bin/bash

# Muda para o diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Verifica se está rodando no GitHub Actions
if [ "$CI" = "true" ]; then
    # No GitHub Actions, usa o Java do Temurin
    JAVA_HOME="/opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/17.0.14-7/x64"
    # Atualiza o gradle.properties
    if [ -f "gradle.properties" ]; then
        sed -i '' "s#org.gradle.java.home=.*#org.gradle.java.home=$JAVA_HOME#" gradle.properties
    else
        echo "org.gradle.java.home=$JAVA_HOME" > gradle.properties
    fi
else
    # Localmente, tenta primeiro o OpenJDK do Homebrew
    if [ -d "/opt/homebrew/opt/openjdk@17" ]; then
        JAVA_HOME="/opt/homebrew/opt/openjdk@17"
        # Atualiza o gradle.properties
        if [ -f "gradle.properties" ]; then
            sed -i '' "s#org.gradle.java.home=.*#org.gradle.java.home=$JAVA_HOME#" gradle.properties
        else
            echo "org.gradle.java.home=$JAVA_HOME" > gradle.properties
        fi
    else
        echo "Java não encontrado em /opt/homebrew/opt/openjdk@17, usando Temurin..."
        JAVA_HOME="/opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/17.0.14-7/x64"
        # Atualiza o gradle.properties
        if [ -f "gradle.properties" ]; then
            sed -i '' "s#org.gradle.java.home=.*#org.gradle.java.home=$JAVA_HOME#" gradle.properties
        else
            echo "org.gradle.java.home=$JAVA_HOME" > gradle.properties
        fi
    fi
fi

# Exporta a variável JAVA_HOME
export JAVA_HOME

# Verifica se o gradlew existe
if [ ! -f "./gradlew" ]; then
    echo "Erro: gradlew não encontrado em $SCRIPT_DIR"
    exit 1
fi

# Executa o comando gradle passado como argumento
./gradlew "$@" 