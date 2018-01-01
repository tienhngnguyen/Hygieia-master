node('maven') {
  stage('Build') {
    git url: "https://github.com/tienhngnguyen/Hygieia-master.git"
    sh "mvn clean install"
    stash name:"jar", includes:"target/*.jar"
  }
  stage('Test') {
    parallel(
      "default Tests": {
        sh "mvn verify -P defaultBuild"
      },
      "release Tests": {
        sh "mvn verify -P release"
      }
    )
  }
  stage('Build Image') {
    unstash name:"jar"
    sh "oc start-build hygieia-api --from-file=target/api.jar --follow"
  }
  stage('Deploy') {
    openshiftDeploy depCfg: 'hygieia-api'
    openshiftVerifyDeployment depCfg: 'hygieia-api', replicaCount: 1, verifyReplicaCount: true
  }
  stage('System Test') {
    sh "echo SUCCESSFUL!"

  }
}