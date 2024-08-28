# Java Spring Boot Chassis

The Spring Boot Micro service Chassis is a typical spring boot application with a few additions to enable the service to be built, tested, containerized and deployed on a Kubernetes cluster. The Chassis is available as a Gerrit repository that can be cloned and duplicated to create new microservice. While there may be a need to create multiple chassis templates based on the choice of build tool, application frameworks and dependencies the current implementation is a Java and Spring Boot Maven project.

---
# Community
## Survey
Your feedback is very valuable to us! We have an anonymous user feedback survey - please help us by spending a quick 5 minutes to tell us how satisfied you are with the Java Spring Boot Chassis, and what improvements we should make!

[Survey Link](https://forms.office.com/Pages/ResponsePage.aspx?id=60zokv37q0e-UggMa4eVP_Uyj1uSpKdIn8W4-zy_uCtUNFdVTU9LMjFXS0VRMlI3QjZEU0NYSzdVMS4u)


## Contribution
See [guidelines](CONTRIBUTING.md)

# How to get the chassis
To simply get started, in your local git repository, run the following commands:
```
$ curl -Lo get_chassis.sh http://atvts2361.athtem.eei.ericsson.se/get_chassis/get_chassis.sh
$ chmod 700 get_chassis.sh
$ ./get_chassis.sh
```
For more information on the script please refer documentation of [microservice-chassis-utilities](https://gerrit.ericsson.se/plugins/gitiles/OSS/com.ericsson.oss/microservice-chassis-utilities).

# How to use the chassis
Tutorials on how to use the chassis can be found in [ADP Tutorials](https://adp.ericsson.se/workinginadpframework/tutorials/java-spring-boot-chassis).

## Contact Information
#### PO
Daniel Cunniffe <a href="mailto:daniel.cunniffe@ericsson.com"> daniel.cunniffe@ericsson.com</a>  
#### Team Members  
##### Chassis
Nenad Djukic <a href="nenad.djukic@ericsson.com"> nenad.djukic@ericsson.com</a>  
Jagadesh Lee Veluswamy <a href="jagadesh.lee.veluswamy@ericsson.com"> jagadesh.lee.veluswamy@ericsson.com</a>
##### CI Pipeline  
Shivakumar Ramannavar <a href="shivakumar.ramannavar@ericsson.com">shivakumar.ramannavar@ericsson.com</a>

#### Email
Guardians for this project can be reached at <a href="PDLEAMZEUG@pdl.internal.ericsson.com">PDLEAMZEUG@pdl.internal.ericsson.com</a>  
or through the <a href="https://teams.microsoft.com/l/channel/19%3a9bc0c88ae51e4c77ae35092123673db8%40thread.skype/Developer%2520Experience?groupId=f7576b61-67d8-4483-afea-3f6e754486ed&tenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f">ADP Developer Experience MS Teams Channel</a>

## Maven Dependencies
The chassis has the following Maven dependencies:
  - Spring Boot Start Parent version 2.1.5.
  - Spring Boot Starter Web.
  - Spring Boot Actuator.
  - Spring Cloud Sleuth.
  - Spring Boot Started Test.
  - JaCoCo Code Coverage Plugin.
  - Sonar Maven Plugin.
  - Spotify Dockerfile Maven Plugin.
  - Common Logging utility for logback created by Vortex team. [EO Common Logging]
  - Properties for spring cloud version and java are as follows.
  ```
      <java.version>8</java.version>
      <spring-cloud.version>Greenwich.SR1</spring-cloud.version>
  ```

## Build related artifacts
The main build tool is BOB provided by ADP. For convenience, maven wrapper is provided to allow the developer to build in an isolated workstation that does not have access to ADP.
  - [ruleset2.0.yaml](ruleset2.0.yaml) - for more details on BOB please click here [BOB].
  - [precoderview.Jenkinsfile](precodereview.Jenkinsfile) - For pre code review Jenkins pipeline that runs when patch set is pushed.
  - [publish.Jenkinsfile](publish.Jenkinsfile) - For publish Jenkins pipeline that runs after patch set is merged to master.

If the developer wishes to manually build the application in the local workstation, the command ``` bob release ``` can be used once BOB is configured in the workstation.

## Containerization and Deployment to Kubernetes cluster.
Following artifacts contains information related to building a container and enabling deployment to a Kubernetes cluster:
- [charts](charts/) folder - used by BOB to lint, package and upload helm chart to helm repository.
  -  Once the project is built in the local workstation using the ```bob release``` command, a packaged helm chart is available in the folder ```.bob/microservice-chassis-internal/``` folder. This chart can be manually installed in Kubernetes using ```helm install``` command. [P.S. required only for Manual deployment from local workstation]
- [Dockerfile](Dockerfile) - used by Spotify dockerfile maven plugin to build docker image.
  - The base image for the chassis application is ```sles-jdk8``` available in ```armdocker.rnd.ericsson.se```.

## Source
The [src](src/) folder of the java project contains a core spring boot application, a controller for health check and an interceptor for helping with logging details like user name. The folder also contains corresponding java unit tests.

```
├── main
│ ├── java
│ │ ├── com
│ │ │ └── ericsson
│ │ │     └── de
│ │ │         └── microservice
│ │ │             └── chassis
│ │ │                 ├── controller
│ │ │                 │ ├── HealthCheck.java
│ │ │                 │ └── package-info.java
│ │ │                 ├── CoreApplication.java
│ │ │                 ├── log
│ │ │                 │ ├── MDCLogEnhanceFilter.java
│ │ │                 │ └── package-info.java
│ │ │                 └── package-info.java
│ │ └── META-INF
│ │     └── MANIFEST.MF
│ └── resources
│     ├── application.yaml
│     └── log4j2.yml
└── test
    └── java
        └── com
            └── ericsson
                └── de
                    └── microservice
                        └── chassis
                            ├── controller
                            │ └── HealthCheckTest.java
                            ├── CoreApplicationTest.java
                            ├── log
                            │ └── MDCLogEnhanceFilterTest.java
                            └── package-info.java

```


## Setting up CI Pipeline
-  Docker Registry is used to store and pull Docker images. At Ericsson official chart repository is maintained at the org-level JFrog Artifactory. Follow the link to set up a [Docker registry].
-  Helm repo is a location where packaged charts can be stored and shared. The official chart repository is maintained at the org-level JFrog Artifactory. Follow the link to set up a [Helm Repo].
-  Follow instructions at [Jenkins Pipeline setup] to use out-of-box Jenkinsfiles which comes along with microservice-chassis.
-  Jenkins Setup involves master and slave machines. If there is not any Jenkins master setup, follow instructions at [Jenkins Master] - 2.89.2 (FEM Jenkins).
-  To setup [Jenkins slave] to for Jenkins, jobs execution follow the instructions at Jenkins Slave Setup.
-  Follow instructions at [Customize BOB] Ruleset Based on Your Project Settings to update ruleset files to suit to your project needs.

   [SLF4J]: <https://logging.apache.org/log4j/2.x/log4j-slf4j-impl/index.html>
   [Gerrit Repos]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/PCNCG/Design+and+Development+Environment>
   [BOB]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/PCNCG/Adopting+BOB+Into+the+MVP+Project>
   [Docker registry]: <https://confluence.lmera.ericsson.se/pages/viewpage.action?spaceKey=ACD&title=How+to+create+new+docker+repository+in+ARM+artifactory>
   [Helm repo]: <https://confluence.lmera.ericsson.se/display/ACD/How+to+setup+Helm+repositories+for+ADP+e2e+CICD>
   [Jenkins Master]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/PCNCG/Microservice+Chassis+CI+Pipeline+Start+Guide#MicroserviceChassisCIPipelineStartGuide-JenkinsMaster-2.89.2(FEMJenkins)>
   [Jenkins slave]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/PCNCG/Microservice+Chassis+CI+Pipeline+Start+Guide#MicroserviceChassisCIPipelineStartGuide-JenkinsSlaveSetup>
   [Customize BOB]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/PCNCG/Microservice+Chassis+CI+Pipeline+Start+Guide#MicroserviceChassisCIPipelineStartGuide-CustomizeBOBRulesetBasedonYourProjectSettings>
   [Jenkins Pipeline setup]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/PCNCG/Microservice+Chassis+CI+Pipeline+Start+Guide#MicroserviceChassisCIPipelineStartGuide-JenkinsPipelinesetup>
   [EO Common Logging]: <https://confluence-oss.seli.wh.rnd.internal.ericsson.com/display/ESO/EO+Common+Logging+Library>
