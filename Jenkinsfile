try{
    node('maven') {
        stage('build'){
        //openshiftBuild(buildConfig: 'myphp', showBuildLogs: 'true'  
        git 'https://github.com/simontim/Sample-for-nexus.git'
        } 
    }
} catch (Exception e) {
    // Notify
    echo "send error mail to jenkins@"
    mail subject: "Build failed with ${e.message}", to: "jenkins@me.cooom", body: "Job failed: ${env.BUILD_URL} \n\n${e.stackTrace}"
    throw e;
}
