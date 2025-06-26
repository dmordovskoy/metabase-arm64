# Fixed ARM64 Metabase Dockerfile for Coolify
FROM eclipse-temurin:17-jre-jammy

# Set environment variables
ENV MB_PLUGINS_DIR=/plugins
ENV JAVA_TIMEZONE=UTC

# Create metabase user
RUN groupadd -r metabase && useradd --no-log-init -r -g metabase metabase

# Create necessary directories
RUN mkdir -p /app /plugins /metabase-data && \
    chown -R metabase:metabase /app /plugins /metabase-data

# Install dependencies and get latest version
RUN apt-get update && apt-get install -y wget curl jq && \
    LATEST_VERSION=$(curl -s https://api.github.com/repos/metabase/metabase/releases/latest | jq -r '.tag_name') && \
    echo "Downloading Metabase version: $LATEST_VERSION" && \
    wget -O /app/metabase.jar "https://downloads.metabase.com/${LATEST_VERSION}/metabase.jar" && \
    apt-get remove -y wget jq && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set proper permissions
RUN chown metabase:metabase /app/metabase.jar

# Switch to metabase user
USER metabase

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:3000/api/health || exit 1

# Start Metabase (using official JAR startup method)
CMD ["java", "--add-opens", "java.base/java.nio=ALL-UNNAMED", "-jar", "metabase.jar"]