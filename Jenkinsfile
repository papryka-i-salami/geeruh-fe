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

        // stage('Tests') {
        //     stage('Test') {
        //         steps {
        //             sh './gradlew test' //zmienić na flutterową komendę
        //         }
        //     }
        // }
    }
}
