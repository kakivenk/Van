# Use Debian as the base image
FROM debian

# Install necessary packages for SSH server
RUN apt-get update && apt-get install -y openssh-server

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH server on container startup
CMD ["/usr/sbin/sshd", "-D"]
