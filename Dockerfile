# name of the image
FROM python:3.9-alpine3.13

LABEL maintainer="rkp1819@gmail.com"

# prevent python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1


# copy the requirements file into the container
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
# copy the rest of the application code into the container
COPY ./app /app

COPY ./pyproject.toml /pyproject.toml

# set the working directory in the container
WORKDIR /app

# this way we can connect to the container from the outside
EXPOSE 8000

# by default the environment is production
ARG DEV=false


# install the dependencies
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    # if the environment is development, then install the development dependencies
    if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    # Run linting during build time if DEV is true
    if [ $DEV = "true" ]; \
    then cd /app && /py/bin/ruff check . ; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

# switch to the app user
USER django-user

# set the working directory for the app user
WORKDIR /app


