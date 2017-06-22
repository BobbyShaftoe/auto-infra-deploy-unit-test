node {

    stage ('\u2776 Stage 1'){

        def workspace = pwd()
        echo "\u2600 workspace=${workspace}"
    }





    stage ('\u2778 Test Terraform Binary Exists / Available on PATH'){
        def TFTESTAction = "Test Terraform Binary Exists / Available on PATH"
        echo "\u2600 Action: ${TFTESTAction}"

        dir('.'){
            sh("which terraform || true")
        }

        dir('.'){
            sh("ls -la *")
            sh('pwd')
        }
    }






    stage ('\u2784 Terraform Plan'){
        def TFPAction = "Terraform Plan"
        echo "\u2600 Action: ${TFPAction}"

        dir('aws-three-tier'){

            sh "terraform get"
            sh "terraform plan"

        }
    }






}