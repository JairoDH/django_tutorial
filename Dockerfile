FROM python:3
WORKDIR /usr/src/app
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient
COPY ./django.sh /usr/src/app/
RUN chmod -x /usr/src/app/django.sh
ENV ALLOWED_HOSTS=*
ENV HOST_DJANGO=mariadb
ENV USER_DJANGO=django
ENV PWD_DJANGO=django
ENV DB_DJANGO=django
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
CMD ["/usr/src/app/django.sh"]
