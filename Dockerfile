FROM debian:jessie

ENV PGDATABASE nics
ENV PGHOST postgis
ENV PGPASSWORD postgres
ENV PGPORT 5432
ENV PGUSER postgres

RUN apt-get update && \
  apt-get install -y postgresql-client uuid-runtime && \
  rm -rf /var/lib/apt/lists/*

COPY . /opt/nics/nics-db

RUN useradd -Um nics
USER nics

RUN echo $PGHOST:$PGPORT:$PGDATABASE:$PGPASSWORD > ~/.pgpass && chmod 0600 ~/.pgpass
