pipeline{
    agent any
     
    stages{
        stage("Code checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/vamsikrishna918/Insurance-Web-Applicaion_E2E']])
            }
        }
         stage("Build with Maven"){
            steps{
                echo "****building with maven****"
                sh '''mvn clean package '''
               
            }
        }
        stage("Publish the report")
        {
            steps{
          echo "generating test reports"
          publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/insureme project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        stage("Image prune"){
            steps{
                echo "****deleting the previous images***"
                sh ' docker image prune -af '
               
            }
        }
    
        
        stage("Build Docker image"){
            steps{
                script {
                 echo "****Creating Docker image****"    
                 sh 'docker build -t vamsi12358/insureme .'
                 sh 'docker tag vamsi12358/insureme vamsi12358/insuremeapp:v7'
                }
            }
        }
        stage("Push Docker image to DokckerHub"){
            steps{
                script {
                 echo "****Pushing Docker image to Hub****"   
                
                 withCredentials([string(credentialsId: 'dockercreds', variable: 'dockerhubpwd')]) {
                  sh "docker login -u vamsi12358 -p ${dockerhubpwd} docker.io"       
                  sh 'docker push vamsi12358/insuremeapp:v7'
                 }
               
                }
            }
        }
          stage("Deploying to Testserver"){
            steps{
                script {
                 echo "****Deploying Application to Test server****"    
                 ansiblePlaybook become: true, credentialsId: 'ansiblecreds', disableHostKeyChecking: true, inventory: '/etc/ansible/hosts', playbook: 'ansible-playbook.yml'
                }
            }
        }
        
        
        
        
    }
}
