FROM debian:latest

# Set non-interactive mode
ARG REGION=ap
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt update && apt upgrade -y && apt install -y \
    ssh tmate curl python3

# Setup SSH
RUN mkdir /run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo root:craxid | chpasswd

# Run tmate and SSH
RUN echo "tmate -F > /tmp/tmate.log &" >> /openssh.sh \
    && echo "sleep 5" >> /openssh.sh \
    && echo "SESSION=$(grep -o 'ssh [^ ]*' /tmp/tmate.log)" >> /openssh.sh \
    && echo "echo 'Connect to this session using: $SESSION'" >> /openssh.sh \
    && echo '/usr/sbin/sshd -D' >> /openssh.sh

# Expose SSH and required ports
EXPOSE 22 4040

# Run script to start tmate and SSH
CMD /openssh.sh
