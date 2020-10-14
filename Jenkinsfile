pipeline {
    environment {
        registry = "nzjourney/simple-flask-webapp"
        registryCredential = 'dockerhub'
        def BUILD_DATE = sh(script: "echo `date +%Y%m%d%k%M%S` | sed 's/ //g'", returnStdout: true).trim()
    }
    agent any
    stages {
        stage('Install libraries') {
            steps {
                sh "pip3 install -r requirements.txt --user"
            }
        }
        stage('Test routes') {
            steps {
                sh "python3 -m pytest tests/routes.py"
            }
        }
        stage('Build images for production') {
            when {
                branch 'master'
            }
            steps {
                script {
                    dockerImageLatest = docker.build registry + ":production"
                    dockerImage = docker.build registry + ":production-$BUILD_DATE"
                }
            }
        }
        stage('Build images for staging') {
            when {
                branch 'staging'
            }
            steps {
                script {
                    dockerImageLatest = docker.build registry + ":staging"
                    dockerImage = docker.build registry + ":staging-$BUILD_DATE"
                }
            }
        }
        stage('Build images for development') {
            when {
                branch 'development'
            }
            steps {
                script {
                    dockerImageLatest = docker.build registry + ":development"
                    dockerImage = docker.build registry + ":development-$BUILD_DATE"
                }
            }
        }
        stage('Push images') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImageLatest.push()
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleanup local production images') {
            when {
                branch 'master'
            }
            steps {
                sh "docker rmi $registry:production"
                sh "docker rmi $registry:production-$BUILD_DATE"
            }
        }
        stage('Cleanup local staging images') {
            when {
                branch 'staging'
            }
            steps {
                sh "docker rmi $registry:staging"
                sh "docker rmi $registry:staging-$BUILD_DATE"
            }
        }
        stage('Cleanup local development images') {
            when {
                branch 'development'
            }
            steps {
                sh "docker rmi $registry:development"
                sh "docker rmi $registry:development-$BUILD_DATE"
            }
        }
    }
}