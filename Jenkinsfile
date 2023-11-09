pipeline {
    agent any

    environment {
        KUBECONFIG = credentials('your-kubeconfig-credentials-id')
        GITHUB_USERNAME = ''
        APP_NAMESPACE = 'your-namespace'
        APP_NAME = 'your-app-name'
        DOCKER_REGISTRY = 'your-docker-registry'
    }

    stages {
        stage('Replace GitHub username in deployment.yaml') {
            steps {
                script {
                    // Determine the GitHub username of the person who pushed the code
                    GITHUB_USERNAME = sh(script: "git log -1 --format='%an'", returnStdout: true).trim()
                    currentBuild.buildEnvVars['GITHUB_USERNAME'] = GITHUB_USERNAME
                    // Replace the '$GITHUB_USERNAME' variable in the deployment YAML file
                    sh("sed -i 's/\$GITHUB_USERNAME/${GITHUB_USERNAME}/' deployment.yaml")
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                // Assuming you have Docker configured and Dockerfile in your project
                script {
                    docker.withRegistry('your-docker-registry-credentials-id') {
                        def image = docker.build("${DOCKER_REGISTRY}/${APP_NAME}:${env.BUILD_NUMBER}")
                        image.push()
                    }
                }
            }
        }

        stage('Deploy to IBM Kubernetes Service') {
            steps {
                script {
                    // Assuming you have kubectl configured with IBM Kubernetes Service
                    withCredentials([kubeconfigFile(credentialsId: 'your-kubeconfig-credentials-id', variable: 'KUBECONFIG')]) {
                        sh 'kubectl apply -f deployment.yaml -n ${APP_NAMESPACE}'
                    }
                }
            }
        }

        stage('Update Ingress for GitHub username and Branch Name') {
            steps {
                script {
                    def branchName = env.BRANCH_NAME
                    // Replace the GitHub username and branch name in the ingress.yaml file
                    sh "sed -i 's/\$GITHUB_USERNAME/${GITHUB_USERNAME}/g' ingress.yaml"
                    sh "sed -i 's/\${BRANCH_NAME}/${branchName}/g' ingress.yaml"
                    // Assuming you have kubectl configured with IBM Kubernetes Service
                    withCredentials([kubeconfigFile(credentialsId: 'your-kubeconfig-credentials-id', variable: 'KUBECONFIG')]) {
                        sh 'kubectl apply -f ingress.yaml -n ${APP_NAMESPACE}'
                    }
                }
            }
        }

        stage('Scale Deployment (Optional)') {
            steps {
                script {
                    // Adjust replicas as needed
                    withCredentials([kubeconfigFile(credentialsId: 'your-kubeconfig-credentials-id', variable: 'KUBECONFIG')]) {
                        sh 'kubectl scale deployment ${APP_NAME} --replicas=3 -n ${APP_NAMESPACE}'
                    }
                }
            }
        }
    }
}
