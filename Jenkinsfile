pipeline {
    environment {
        registry = "nzjourney/simple-flask-webapp"
        registryCredential = 'dockerhub'
        def BUILD_DATE = sh(script: "echo `date +%Y%m%d%k%M%S`", returnStdout: true).trim()
    }
    agent any
    stages {
        stage('Clone repository') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/nzjourney/simple-flask-webapp.git'
            }
        }
        stage('Install requirement') {
            steps {
                sh "pip3 install -r requirements.txt"
            }
        }
        stage('Test routes') {
            steps {
                sh "pytest tests/routes.py"
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_DATE"
                    dockerImageLatest = docker.build registry + ":latest"
                }
            }
        }
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImageLatest.push()
                    }
                }
            }
        }
        stage('Cleanup local image') {
            steps {
                sh "docker rmi $registry:$BUILD_DATE && docker rmi $registry:latest"
            }
        }
    }
}