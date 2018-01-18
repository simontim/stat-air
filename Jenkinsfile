try{
        node {
                stage('Aggiornamenti SCM '){
                        git 'https://github.com/simontim/stat-air.git'
                } 
   
                stage('Test di codice con SonarQube'){
    
                        def x = fileExists 'sonar-project.properties'
        
                        assert x == true //blocca la pipeline se non è stato configurato il file di properties
        
                        //input ''
        
                        def scannerHome = tool 'scanner 3.0';
    
                        println("${scannerHome}")
    
                        withSonarQubeEnv {
                                
                        sh "pwd"
                        sh "ls"
                               
            
                        sh "${scannerHome}/bin/sonar-scanner"
        
                        //build job: 'Quality-Gate', quietPeriod: 1
                                
        
                        }
                }
                
                stage('Controllo Quality Gate'){
                        timeout(time:1,unit:'MINUTES'){
                        //def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                        sh 'curl 172.30.218.175:9000/api/qualitygates/project_status?projectKey=sample%3Awebapp >> quality-gate.json'
                        
                        def qgate = readJSON file: 'qg.json'
                        echo "${qgate.projectStatus.status}"
                        
                                if ( assert qgate.projectStatus.status != 'OK') {
                                        
                                        error "Pipeline aborted due to quality gate failure. ${qgate.projectStatus}"
                                       
                                }
                        }
        
                }
                
                
          
                stage('Build e Deploy'){
                        
                        openshiftBuild(buildConfig: 'webexampl', showBuildLogs: 'true')
                 
                } 
                
                stage('Test con Selenium'){
                          
                        //sh 'java selenium-test'
                          
                } 
                
        }
} catch (Exception e) {
    // Notify
    echo "send error mail to jenkins@"
    mail subject: "Build failed with ${e.message}", to: "jenkins@me.cooom", body: "Job failed: ${env.BUILD_URL} \n\n${e.stackTrace}"
    throw e;
}
