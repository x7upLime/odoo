FROM ubuntu:lunar as intermediate

EXPOSE 8069

ENV POSTGRES_USR=x7odoo

ADD ./ /odoo

RUN apt-get update && apt-get install -y \
	python3 python3-pip python3-venv \
	postgresql postgresql-client \
	libldap2-dev libpq-dev libsasl2-dev

RUN service postgresql start && \
	useradd -m -s /bin/bash $POSTGRES_USR && \
	su - postgres -c \
	"createuser -s $POSTGRES_USR && \
	createdb $POSTGRES_USR"

WORKDIR /odoo

RUN python3 -m venv ./env && \
	. env/bin/activate && \
	pip install -r requirements.txt

CMD ["./x7start.sh"]
