pipeline {
  agent any
  stages {
    stage('Check Registry') {
      steps {
        git 'https://github.com/jimenezcorzo/jenkins-playbox.git'
      }
    }

    stage('Build Image') {
      steps {
        sh 'dockerImage = docker.build registry + ":$BUILD_NUMBER"'
      }
    }

    stage('Push Image') {
      steps {
        sh '''docker.withRegistry( "" ) {
            dockerImage.push()
}'''
        }
      }

      stage('Deploy App') {
        steps {
          sh 'kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "kubeconfig")'
        }
      }

    }
  }