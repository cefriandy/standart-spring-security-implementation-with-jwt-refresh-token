pipeline{
    agent any
    tools{
        maven 'maven_3_8_5'
    }
    stages{
        stage('Build Maven'){
            steps{
                // checkout code from github
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/cefriandy/standart-spring-securit-implementation-with-refresh-token.git']])
                // do clean install
                bat 'mvn clean install'
            }
        }
        stage('Build Docker Image'){
            steps{
                script{
                    bat 'docker build -t cefriandy/auth-service .'
                }
            }
        }
        stage('Push docker image to docker hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                    // bat 'docker login'
                    bat "docker login -u cefriandy -p ${dockerhub}"
                    }
                }
                // do push to dockerhub
                bat 'docker push cefriandy/auth-service'
            }
        }
        stage('Deploy to kubernetes cluster'){
            steps{
                script{
                    // do push to kubernetes
                    kubernetesDeploy configs: 'auth-service-deployment.yaml', kubeConfig: [path: ''], kubeconfigId: 'k8sdiscoverypwd', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
                }
            }
        }
    }
}