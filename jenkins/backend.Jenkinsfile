pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/AlexArsene/Backend-API.git'
      }
    }
    stage('Build Docker Images') {
      steps {
        sh 'docker build -t backend-app:blue ./Backend-API'
        sh 'docker build -t backend-app:green ./Backend-API'
      }
    }
    stage('Deploy to Staging') {
      steps {
        sh 'ssh alex@192.168.0.242 "docker stop backend-blue || true; docker rm backend-blue || true"'
        sh 'ssh alex@192.168.0.242 "docker stop backend-green || true; docker rm backend-green || true"'
        sh 'ssh alex@192.168.0.242 "docker run -d --name backend-blue -p 3001:3000 backend-app:blue"'
        sh 'ssh alex@192.168.0.242 "docker run -d --name backend-green -p 3002:3000 backend-app:green"'
      }
    }
    stage('Test on Staging') {
      steps {
        sh 'ssh alex@192.168.0.242 "bash -s" < ./scripts/test-backend.sh'
      }
    }
    stage('Deploy to Production') {
      steps {
        sh 'ssh alex@192.168.0.79 "docker stop backend-blue || true; docker rm backend-blue || true"'
        sh 'ssh alex@192.168.0.79 "docker stop backend-green || true; docker rm backend-green || true"'
        sh 'ssh alex@192.168.0.79 "docker run -d --name backend-blue -p 3001:3000 backend-app:blue"'
        sh 'ssh alex@192.168.0.79 "docker run -d --name backend-green -p 3002:3000 backend-app:green"'
      }
    }
    stage('Health-check & Switch') {
      steps {
        script {
          def ok = sh(script: 'ssh alex@192.168.0.79 "bash -s" < ./scripts/test-backend.sh', returnStatus: true)
          if (ok == 0) {
            sh 'ssh alex@192.168.0.79 "bash -s" < ./nginx/switch-backend.sh green'
          } else {
            sh 'ssh alex@192.168.0.79 "bash -s" < ./nginx/switch-backend.sh blue'
          }
        }
      }
    }
  }
}

