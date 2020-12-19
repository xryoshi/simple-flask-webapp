### How to run

App Requirements:
```
python3
Docker & Docker compose (optional)
```

Jenkins Requirements:
```
python3
python3-pip
python3-virtualenv
java-1.8.0-openjdk
```

Jenkins Plugins:
```
https://plugins.jenkins.io/docker-workflow/
https://plugins.jenkins.io/docker-plugin/
https://plugins.jenkins.io/pyenv-pipeline/
https://plugins.jenkins.io/shiningpanda/ (optional)
```

Run with python (not recommended for production):
```
$ python3 main.py
```

Run with gunicorn:
```
$ gunicorn main:app -w 2 --threads 2 -b 0.0.0.0:5000
```

Run with Docker:
```
$ sudo docker pull nzjourney/simple-flask-webapp:tag
$ sudo docker run -p 5000:5000 --name simple-flask-webapp -d nzjourney/simple-flask-webapp:tag
```

Stop with Docker:
```
$ sudo docker stop simple-flask-webapp
```

Run with Docker Compose:
```
$ sudo docker-compose build --pull
$ sudo docker-compose up
or with detached
$ sudo docker-compose up -d
```

Stop with Docker Compose:
```
$ sudo docker-compose stop
or bring everything down, removing the container, and volume entirely
$ sudo docker-compose down --volumes
```

Copyright 2020