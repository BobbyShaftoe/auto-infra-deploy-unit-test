node {

    stage ('\u2776 Stage 1'){

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
            sh("ls -la */*")
            sh('pwd')
        }
    }






    stage ('\u2784 Terraform Plan'){
        def TFPAction = "Terraform Plan"
        echo "\u2600 Action: ${TFPAction}"

        dir('terraform/aws-three-tier'){
            sh "ls -la"
            sh "terraform get"
            sh "terraform plan"

        }
    }






}