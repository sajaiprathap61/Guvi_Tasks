pipeline {
    agent any

    environment {
        // Default values for Docker image and tag
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials-id'
        GITHUB_CREDENTIALS = 'github-credentials-id'
        DOCKER_TAG = 'latest'
        EC2_USER = 'ubuntu'
        EC2_IP = '18.136.196.121' // EC2 public IP address
        CONTAINER_NAME = 'devops-build-devops-react-app-1' // Container name
        SSH_KEY_PATH = 'Ubuntu' // Jenkins can use its credential store for security
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Checkout the code from GitHub repository triggered by the webhook
                    checkout scm
                    // Set branch-related variables
                    if (env.GIT_BRANCH ==~ /^origin\/dev/) {
                        env.DOCKER_IMAGE = 'sajaiprathap/dev' // Docker image for dev
                        env.BRANCH = 'dev' // Branch for dev
                    } else if (env.GIT_BRANCH ==~ /^origin\/prod/) {
                        env.DOCKER_IMAGE = 'sajaiprathap/prod' // Docker image for prod
                        env.BRANCH = 'prod' // Branch for prod
                    } else {
                        error "Unsupported branch: ${env.GIT_BRANCH}" // Fail if branch is not dev or prod
                    }
                    echo "Building and deploying for branch: ${env.BRANCH}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Run the build.sh script to build and push the Docker images
                    sh 'chmod +x build.sh'  // Ensure the script is executable
                    sh './build.sh'
                }
            }
        }

        // stage('Deploy Docker Image') {
        //     steps {
        //         script {
        //             // Run the deploy.sh script to deploy the Docker image to the EC2 instance
        //             sh 'chmod +x deploy.sh'  // Ensure the script is executable
        //             sh './deploy.sh' ${SSH_KEY_PATH}
        //         }
        //     }
        // }

        stage('Deploy to Deployment server') {
    steps {
        script {
            sshagent(['SSH_KEY_PATH']) {
                // Execute the command within the sshagent block using the 'sh' step
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@18.136.196.121 "
                docker pull sajaiprathap/dev:latest;
                docker ps -q | xargs docker stop;
                docker ps -a -q | xargs docker rm;
                docker run -d -p 80:3000 sajaiprathap/dev:latest "
                '''
            }
        }
    }
}

    }

    post {
        always {
            echo 'Cleaning up...'
        }

        success {
            echo 'Deployment successful!'
        }

        failure {
            echo 'Deployment failed. Please check the logs.'
        }
    }
}
