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
                git 'https://github.com/nzjourney/simple-flask-webapp'
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_DATE"
                }
            }
        }
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleanup local image') {
            steps {
                sh "docker rmi $registry:$BUILD_DATE"
            }
        }
    }
}