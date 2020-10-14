FROM python:3.9.0-slim

LABEL maintainer=nizar.lazuardy@gmail.com

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
RUN mkdir -p /usr/src/app && \
    chown appuser:appuser /usr/src/app
USER appuser

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 5000
CMD [ "gunicorn", "main:app", "-w", "2", "--threads", "2", "-b", "0.0.0.0:5000" ]