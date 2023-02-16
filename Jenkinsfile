pipeline {
    agent any

    stages {

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

       
    }
}

