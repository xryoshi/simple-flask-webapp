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
                    dockerImage = docker.build registry + ":$BUILD_DATE"
                    dockerImageLatest = docker.build registry + ":latest"
                }
            }
        }
        stage('Push images') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImageLatest.push()
                    }
                }
            }
        }
        stage('Cleanup local images') {
            steps {
                sh "docker rmi $registry:$BUILD_DATE && docker rmi $registry:latest"
            }
        }
    }
}