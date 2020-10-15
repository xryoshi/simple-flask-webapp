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
                withPythonEnv('python3') {
                    sh "pip3 install -r requirements.txt"
                }
            }
        }
        stage('Test routes') {
            steps {
                withPythonEnv('python3') {
                    sh "python3 -m pytest tests/routes.py"
                }
            }
        }
        stage('Build images for production') {
            when {
                branch 'master'
            }
            steps {
                script {
                    dockerImageLatest = docker.build registry + ":production"                }
            }
        }
        stage('Build images for staging') {
            when {
                branch 'staging'
            }
            steps {
                script {
                    dockerImageLatest = docker.build registry + ":staging"
                }
            }
        }
        stage('Build images for development') {
            when {
                branch 'devel'
            }
            steps {
                script {
                    dockerImageLatest = docker.build registry + ":devel-$BUILD_DATE"
                }
            }
        }
        stage('Push images') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImageLatest.push()
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
            }
        }
        stage('Cleanup local staging images') {
            when {
                branch 'staging'
            }
            steps {
                sh "docker rmi $registry:staging"
            }
        }
        stage('Cleanup local development images') {
            when {
                branch 'devel'
            }
            steps {
                sh "docker rmi $registry:devel-$BUILD_DATE"
            }
        }
    }
}