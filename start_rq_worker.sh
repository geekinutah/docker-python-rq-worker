#!/bin/bash

# Need to get PIP_PACKAGES from environ and install

if [ ${PIP_PACKAGES} != 'none' ]; then
    for i in $(echo ${PIP_PACKAGES} | sed 's/,/ /g'); do
        pip install $i
    done
fi

# If there is a requirements file, install that

if [ ${PIP_REQUIREMENTS} != 'none' ]; then
    pip install -r $i
fi

cat /etc/supervisor/conf.d/rqworker.conf.j2 | python -c 'import os;import sys; import jinja2; sys.stdout.write(jinja2.Template(sys.stdin.read()).render(env=os.environ))' > /etc/supervisor/conf.d/rqworker.conf

supervisord -n
