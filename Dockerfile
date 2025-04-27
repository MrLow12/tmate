
FROM debian

# Set non-interactive mode
ARG REGION=ap
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt update && apt upgrade -y && apt install -y \
    ssh wget unzip vim curl python3 tmate

# Install tmate
RUN wget -q https://github.com/tmate-io/tmate/releases/download/v2.4.0/tmate-2.4.0-linux-x86_64.tar.gz -O /tmate.tar.gz \
    && tar -xzvf /tmate.tar.gz -C /usr/local/bin/ \
    && rm -f /tmate.tar.gz

# Setup SSH
RUN mkdir /run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo root:craxid | chpasswd

# Command to run tmate
RUN echo "/usr/local/bin/tmate -F > /tmp/tmate.log &" >> /openssh.sh \
    && echo "sleep 5" >> /openssh.sh \
    && echo "SESSION=$(grep -o 'ssh [^ ]*' /tmp/tmate.log)" >> /openssh.sh \
    && echo "echo 'Connect to this session using: $SESSION'" >> /openssh.sh \
    && echo '/usr/sbin/sshd -D' >> /openssh.sh

# Expose SSH and required ports
EXPOSE 22 4040

# Run script to start tmate and SSH
CMD /openssh.sh
