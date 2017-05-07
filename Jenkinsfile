node {

    stage ('\u2776 Stage 1'){
        echo "\u2600 BUILD_URL=http://34.205.72.129:8080/job/dummy-pipeline"
        def workspace = pwd()
        echo "\u2600 workspace=${workspace}"
    }

    stage ('\u2777 Stage 2 - Checkout Configuration Repo'){
        def MainAction = "cloneRepo"
        echo "\u2600 Action: ${MainAction}"
        git url: 'https://github.com/BobbyShaftoe/auto-infra-deploy-unit-test.git'
    }



    stage ('\u2778 Test Terraform Binary Exists / Available on PATH'){
        def TFTESTAction = "Test Terraform Binary Exists / Available on PATH"
        echo "\u2600 Action: ${TFTESTAction}"

        dir('.'){
            sh("which terraform || true")
        }

        dir('.'){
            sh('ls')
            sh('pwd')
        }
    }



    stage ('\u2779 Read all messages from Pipe'){
        def RAMFPAction = "Read all messages from Pipe"
        echo "\u2600 Action: ${RAMFPAction}"

        dir('scripts'){
//            "BUILD_ID=dontKillMe nohup bash ./reader_script.sh  ${workspace}/comms/jenkins_logger_pipe"
              "sh(ps ax)"
        }
    }



    stage ('\u2780 Terraform Help'){
        def TFHAction = "Terraform Help"
        echo "\u2600 Action: ${TFHAction}"

        dir('.'){
            sh "terraform --help || true"
        }
    }






    stage ('\u2781 Make the Comms directory'){
        def MKCommsAction = "Make the Comms directory"
        echo "\u2600 Action: ${MKCommsAction}"

        def exists = fileExists 'comms'

        if (exists) {
            echo 'comms directory already exists. skipping'
        }
        else {
            dir("."){
                sh ("mkdir comms")
            }
        }

        dir('.'){
            sh returnStdout: true, script: "stat comms || true"
        }
    }


    stage ('\u2782 Make FIFO'){
        def MakeFIFOAction = "Make FIFO"
        echo "\u2600 Action: ${MakeFIFOAction} in ${workspace}/comms"

        dir('comms'){
            sh returnStdout: true, script: "mkfifo -m 666 jenkins_logger_pipe || true"
        }

        dir('comms'){
            sh "chown jenkins:jenkins jenkins_logger_pipe || true"
        }

        dir('comms'){
           def file_status = sh returnStdout: true, script: "stat jenkins_logger_pipe || true"
            println "file status of comms directory is ${file_status}"
        }
    }


    stage ('\u2783 CD into Directories and list contents'){
        def CDDRSAction = "CD into Directories and list contents"
        echo "\u2600 Action: ${CDDRSAction}"

        dir('comms'){
            sh returnStdout: true,
            script: "echo  MARKER  > ${workspace}/comms/jenkins_logger_pipe"
        }
    }



    stage ('\u2784 Terraform Plan'){
        def TFPAction = "Terraform Plan"
        echo "\u2600 Action: ${TFPAction}"

        dir('terraform'){
            sh "exec 3> ${workspace}/comms/jenkins_logger_pipe"
            bash "${workspace}/scripts/command_and_timeout.sh -t 20 -d 5 terraform plan > ${workspace}/comms/jenkins_logger_pipe"
            sh "echo '--- END OF FILE ---' > ${workspace}/comms/jenkins_logger_pipe"
        }
    }






}