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




# Makefile for creating Docker containers

.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  ping-container      Build container with ping support"
	@echo "  ssh-container       Build container with SSH support"
	@echo "  clean               Remove containers and images"

ping-container:
	docker build -t ping-container -f Dockerfile.ping .

ssh-container:
	docker build -t ssh-container -f Dockerfile.ssh .

clean:
	docker stop $$(docker ps -a -q) && docker rm $$(docker ps -a -q)
	docker rmi -f ping-container ssh-container
