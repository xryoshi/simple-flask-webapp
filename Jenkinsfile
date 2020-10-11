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
        stage('Build images production') {
            when {
                branch 'production'
            }
            steps {
                script {
                    dockerImage = docker.build registry + ":production-$BUILD_DATE"
                    dockerImageLatest = docker.build registry + ":production"
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
                sh "docker rmi $registry:production"
                sh "docker rmi $registry:production-$BUILD_DATE"
            }
        }
    }
}