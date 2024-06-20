FROM ubuntu:24.04

ARG SSH_PUBLIC_KEY

# Install openssh-server
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get install openssh-server -y

# Create .ssh directory
RUN mkdir -p ~/.ssh
RUN cd ~/.ssh
RUN chmod 700 ~/.ssh

# Add public key to authorized_keys
RUN echo $SSH_PUBLIC_KEY >> ~/.ssh/authorized_keys
RUN chmod 700 ~/.ssh/authorized_keys

# Start ssh service
ENTRYPOINT ["sh", "-c", "service ssh start; sleep infinity"]
# ENTRYPOINT ["sh", "-c", "sleep infinity"]
# ENTRYPOINT ["sh"]