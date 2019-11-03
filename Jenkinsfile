pipeline {
    agent any 
   
   stages { 
       
      stage('Clone Repo'){ 
        steps{
       git 'https://github.com/ishrivatsa/terraform-vault-jenkins.git'
        }
      }
      
      stage('Install TF Dependencies') {
      steps{
        sh "sudo apt install wget zip python-pip -y"
        sh "curl -o terraform.zip https://releases.hashicorp.com/terraform/0.12.5/terraform_0.12.5_linux_amd64.zip"
        sh "unzip terraform.zip"
        sh "sudo mv terraform /usr/bin"
        sh "rm -rf terraform.zip"
      }       
    }
      
     stage('Preparation') { 
       
       
      steps {
        sh "sudo apt install wget zip python-pip -y"
        sh "curl -o vault.zip https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip"
        sh "unzip vault.zip"
        sh "sudo mv vault /usr/bin"
        sh "rm -rf vault.zip"


    withCredentials([[$class: 'VaultTokenCredentialBinding', addrVariable: 'VAULT_ADDR', credentialsId: 'github-creds', tokenVariable: 'GITHUB', vaultAddr: 'http://0.0.0.0:8205']]) {
    
        sh '''
        export TF_VAR_vault_token=$(vault login -field=token token=$GITHUB)
        cd terraform_templates/
        terraform init
        terraform apply --auto-approve
        '''
        
       }
     }
           
     }
   }
}
