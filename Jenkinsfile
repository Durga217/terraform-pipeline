pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Select the Terraform action to execute')
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key') // Replace with your Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key') // Replace with your Jenkins credential ID
    }
    stages {
        stage('Initialize Terraform') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'plan' }
            }
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                script {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}