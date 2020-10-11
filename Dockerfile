FROM python:3.9.0-slim

LABEL maintainer=nizar.lazuardy@gmail.com

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 5000
CMD [ "gunicorn", "main:app", "-w", "2", "--threads", "2", "-b", "0.0.0.0:5000" ]