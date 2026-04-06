pipeline {
    agent any

    environment {
        DOCKER_CREDS = credentials('dockerhub-creds')  // Docker Hub creds
        DOCKER_USER = "${DOCKER_CREDS_USR}"
        DOCKER_PASS = "${DOCKER_CREDS_PSW}"

        IMAGE_API = "${DOCKER_USER}/devops-api"
        IMAGE_WEB = "${DOCKER_USER}/devops-web"
    }

    triggers {
        // Poll SCM every 5 minutes but build only if new commit exists
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
        success {
            withCredentials([string(credentialsId: 'gmail-app-password', variable: 'GMAIL_APP_PASS')]) {
                emailext(
                    to: 'official.hammadansari@gmail.com',
                    subject: "✅ SUCCESS: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                    body: """
<h3>Build Successful!</h3>
<ul>
<li>Job: ${env.JOB_NAME}</li>
<li>Build Number: ${env.BUILD_NUMBER}</li>
<li>URL: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></li>
</ul>
""",
                    mimeType: 'text/html',
                    from: 'yourgmail@gmail.com',
                    replyTo: 'yourgmail@gmail.com',
                    smtpHost: 'smtp.gmail.com',
                    smtpPort: '587',
                    useSsl: false,
                    useTls: true,
                    authentication: 'plain',
                    smtpUser: 'yourgmail@gmail.com',
                    smtpPassword: "${GMAIL_APP_PASS}"
                )
            }
        }

        failure {
            withCredentials([string(credentialsId: 'gmail-app-password', variable: 'GMAIL_APP_PASS')]) {
                emailext(
                    to: 'official.hammadansari@gmail.com',
                    subject: "❌ FAILURE: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                    body: """
<h3>Build Failed!</h3>
<ul>
<li>Job: ${env.JOB_NAME}</li>
<li>Build Number: ${env.BUILD_NUMBER}</li>
<li>URL: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></li>
</ul>
<p>Please check Jenkins logs for details.</p>
""",
                    mimeType: 'text/html',
                    from: 'yourgmail@gmail.com',
                    replyTo: 'yourgmail@gmail.com',
                    smtpHost: 'smtp.gmail.com',
                    smtpPort: '587',
                    useSsl: false,
                    useTls: true,
                    authentication: 'plain',
                    smtpUser: 'yourgmail@gmail.com',
                    smtpPassword: "${GMAIL_APP_PASS}"
                )
            }
        }
    }
}