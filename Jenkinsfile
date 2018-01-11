// define Logrotation and scm Polling
properties(
    [
        [
            $class: 'BuildDiscarderProperty',
            strategy: [$class: 'LogRotator', numToKeepStr: '10']
        ],
        pipelineTriggers([cron('H/5 * * * *')]),
    ]
)

try{
    node('maven') {
      stage 'build'
        openshiftBuild(buildConfig: 'myphp', showBuildLogs: 'true')
        }
} catch (Exception e) {
    // Notify
    echo "send error mail to jenkins@"
    mail subject: "Build failed with ${e.message}", to: "jenkins@me.cooom", body: "Job failed: ${env.BUILD_URL} \n\n${e.stackTrace}"
    throw e;
}
