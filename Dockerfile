FROM alpine:3.7
LABEL description "Sphinx documentation tool"

# Rewrite default value

ENV SPHINX_DEFAULT_THEME sphinx_rtd_theme

# Sphinx-quickstart default value
ENV _SPHINX_DEFAULT_THEME sphinx_rtd_theme
ENV PORT=8000
RUN apk add --update --no-cache \
        python3 \
        py3-pip \
        make && \
        pip3 install --upgrade pip && \
        pip3 install sphinx sphinx_rtd_theme recommonmark sphinx-server gunicorn && \
        mkdir -p /usr/src/dcloud/_html

#RUN mkdir -p /run/nginx
#COPY . /usr/src/dcloud
WORKDIR /usr/src/dcloud

# RUN sed -i "s/${_SPHINX_DEFAULT_THEME}/${SPHINX_DEFAULT_THEME}/g" `find / -name conf.py_t`

#CMD sphinx-quickstart .
CMD sphinx-build -b html . /usr/src/dcloud/_html
EXPOSE 8000
CMD gunicorn -w 1 sphinxserver:app -b 0.0.0.0:8000

## Copy a new configuration file setting listen port to 8080
#COPY ./default.conf /etc/nginx/conf.d/
#EXPOSE 8080
#CMD ["nginx", "-g", "daemon off;"]
