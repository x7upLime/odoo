#!/bin/bash

service postgresql start
su - x7odoo -c "cd /odoo && \
	source ./env/bin/activate && \
	python3 odoo-bin --addons-path=addons -d x7odoo"
