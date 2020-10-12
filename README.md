### How to run

Requirements:
```
python v3.x
```

Run with python (not recommended for production):
```
$ python3 main.py
```

Run with gunicorn:
```
$ gunicorn main:app -w 2 --threads 2 -b 0.0.0.0:5000
```

Run with docker (production):
```
$ sudo docker pull nzjourney/simple-flask-webapp:production
$ sudo docker run -p 5000:5000 --name simple-flask-webapp -d nzjourney/simple-flask-webapp:production
```

Run with docker (staging):
```
$ sudo docker pull nzjourney/simple-flask-webapp:staging
$ sudo docker run -p 5000:5000 --name simple-flask-webapp -d nzjourney/simple-flask-webapp:staging
```