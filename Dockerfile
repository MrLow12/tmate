FROM debian:latest

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Update, install tmate
RUN apt update && apt upgrade -y && apt install -y \
    ssh tmate

# Expose SSH port
EXPOSE 22

# Run tmate in the background
CMD tmate -F
