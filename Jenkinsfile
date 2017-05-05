node {

    stage ('\u2776 Stage 1'){
        echo "\u2600 BUILD_URL=http://34.205.72.129:8080/job/dummy-pipeline"
        def workspace = pwd()
        echo "\u2600 workspace=${workspace}"
    }

    stage ('\u2777 Stage 2'){
        def MainAction = "terraformDeploy"
        echo "\u2600 Action: ${MainAction}"
    }

    stage ('\u2778 Test Terraform Binary'){
        def TFTESTAction = "Test Terraform Binary"
        echo "\u2600 Action: ${TFTESTAction}"

        dir('.'){
            sh('terraform --help -detailed-exitcode; echo \$? > status"')
        }

        dir('.'){
            sh('ls')
            sh('pwd')
        }

        def exitCode = readFile('status').trim()
        def apply = false
        echo "Terraform Plan Exit Code: ${exitCode}"
        if (exitCode == 1) {
            currentBuild.result = 'SUCCESS'
        }
    }

    stage ('\u2779 LS'){
        def LSAction = "List files and directories"
        echo "\u2600 Action: ${LSAction}"
        sh "ls -l */*"
    }

    stage ('\u2780 CD into Terraform Dir and LS'){
        def CDTFAction = "CD into Terraform Dir and LS"
        echo "\u2600 Action: ${CDTFAction}"
        dir('terraform/consul-deployment'){sh "ls -l"}
    }

    stage ('\u2781 Terraform Plan'){
        def TFPlanAction = "Terraform Plan"
        echo "\u2600 Action: ${TFPlanAction}"
        dir('terraform/consul-deployment'){sh "terraform plan"}
    }
}