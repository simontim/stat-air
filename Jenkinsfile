try{
        node('nodo1'){
        stage('build'){
        //openshiftBuild(buildConfig: 'myphp', showBuildLogs: 'true'  
        git 'https://github.com/simontim/stat-air.git'
        } 
        
        stage('Test di codice con SonarQube'){
    
        def x = fileExists 'sonar-project.properties'
        
        assert x == true //blocca la pipeline se non è stato configurato il file di properties
        
        //input ''
        
        def scannerHome = tool 'scanner';
    
        println("${scannerHome}")
    
        withSonarQubeEnv {
            
            sh "ls"
            
            sh "${scannerHome}/bin/sonar-scanner"
        
            //build job: 'Quality-Gate', quietPeriod: 1
        
         }
        }
      }
} catch (Exception e) {
    // Notify
    echo "send error mail to jenkins@"
    mail subject: "Build failed with ${e.message}", to: "jenkins@me.cooom", body: "Job failed: ${env.BUILD_URL} \n\n${e.stackTrace}"
    throw e;
}
