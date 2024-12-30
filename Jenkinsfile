pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIAL_ID = 'dockerhub-credentials'  // DockerHub credentials ID from Jenkins credentials store
        DOCKERHUB_REPOSITORY = 'dhineshpandian/project-aram'  // Your DockerHub repository
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')  // AWS access key
        AWS_SECRET_ACCESS_KEY = credentials('aws-access-key')  // AWS secret key
    }
    

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning GitHub repository...'
                git(
                    url: 'https://github.com/Dhinesh-0309/project-aram.git',  // GitHub repository URL
                    branch: 'main'  // Checkout the main branch
                )
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    dockerImage = docker.build("${DOCKERHUB_REPOSITORY}:latest")  // Build the Docker image with the latest tag
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                echo 'Logging into DockerHub...'
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIAL_ID, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh '''
                        echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                    '''  // Login to DockerHub using the credentials from Jenkins
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to DockerHub...'
                sh 'docker push ${DOCKERHUB_REPOSITORY}:latest'  // Push the built Docker image to DockerHub
            }
        }
        
        stage('Deploy to AWS ECS') {
            steps {
                echo 'Deploying Docker image to AWS ECS...'
                sh '''
                    aws ecs update-service --cluster ARAM-app-cluster --service aram-service --force-new-deployment

                '''  
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up temporary files and Docker images...'
            // Clean up any resources, if needed, or notify about the pipeline status
        }
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed, check the logs for errors!'
        }
    }
}
