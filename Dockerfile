FROM debian:latest

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Update, install tmate, and SSH
RUN apt update && apt upgrade -y && apt install -y \
    ssh tmate

# Expose SSH port
EXPOSE 22

# Run tmate in background and redirect output to a file
CMD tmate -F & tail -f /tmp/tmate.log
