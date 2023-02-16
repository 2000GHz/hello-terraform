pipeline {
    agent any

    stages {

        stage('Cleanup') {
            steps {
                echo 'Cleaning system...'
                sh 'docker system prune -a --volumes --force'
            }
        }

        stage('Build') {
            steps {
                echo 'Building image...'
                sh '''docker-compose build
                      git tag 1.0.${BUILD_NUMBER}
                      docker tag -t ghcr.io/2000ghz/hello-terraform/hello-terraform:latest -t ghcr.io/2000ghz/hello-terraform/hello-terraform:1.0.${BUILD_NUMBER}
                      '''
                      sshagent(['github-credentials']) {
                        sh('git push git@github.com:2000ghz/hello-terraform.git --tags')
                      }
            }
        }

        stage('Login') {
            steps{
                echo 'Logging into GitHub'
                withCredentials([string(credentialsId: 'Token-GitHub', variable: 'GITHUB_TOKEN')]) {
                    sh 'echo $GITHUB_TOKEN | docker login ghcr.io -u 2000ghz --password-stdin'
                    sh 'docker push ghcr.io/2000ghz/hello-terraform/hello-terraform:1.0.${BUILD_NUMBER}'
                }
            }
        }
        
        stage('Start Terraform') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sh ('terraform init')
                }
            }
        }

        stage('Validation') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sh ('terraform validate')
                }
            }
        }

        stage('Planning and deploying') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                        sh ('''
                    terraform plan
                    terraform apply -auto-approve -no-color''')
                    }
                }
            }

        stage('Ansible') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sshagent(['ssh-amazon']) {
                        sh('ansible-playbook -i aws_ec2.yml launch2048.yml')
                }
                }
            }
        }
    }
}
