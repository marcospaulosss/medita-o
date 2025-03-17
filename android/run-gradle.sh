#!/bin/bash

# Verifica se está rodando no GitHub Actions
if [ "$CI" = "true" ]; then
    # No GitHub Actions, usa o Java do Temurin
    export JAVA_HOME="/opt/hostedtoolcache/Java_Temurin-Hotspot_jdk/17.0.14-7/x64"
else
    # Localmente, tenta primeiro o OpenJDK do Homebrew
    if [ -d "/opt/homebrew/opt/openjdk@17" ]; then
        export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
    else
        echo "Java não encontrado em /opt/homebrew/opt/openjdk@17"
        exit 1
    fi
fi

# Executa o comando gradle passado como argumento
./gradlew "$@" 