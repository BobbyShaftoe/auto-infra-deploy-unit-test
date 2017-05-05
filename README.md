# SPEC FOR UNIT AND INTEGRATION TESTING INFRASTRUCTURE FRAMEWORK
### Currently, this is a simple idea and POC

### DESCRIPTION

A small collection of utilities that will compose a simple framework for performing tests on infrastructure components as they are created, modified or destroyed throughout any automated process or CI/CD pipeline.

##### The key concept is that each test will attempt 
*<h3>Reporting</h3> (to test that a resource does/does not exist)*</br>
    Reporting is through direct communication with the platform API</br>
    Python Boto or AWSCLI are options

*<h3>Reachability</h3> (to test that a resource is reachable, via Networking Layers 3,4,5 or 7*</br>
    eg. Ping, Traceroute, Dig, Nmap, Telnet, HTTP, SSH, SNMP </br>
    Using python-libnmap or python-nmap



##### The idea for this framework may or may not be composed of 
a listener such as a message queue like Kafka, a named pipe, and/or just a simple script  to consume output of a Terraform action either by stream redirection or simply tailing a logfile
The Python libs mentioned above to consume output from a terraform command through message queue or similar, make connections, handle data, parse results perform tests, write out formats (Junit/XML and Json)
A small in-memory DB may be required such as Redis

*Essentially most of the work will be handled by Python scripts*




- Run terraform from script using sh in Jenkinsfile
  - Also redirect output of that script to:
    - named pipe
    - message queue
- Blocking or non-blocking
- requirement to unit test each resource before continuing
  - Blocking
      - Named pipe
  - requirement is to unit test from a queue asynchronously	
      - tests might finish earlier or later
- Catalogue each test with common variables/keys
  - AWS
    - Account ID, VPC, Region, AZ, Subnet
    - What it’s attached to:
      - EC2 Instance attached to ELB in subnet, in VPC, with SG
  - Common
    - Timestamp
    - Environment (from Terraform configuration) eg. Prod, Test
    - Application from (Terraform configuration) eg. “Batch Process”
    - Project (from Terraform configuration) eg. sc_terra_test



Script
  |
  | - Python script/application
        | - terraform lib
        | - libnmap

