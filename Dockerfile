FROM python:3.9.0-slim

LABEL maintainer=nizar.lazuardy@gmail.com

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 5000
CMD [ "python", "main.py" ]