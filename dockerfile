FROM python:3.11.3-alpine as build

WORKDIR /var/www/Weather_app

# update system
RUN apk update

# copy requirements file from local file system to container
COPY ./requirements.txt .

# install python requirements for Weather_app
RUN pip install -r requirements.txt

################################################

FROM python:3.11.3-alpine

RUN addgroup -S app && adduser -S -G app app

# copy python libraries from build stage
COPY --from=build /usr/local/lib/python3.11 /usr/local/lib/python3.11

# copy gunicorn from build stage
COPY --from=build /usr/local/bin/gunicorn /usr/local/bin/gunicorn

WORKDIR /var/www/Weather_app

# copy project files from file system to /var/www/Weather_app on container
COPY ./Weather_app .

RUN chown -R app:app /var/www/Weather_app

USER app

CMD ["gunicorn", "-b", "0.0.0.0:8000", "--workers", "3", "-m", "007", "wsgi:app"]