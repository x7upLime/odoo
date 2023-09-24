#!/bin/bash

## to be ran in container spawn without the Containerfile

apt-get update
apt-get install -y \
	postgresql postgresql-client \
	python3-pip libldap2-dev \
	libpq-dev libsasl2-dev \
	python3-venv

service postgresql start

su - postgres -c "createuser -s x7odoo && \
	createdb x7odoo"

python3 -m venv ./env
. ./env/bin/activate
pip install -r requirements.txt

useradd -m -s /bin/bash x7odoo
su - x7odoo
cd /odoo
