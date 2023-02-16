pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {

        stage('Deploy') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sh ('terraform apply')
                }
            }
        }

       
    }
}

