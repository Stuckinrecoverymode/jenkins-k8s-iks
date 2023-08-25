[![CI workflow](https://github.com/FreeGuys-Corp/jenkins-test/actions/workflows/main.yml/badge.svg)](https://github.com/FreeGuys-Corp/jenkins-test/actions/workflows/main.yml)
# Vue.js App Deployment with GitHub Actions and IBM Kubernetes Service (IKS)

This repository contains a Vue.js web application that will be deployed to IBM Kubernetes Service (IKS) using GitHub Actions for Continuous Integration and Continuous Deployment (CI/CD). The deployment will be triggered automatically whenever code changes are pushed to the main branch or when new branches are created.

## Features

- Vue.js web application with static code analysis set up.
- GitHub Actions workflow for building, testing, and pushing the Docker image to IBM Cloud Container Registry (ICR).
- Automated deployment to IBM Kubernetes Service (IKS) using Kubernetes manifests.
- Jenkins integration for providing the deployment link to developers.

## Prerequisites

- An IBM Cloud account with access to IBM Kubernetes Service.
- A GitHub account with write access to this repository.
- Docker installed locally for building the Docker image.
- Node.js and npm installed for running the Vue.js application locally.
- Jenkins server set up and running for the deployment link.

## Getting Started

1. Clone the repository to your local machine:
```bash
git clone https://github.com/stuckinrecoverymode/jenkins-test.git
cd jenkins-test
```

2. Install dependencies and run the Vue.js app locally:
```bash
npm install
npm run serve
```

3. Make code changes and test your application locally.

## GitHub Actions Workflow

The `.github/workflows/main.yml` file contains the GitHub Actions workflow. It triggers on every push to the main branch and new branches. The workflow performs the following steps:

- Set up Node.js environment.
- Install dependencies and run static code analysis using ESLint.
- Build the Vue.js app for production.
- Build the Docker image with the app.
- Push the Docker image to IBM Cloud Container Registry (ICR).
- Deploy the app to IBM Kubernetes Service (IKS) using Kubernetes manifests.

## Jenkins Integration

The Jenkins server is used to provide the deployment link to developers after successful deployment. Jenkins can be accessed at `http://your-jenkins-server-url`. The Jenkins pipeline is set up to interact with GitHub Actions and trigger the deployment workflow on demand.

## Deployment

The Vue.js application is automatically deployed to IBM Kubernetes Service (IKS) on successful code changes or branch creation. Developers can obtain the deployment link from Jenkins after deployment.

## Contributing

Contributions to this project are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the Apache-2.0 License. See the [LICENSE](LICENSE) file for details.
