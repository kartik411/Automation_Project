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
        sh 'cd test-nodeapp-1-task && sudo docker build . -t public.ecr.aws/s8b3a9g8/node-app:helloworld'
        sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password $(aws ecr-public get-login-password --region us-east-1) public.ecr.aws/s8b3a9g8'
        sh 'sudo docker push public.ecr.aws/s8b3a9g8/node-app:helloworld'
      }  
    }
   
    stage('Deploy to app host') {
      steps {
        sh 'sudo docker stop HelloWorld && sudo docker rm HelloWorld'
        sh 'sudo docker run -itd -p 8080:8080 --name HelloWorld public.ecr.aws/s8b3a9g8/node-app:helloworld'
      }
    }
  }
}
