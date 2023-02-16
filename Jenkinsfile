pipeline {
    agent any

    stages {

        stage('Deploy') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sh ('terraform apply -auto-approve')
                }
            }
        }

       
    }
}

