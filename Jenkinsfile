try{
        node {
                stage('Cercando Aggiornamenti software'){
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
                                sleep 5
                                sh 'curl sonarqube:9000/api/qualitygates/project_status?projectKey=sample%3Awebapp > qg.json'
                                           
                                def qgate = readJSON file: 'qg.json'
                        
                                echo "${qgate.projectStatus}"
                        
                                assert qgate.projectStatus.status == 'OK'
                                //if ( qgate.projectStatus.status != 'OK') {
                                        
                                        //error "Pipeline aborted due to quality gate failure. ${qgate.projectStatus}"
                                       
                                //}
                        }
        
                }
                
                
          
                stage('Build e Deploy'){
                        //change webexampl with your app name
                        
                        openshiftBuild(buildConfig: 'webexampl', showBuildLogs: 'true')
                 
                } 
                
                stage('Test con Selenium'){
                        
                        timeout(time:2,unit:'MINUTES'){
                                
                                sleep 5
                                
                                //sh 'TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)'
                                
                                //sh 'curl -k -H "Authorization: Bearer $TOKEN" -H "Accept: application/json" https://156.54.176.37:8443/api/v1/namespaces/jenkins/pods/webexampl-21-sobmg > pod.json'
     
                                //def podstatus = readJSON file: 'pod.json'    
                                
                                //openshiftVerifyService apiURL: '', authToken: '', namespace: '', svcName: '', verbose: 'false'
     
                                //echo "${podstatus.status.containerStatuses[0].ready}" //in the deployment config if there is a readiness probe
                                    
                                //while(assert podstatus.status.containerStatuses[0].ready == false) {
                                
                                  //      echo "ciao"
                                        
                                //}
                                
                                //sh 'python test.selenium'
                                echo "a questo punto partono i test con selenium"
                                
                                sh 'curl -X POST http://console-selenium-02.app.ocp.selfdcopen-rh.nuvolaitaliana.it/job/test/build?token=simone'
                        
                        }
                        
                          
                } 
                
        }
} catch (Exception e) {
    // Notify
    echo "send error mail to jenkins@"
    mail subject: "Build failed with ${e.message}", to: "jenkins@me.cooom", body: "Job failed: ${env.BUILD_URL} \n\n${e.stackTrace}"
    throw e;
}
