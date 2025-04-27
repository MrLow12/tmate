# Gunakan image resmi tmate-ssh-server dari Docker Hub
FROM tmate/tmate-ssh-server:2.3.0

# Set environment variable (opsional)
ARG REGION=ap
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH dan curl (kalau belum ada)
RUN apt update && apt upgrade -y && apt install -y curl

# Setup root login password (default 'craxid')
RUN echo 'root:craxid' | chpasswd

# Expose SSH port dan tmate API port
EXPOSE 22 4040

# Start SSH server dan tmate secara bersamaan
CMD /usr/sbin/sshd -D & tmate -F
