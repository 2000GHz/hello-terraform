pipeline {
    agent any

    stages {

        stage('Deploy') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sh ('terraform plan')
                    sh ('terraform apply -auto-approve')
                }
            }
        }

       
    }
}

