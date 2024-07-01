FROM ubuntu:24.04

ARG SSH_PUBLIC_KEY

# Install openssh-server
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get install openssh-server -y

# Create .ssh directory
RUN mkdir -p ~/.ssh
RUN chmod 700 ~/.ssh

# Install python build deps
RUN DEBIAN_FRONTEND=noninteractive apt-get install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

# Install pyenv
RUN curl https://pyenv.run | bash
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
RUN echo 'eval "$(pyenv init -)"' >> ~/.profile
RUN bash -c "source ~/.profile && pyenv install 3.11.8"
RUN bash -c "source ~/.profile && pyenv virtualenv 3.11.8 py-311-env"
RUN bash -c "source ~/.profile && pyenv global py-311-env"

# Current requirements:
# Flask ~= 3.0.3
# Flask-Cors ~= 4.0.1
# llama-index ~= 0.10.44
# python-dotenv ~= 0.19
# vllm ~= 0.5.0.post1
RUN bash -c "source ~/.profile && pip install 'Flask~=3.0.3'"
RUN bash -c "source ~/.profile && pip install 'Flask-Cors~=4.0.1'"
RUN bash -c "source ~/.profile && pip install 'llama-index~=0.10.44'"
RUN bash -c "source ~/.profile && pip install 'python-dotenv~=0.19'"
RUN bash -c "source ~/.profile && pip install 'vllm~=0.5.0.post1'"
RUN bash -c "source ~/.profile && pip install 'llama-index-embeddings-huggingface~=0.2.2'"
RUN bash -c "source ~/.profile && pip install 'llama-index-llms-vllm~=0.1.8'"
RUN bash -c "source ~/.profile && pip install 'fastapi~=0.111.0'"


# Add public key to authorized_keys
RUN echo $SSH_PUBLIC_KEY >> ~/.ssh/authorized_keys
RUN chmod 700 ~/.ssh/authorized_keys

# Start ssh service
ENTRYPOINT ["sh", "-c", "service ssh start; sleep infinity"]
# ENTRYPOINT ["sh", "-c", "sleep infinity"]
# ENTRYPOINT ["sh"]