FROM debian:latest

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Update, install tmate, and SSH
RUN apt update && apt upgrade -y && apt install -y \
    ssh tmate

# Expose the SSH port
EXPOSE 22

# Run tmate when the container starts
CMD tmate
