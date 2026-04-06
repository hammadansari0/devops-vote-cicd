pipeline {
    agent any

    environment {
        DOCKER_CREDS = credentials('dockerhub-creds')
        DOCKER_USER = "${DOCKER_CREDS_USR}"
        DOCKER_PASS = "${DOCKER_CREDS_PSW}"

        IMAGE_API = "${DOCKER_USER}/devops-api"
        IMAGE_WEB = "${DOCKER_USER}/devops-web"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/hammadansari0/devops-vote-cicd'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '''
                docker build -t $IMAGE_API:latest ./api
                docker build -t $IMAGE_WEB:latest ./web
                '''
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                '''
            }
        }

        stage('Push Images') {
            steps {
                sh '''
                docker push $IMAGE_API:latest
                docker push $IMAGE_WEB:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([string(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_CONTENT')]) {
                    sh '''
                    echo "$KUBECONFIG_CONTENT" > kubeconfig
                    export KUBECONFIG=$(pwd)/kubeconfig

                    kubectl apply -f db/manifests/
                    kubectl apply -f api/manifests/
                    kubectl apply -f web/manifests/

                    kubectl rollout restart deployment api
                    kubectl rollout restart deployment web
                    '''
                }
            }
        }
    }
}