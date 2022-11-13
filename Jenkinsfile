pipeline {
    agent {
        docker {
            image 'cirrusci/flutter:latest'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'flutter pub get'
                sh 'flutter pub run build_runner build --delete-conflicting-outputs'
            }
        }

        stage('Unit tests') {
            steps {
                sh 'flutter test test/widget_test.dart'
            }
        }

        stage('Automatic tests') {
            steps {
                sh 'apt-get update'
                sh 'apt-get install cmake -y'
                sh 'flutter config --enable-linux-desktop'
                sh 'flutter test integration_test/automatic_test.dart -d Linux'
            }
        }
    }
}
