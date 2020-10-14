FROM python:3.9.0-slim

LABEL maintainer=nizar.lazuardy@gmail.com

# Create appuser
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
RUN mkdir -p /usr/src/app && \
    chown appuser:appuser /usr/src/app

# Copy the source code
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .

# Run application
EXPOSE 5000
USER appuser
CMD [ "gunicorn", "main:app", "-w", "2", "--threads", "2", "-b", "0.0.0.0:5000" ]