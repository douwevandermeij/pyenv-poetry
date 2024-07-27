# Proper Python setup with pyenv & Poetry

This repository part of a Medium article: https://douwevandermeij.medium.com/proper-python-setup-with-pyenv-poetry-4d8baea329a8

**Don't use this Dockerfile in production** as it is too bloated.

## Getting started

Ensure you have Docker installed. See https://docs.docker.com/get-docker/

Run `make` or build and run the Dockerfile manually.

When inside the Docker container terminal, run:

```bash
cd testapp
poetry shell
```

When inside the shell run:

```bash
which python
python -V
```

Notice your active Python version is 3.12.1 and from the `.../pypoetry/virtualenvs` directory.
