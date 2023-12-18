# Homework 7.8.7

- build: `docker build . -t favdown-img`
- run: `docker run --name favdown-app -e SITE_URL="https://www.python.org/" -v /tmp/fav:/opt/tmp favdown-img`
- result: `ls -l /tmp/fav`
- remove container: `docker rm favdown-app`
- remove image: `docker rmi favdown-img`
