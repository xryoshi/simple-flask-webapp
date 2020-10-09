FROM python:3.9

LABEL maintainer=nizar.lazuardy@gmail.com

# copy all files to app directory
RUN app
COPY . /app
WORKDIR /app

# install required libraries
RUN pip install -r requirements.txt

# exec application
EXPOSE 5000
ENTRYPOINT ["python"]
CMD [ "main.py" ]