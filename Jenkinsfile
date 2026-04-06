pipeline {
    agent any

    environment {
        DOCKER_CREDS = credentials('dockerhub-creds')
        DOCKER_USER = "${DOCKER_CREDS_USR}"
        DOCKER_PASS = "${DOCKER_CREDS_PSW}"

        IMAGE_API = "${DOCKER_USER}/devops-api"
        IMAGE_WEB = "${DOCKER_USER}/devops-web"
    }

    triggers {
        pollSCM('H/5 * * * *')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/hammadansari0/devops-vote-cicd'
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
                withCredentials([file(credentialsId: 'k3s-config', variable: 'KUBECONFIG')]) {
                    sh '''
                    kubectl apply -f db/manifests/
                    kubectl apply -f db/database-seed.yaml
                    kubectl apply -f api/manifests/
                    kubectl apply -f web/manifests/
                    kubectl rollout restart deployment api
                    kubectl rollout restart deployment web
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                def status = currentBuild.currentResult

                mail(
                    to: 'official.hammadansari@gmail.com',
                    subject: "${status}: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """
    Build Status: ${status}

    Job: ${env.JOB_NAME}
    Build Number: ${env.BUILD_NUMBER}
    URL: ${env.BUILD_URL}
    """
                )
            }
        }
    }
}