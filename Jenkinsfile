pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        TF_IN_AUTOMATION  = 'true'
    }

    options {
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Terraform') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Check AWS Authentication') {
            steps {
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -input=false -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input message: 'Review the Terraform plan. Do you approve the changes?',
                          ok: 'Approve'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }

        stage('Terraform Output') {
            steps {
                sh 'terraform output'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check the console output.'
        }

        aborted {
            echo 'Pipeline was aborted.'
        }
    }
}
