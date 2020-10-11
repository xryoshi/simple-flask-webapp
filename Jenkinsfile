pipeline {
    environment {
        registry = "nzjourney/simple-flask-webapp"
        registryCredential = 'dockerhub'
        env = 'staging'
        def BUILD_DATE = sh(script: "echo `date +%Y%m%d%k%M%S` | sed 's/ //g'", returnStdout: true).trim()
    }
    agent any
    stages {
        stage('Install libraries ($env)') {
            steps {
                sh "pip3 install -r requirements.txt --user"
            }
        }
        stage('Test routes ($env)') {
            steps {
                sh "python3 -m pytest tests/routes.py"
            }
        }
        stage('Build images ($env)') {
            steps {
                script {
                    dockerImage = docker.build registry + ":production-$BUILD_DATE"
                    dockerImageProduction = docker.build registry + ":production"
                }
            }
        }
        stage('Push images ($env)') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImageProduction.push()
                    }
                }
            }
        }
        stage('Cleanup local images ($env)') {
            steps {
                sh "docker rmi $registry:production"
                sh "docker rmi $registry:production-$BUILD_DATE"
            }
        }
    }
}