pipeline {
    agent any

    stages {

        stage('Deploy') {
            steps {
                withAWS(credentials: 'AWS Credentials') {
                    sh ('''terraform init
                    terraform fmt
                    terraform validate
                    terraform plan
                    terraform apply -auto-approve -no-color''')
                }
            }
        }

       
    }
}

