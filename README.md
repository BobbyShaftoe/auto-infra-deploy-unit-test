# Spec For Infrastructure Testing Framework
### Attempting to Simulate/Approximate some typical Software Unit and Integration Test Process
    Currently, this is a simple idea and POC
    
    The original and first idea was that a message broker such as a message queue tool like Kafka, or a named pipe, 
    or a script to consume output of a Terraform action run by Jenkins, either by stream redirection or simply tailing a logfile
    could provide serviceable input to something like a suite of Python scripts
    ...and tests can be run on consuming the messages or log stream or what-have-you
    
    The Python libs mentioned above to consume output from a terraform command through message queue or similar, 
    make connections, handle data, parse results perform tests, write out formats (Junit/XML and Json)
    
    A small in-memory DB may be required such as Redis

#### DESCRIPTION

A small collection of utilities that will compose a simple framework for performing tests on infrastructure components as they are created, 
modified or destroyed throughout any automated process or CI/CD pipeline.

#### The key concept is that each test will attempt to satisfy either of the two following type conditions:
*<h4>Reportability</h4> (to test that a resource does/does not exist)*<br>
    Reporting is likely to simply be through direct communication with the platform API</br>
    Python Boto or AWSCLI are options

*<h4>Reachability</h4> (to test that a resource is reachable, via Networking Layers 3,4,5 or 7)*<br>
    eg. Ping, Traceroute, Dig, Nmap, Telnet, HTTP, SSH, SNMP </br>
    Using python-libnmap or python-nmap


*<b>Essentially most of the work will be handled by Python scripts</b>*
*<b>The software technology implemented in the final idea for this framework may or may not be composed of something as follows</b>* </br> 




### Process Flow - This is a more detailed and better defined description of the preferred method now being followed @06052017
/@ **Jenkins job starts** @/<br><br>
&nbsp;&nbsp; &nbsp;&nbsp;     /+ **Terraform Stage** +/ 
  - Terraform action is performed plan/apply
  - Jenkins logs are piped/stream-redirected/logfile tailed to Kafka broker as messages
    - some file descriptor redirection or creation of named pipe(s) may be required
  - A Python script is also run that consumes messages in the Kafka queue
    - Python script creates a catalogue from message information 
    and executes tests on resource components based on what it is receiving
    and also writes test results out to json/junit/log and/or sends messages back into Kafka 
    to be consumed at the other end by Jenkins
    
##### DETAILS ON SPECIFIC ACTIONS AND CONFIGURATION
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



### REFERENCE

##### Currently implementing this Kafka Connector to  tryout
* Kafka Connect Jenkins<br>
  https://github.com/yaravind/kafka-connect-jenkins
  <br><br>
* Other Kafka links<br>
  http://kafka.apache.org/0100/documentation.html#connect<br>
<br>
* Python Nmap libs<br>
  https://pypi.python.org/pypi/python-nmap<br>
  https://pypi.python.org/pypi/python-libnmap/0.6.1
  https://nmap.org/book/output-formats-xml-output.html<br>
<br>
* Python Log tailing scripts/libs<br>
  http://code.activestate.com/recipes/436477-filetailpy/<br>
  https://pypi.python.org/pypi/py-amqp-logging/<br>
 
 

