### How to run

For production:
```
$ sudo docker pull nzjourney/simple-flask-webapp:production
$ sudo docker run -p 5000:5000 --name simple-flask-webapp -d nzjourney/simple-flask-webapp:production
```

For staging:
```
$ sudo docker pull nzjourney/simple-flask-webapp:staging
$ sudo docker run -p 5000:5000 --name simple-flask-webapp -d nzjourney/simple-flask-webapp:staging
```
