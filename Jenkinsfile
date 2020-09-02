pipeline {
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git(url: 'https://github.com/jimenezcorzo/jenkins-playbox.git', poll: true, credentialsId: 'git-access')
      }
    }

    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }

      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        }

      }
    }

    stage('Deploy App') {
      steps {
        sh "cat webapp.yaml"
        sh "chmod +x updateImageTag.sh"
        sh "./updateImageTag.sh $BUILD_NUMBER"
        sh "cat webapp-final.yaml"
        script {
          kubernetesDeploy(configs: "webapp-final.yaml", kubeconfigId: "kubeconfig")
        }

      }
    }

  }
  environment {
    registry = '10.12.91.186:30500/paco/webapp'
    dockerImage = ''
  }
}
