pipeline {
    agent {
        docker {
            image 'cirrusci/flutter:latest'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh './gradlew build' //zmienić
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
