pipeline {
  agent {
    label 'app-instance'
  }
  
  stages {
    stage('git Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'sudo docker build . -t 647560355561.dkr.ecr.us-east-1.amazonaws.com/node-app:latest'
        sh 'aws ecr get-login-password --region us-east-1'
        sh 'docker login --username AWS --password $(aws ecr get-login-password --region us-east-1) 647560355561.dkr.ecr.us-east-1.amazonaws.com'
        withDockerRegistry(credentialsId: 'ecr:us-east-1:nodeApp', url: '647560355561.dkr.ecr.us-east-1.amazonaws.com/node-app') {
          sh 'sudo docker push 647560355561.dkr.ecr.us-east-1.amazonaws.com/node-app:latest'
        }
      }  
    }
   
    stage('Deploy to app host') {
      steps {
        sh 'sudo docker run -itd -p 8080:8080 647560355561.dkr.ecr.us-east-1.amazonaws.com/node-app:latest'
      }
    }
  }
}
