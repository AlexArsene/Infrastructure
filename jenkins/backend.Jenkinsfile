pipeline {
  agent any
  stages {
    stage('Build') {
      steps { sh 'docker build -t backend-app:v001 .' }
    }
    stage('Test') {
      steps { sh 'docker run --rm -d -p 3000:3000 --name backend-test backend-app:v001 && sleep 10 && curl --fail http://localhost:3000/contacts || exit 1' }
    }
    stage('Deploy Staging') {
      steps { sh 'ssh deploy@192.168.0.242 "docker pull backend-app:v001 && docker stop backend || true && docker rm backend || true && docker run -d --name backend -p 3000:3000 backend-app:v001"' }
    }
    stage('Deploy Production') {
      when { branch 'production' }
      steps { sh 'ssh deploy@192.168.0.79 "docker pull backend-app:v001 && docker stop backend || true && docker rm backend || true && docker run -d --name backend -p 3000:3000 backend-app:v001"' }
    }
  }
}
