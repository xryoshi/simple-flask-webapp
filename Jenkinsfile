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
            if (env.BRANCH_NAME == 'master') {
                steps {
                    script {
                        dockerImage = docker.build registry + ":production-$BUILD_DATE"
                        dockerImageProduction = docker.build registry + ":production"
                    }
                }
            }
            else if (env.BRANCH_NAME == 'staging') {
                steps {
                    script {
                        dockerImage = docker.build registry + ":staging-$BUILD_DATE"
                        dockerImageStaging = docker.build registry + ":staging"
                    }
                }
            }
        }
        stage('Push images') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImageProduction.push()
                    }
                }
            }
        }
        stage('Cleanup local images (production)') {
            steps {
                sh "docker rmi $registry:production"
                sh "docker rmi $registry:production-$BUILD_DATE"
            }
        }
    }
}