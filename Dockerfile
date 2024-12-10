# Use your existing WildFly image as base
FROM wildfly:latest

# Switch to root to install additional tools
USER root

# Args for VS Code Server - adjust version to match your VS Code version
ARG VSCODE_SERVER_VERSION=1.86.0
ARG COMMIT_ID=8b3775030ed1a69b13e4f4c628c612102e30a681

# Create directory structure
RUN mkdir -p /home/jboss/.vscode-server/bin/${COMMIT_ID} && \
    mkdir -p /home/jboss/workspace && \
    chown -R jboss:0 /home/jboss && \
    chmod -R g+rw /home/jboss

# Copy VS Code Server files from local machine
COPY --chown=jboss:0 vscode-server-linux-x64.tar.gz /home/jboss/.vscode-server/bin/${COMMIT_ID}/

# Extract VS Code Server
RUN cd /home/jboss/.vscode-server/bin/${COMMIT_ID} && \
    tar xzf vscode-server-linux-x64.tar.gz --strip-components 1 && \
    rm vscode-server-linux-x64.tar.gz

# Switch back to jboss user
USER jboss

# Set working directory
WORKDIR /home/jboss/workspace
