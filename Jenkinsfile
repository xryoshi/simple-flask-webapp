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
        stage('Build images') {
            steps {
                script {
                    dockerImage = docker.build registry + ":staging-$BUILD_DATE"
                    dockerImageStaging = docker.build registry + ":staging"
                }
            }
        }
        stage('Push images') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImageStaging.push()
                    }
                }
            }
        }
        stage('Cleanup local images') {
            steps {
                sh "docker rmi $registry:staging"
                sh "docker rmi $registry:staging-$BUILD_DATE"
            }
        }
    }
}