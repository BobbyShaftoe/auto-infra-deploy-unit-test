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

    stage ('\u2779 LS'){
        def LSAction = "List files and directories"
        echo "\u2600 Action: ${LSAction}"
        sh ("ls -l")
    }


    stage ('\u2780 CD into Terraform Dir and LS'){
        def CDTFAction = "CD into Terraform Dir and LS"
        echo "\u2600 Action: ${CDTFAction}"
        dir('terraform/consul-deployment'){
            sh "ls -l > $(pwd)/jenkins_logger_pipe"

            }
    }


    stage ('\u2781 Terraform Help'){
        def TFHAction = "Terraform Help"
        echo "\u2600 Action: ${TFHAction}"
        dir('.'){sh "terraform --help || true"}
    }


        stage ('\u2781 Make FIFO'){
        def MakeFIFOAction = "Terraform Help"
        echo "\u2600 Action: ${MakeFIFOAction}"
        dir(''){
        sh "\{ mkfifo -m 666 $(pwd)/workspace/test_pipe && chown centos:centos $(pwd)/workspace/test_pipe; \} || true"
        }
    }


}