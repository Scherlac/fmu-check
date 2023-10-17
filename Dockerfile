FROM bcr-de01.inside.bosch.cloud/scl2bp/osd7devbase:dev-latest

ARG http_proxy=http://host.docker.internal:3128
ARG https_proxy=http://host.docker.internal:3128
ARG no_proxy=".bosch.com,.localhost,localhost,127.0.0.1"


WORKDIR "/app"

# activate pip environment
ENV VIRTUAL_ENV=${PIPENV_HOME} \
    PATH=${PIPENV_HOME}/bin:$PATH

# [Optional] If your pip requirements rarely change, uncomment this section to add them to the image.
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
    && rm -rf /tmp/pip-tmp

COPY . ./

EXPOSE 8080
# CMD gunicorn --bind 0.0.0.0:8080 app:app.server
CMD gunicorn --bind 0.0.0.0:8080 app:server