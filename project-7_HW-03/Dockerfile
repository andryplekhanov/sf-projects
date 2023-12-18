FROM python:3.10-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /srv/app/
RUN mkdir "conf"

RUN pip install --no-cache-dir --upgrade pip &&  \
    pip install flask==3.0.0 && \
    pip install psycopg2-binary==2.9.9 && \
    pip install configparser==6.0.0

COPY web.conf /srv/app/conf/web.conf
COPY web.py .

ENTRYPOINT ["python3", "web.py"]
