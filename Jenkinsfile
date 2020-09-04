pipeline {
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        slackSend baseUrl: 'https://hooks.slack.com/services/', channel: 'devsecops-mx-pipeline-demo', color: 'good', message: 'Iniciando ejecucion de pipeline para WebApp...', teamDomain: 'devsecops-ibm', tokenCredentialId: 'Slack-pipeline', username: 'Pipeline Bot'
        git(url: 'https://github.com/jimenezcorzo/jenkins-playbox.git', poll: true, credentialsId: 'git-access')
        slackSend baseUrl: 'https://hooks.slack.com/services/', channel: 'devsecops-mx-pipeline-demo', color: 'good', message: 'Termino Check Source Stage', teamDomain: 'devsecops-ibm', tokenCredentialId: 'Slack-pipeline', username: 'Pipeline Bot'  
      }
    }

    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          slackSend baseUrl: 'https://hooks.slack.com/services/', channel: 'devsecops-mx-pipeline-demo', color: 'good', message: 'Termino Build Image Stage', teamDomain: 'devsecops-ibm', tokenCredentialId: 'Slack-pipeline', username: 'Pipeline Bot'  
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        slackSend baseUrl: 'https://hooks.slack.com/services/', channel: 'devsecops-mx-pipeline-demo', color: 'good', message: 'Termino Push Image Stage', teamDomain: 'devsecops-ibm', tokenCredentialId: 'Slack-pipeline', username: 'Pipeline Bot'  
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
      slackSend baseUrl: 'https://hooks.slack.com/services/', channel: 'devsecops-mx-pipeline-demo', color: 'good', message: 'Termino el pipeline, habemus nueva version de WebApp...', teamDomain: 'devsecops-ibm', tokenCredentialId: 'Slack-pipeline', username: 'Pipeline Bot'
      }
    }

  }
  environment {
    registry = '10.12.91.186:30500/paco/webapp'
    dockerImage = ''
  }
}
