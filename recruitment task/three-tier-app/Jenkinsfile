pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    parameters{
        choice(name: 'ENVIRONMENT', choices: ['create', 'destroy'], description: 'create and destroy cluster with one click')
    }

    stages {
        stage("Create a s3 Bucket") {
            when {
                expression { params.ENVIRONMENT == 'create' }
            }
            steps {
                script {
                    dir('Backend') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }

        stage("Create an EKS Cluster") {
            when {
                expression { params.ENVIRONMENT == 'create' }
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve -var-file=variables.tfvars"
                    }
                }
            }
        }

        stage("Destroy a s3 Bucket") {
            when {
                expression { params.ENVIRONMENT == 'destroy' }
            }
            steps {
                script {
                    dir('Backend') {
                        sh "terraform init"
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }

        stage("destroy infrastructure") {
            when {
                expression { params.ENVIRONMENT == 'destroy' }
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform destroy -auto-approve -var-file=variables.tfvars"
                    }
                }
            }
        }
    }
}