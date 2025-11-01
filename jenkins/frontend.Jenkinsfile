pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/AlexArsene/Frontend-UI.git'
      }
    }
    stage('Build Docker Images') {
      steps {
        sh 'docker build -t frontend-app:blue ./Frontend-UI'
        sh 'docker build -t frontend-app:green ./Frontend-UI'
      }
    }
    stage('Deploy to Staging') {
      steps {
        sh 'ssh alex@192.168.0.242 "docker stop frontend-blue || true; docker rm frontend-blue || true"'
        sh 'ssh alex@192.168.0.242 "docker stop frontend-green || true; docker rm frontend-green || true"'
        sh 'ssh alex@192.168.0.242 "docker run -d --name frontend-blue -p 4001:4000 frontend-app:blue"'
        sh 'ssh alex@192.168.0.242 "docker run -d --name frontend-green -p 4002:4000 frontend-app:green"'
      }
    }
    stage('Test on Staging') {
      steps {
        sh 'ssh alex@192.168.0.242 "bash -s" < ./scripts/test-frontend.sh'
      }
    }
    stage('Deploy to Production') {
      steps {
        sh 'ssh alex@192.168.0.79 "docker stop frontend-blue || true; docker rm frontend-blue || true"'
        sh 'ssh alex@192.168.0.79 "docker stop frontend-green || true; docker rm frontend-green || true"'
        sh 'ssh alex@192.168.0.79 "docker run -d --name frontend-blue -p 4001:4000 frontend-app:blue"'
        sh 'ssh alex@192.168.0.79 "docker run -d --name frontend-green -p 4002:4000 frontend-app:green"'
      }
    }
    stage('Health-check & Switch') {
      steps {
        script {
          def ok = sh(script: 'ssh alex@192.168.0.79 "bash -s" < ./scripts/test-frontend.sh', returnStatus: true)
          if (ok == 0) {
            sh 'ssh alex@192.168.0.79 "bash -s" < ./nginx/switch-frontend.sh green'
          } else {
            sh 'ssh alex@192.168.0.79 "bash -s" < ./nginx/switch-frontend.sh blue'
          }
        }
      }
    }
  }
}

