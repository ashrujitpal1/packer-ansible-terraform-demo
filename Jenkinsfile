pipeline {
    agent any
    parameters {
        string(name: 'project_name', defaultValue: 'Packer Pipeline', description: 'Jenkins Pipeline for terraform?')
    }
    environment {
        terraform_version = '1.2.7'
        packer_version = '1.8.2'
        access_key = ''
        secret_key = ''
    }
    stages {
          stage('Install Terraform') {
              steps {
                    sh "sudo yum install wget zip -y"
                    sh "sudo cd /tmp"
                    sh "sudo curl -o bin_terraform.zip https://releases.hashicorp.com/terraform/'$terraform_version'/terraform_'$terraform_version'_linux_amd64.zip"
                    sh "sudo rm -rf terraform/"
                    sh "sudo ls -l; pwd;sudo unzip -o bin_terraform.zip"
                    sh "sudo mv terraform /usr/bin"
                    sh "sudo rm -rf bin_terraform.zip"
                    sh "sudo terraform version"
              }
          }
          stage('Install Packer') {
              steps {
                    sh "sudo yum install wget zip -y"
                    sh "cd /tmp"
                    sh "curl -o bin_packer.zip https://releases.hashicorp.com/packer/$packer_version/packer_'$packer_version'_linux_amd64.zip"
                    sh "sudo rm -rf packer/"
                    sh "sudo unzip bin_packer.zip"
                    sh "sudo mv packer /usr/bin"
                    sh "rm -rf bin_packer.zip"
                    sh "packer version"
              }
          }
            stage('code checkout') {
               steps {
                    git branch: 'main', url: 'https://github.com/ashrujitpal1/packer-ansible-terraform-demo.git'
                    }
          }
          stage('Build AMI') {
                steps {
                    withAWS(credentials: 'Ashrujit-DevOps', region: 'us-east-1') {
                        dir('./packer'){
                        sh 'ls -la; pwd; packer init; packer build template.json'
                    }
                }
            }
          }
          /*stage('Deploy??') {
                steps {
                    script {
                       withAWS(credentials: 'Ashrujit-DevOps', region: 'us-east-1') { 
                       timeout(time: 2, unit: 'MINUTES') {
                          input(id: "Deploy Gate", message: "Want to Deploy ${params.project_name}?", ok: 'Deploy??')
                       }
                       }
                    }
                }
          }*/
         stage('Terraform Deploy'){
             steps {
                withAWS(credentials: 'Ashrujit-DevOps', region: 'us-east-1') {
                 dir('./terraform'){

                 sh  """
                     terraform init; terraform plan; terraform apply -auto-approve
                     """

                 }
                }
             }
         }
    }
}
