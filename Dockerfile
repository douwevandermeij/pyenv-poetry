FROM debian:latest

# Update package list and install necessary tools
RUN apt-get update && \
    apt-get install -y curl git sudo

# Create a new user and add to sudoers
RUN useradd -m -s /bin/bash newuser && echo "newuser:password" | chpasswd && adduser newuser sudo
RUN echo "newuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user and set the default shell
USER newuser
WORKDIR /home/newuser

# Install pyenv
RUN curl https://pyenv.run | bash

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile && \
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile && \
    echo 'eval "$(pyenv init -)"' >> ~/.profile

# Install suggested build environment
RUN sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl git \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install Python 3.11 and 3.12
RUN /home/newuser/.pyenv/bin/pyenv install 3.11.7
RUN /home/newuser/.pyenv/bin/pyenv install 3.12.1

# Set Python versions
RUN /home/newuser/.pyenv/bin/pyenv global 3.11.7
RUN mkdir testapp && \
    cd testapp && \
    /home/newuser/.pyenv/bin/pyenv local 3.12.1

# Install pipx
RUN sudo apt-get install -y pipx && \
    pipx ensurepath

# Install Poetry
RUN pipx install poetry

# Create a virtual environment with Poetry
RUN cd testapp && \
    /home/newuser/.local/bin/poetry init -q && \
    /home/newuser/.local/bin/poetry env use $(/home/newuser/.pyenv/bin/pyenv which python)

CMD ["/bin/bash", "-l"]
