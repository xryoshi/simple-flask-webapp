FROM python:3.9

LABEL maintainer=nizar.lazuardy@gmail.com

WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

ENTRYPOINT ["python"]
CMD [ "main.py" ]