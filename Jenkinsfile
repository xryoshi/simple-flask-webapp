pipeline {
    environment {
        registry = "nzjourney/simple-flask-webapp"
        registryCredential = 'dockerhub'
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
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Cleanup local image') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER && docker rmi $registry:latest"
            }
        }
    }
}