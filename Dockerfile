# Use a base image with Terraform pre-installed
FROM hashicorp/terraform:latest
# Install additional tools if required
RUN apk add --no-cache git bash curl
# Set the working directory
WORKDIR /app
# Copy your Jenkinsfile and Terraform configuration
COPY . /app
# Set default command
CMD ["bash"]
