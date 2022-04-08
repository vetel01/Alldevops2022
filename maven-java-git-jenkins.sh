#!/bin/bash

#Author: sebastien 
#Modify: Nov 2021
#Modified: March 2022


if 
   [ ${UID} -ne 0 ] 
then 
 	echo   
 echo                                                  "You need root privilege!!"
 	echo
    exit 911
fi

echo -e "\n
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+           Be aware!!, only members of the Admin team have the necessary security clearance         +
+           to execute this program. If you are not a member of this team, please use                +
+           (CTRL + C) to immediately exit program because the will be consequences.                 +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
sleep 8

echo -e "\nPlease provide your names for clearance level verification\n"

read A
sleep 2

echo -e "\nClearance verification on going please wait, this will only take a minute!!......\n"
sleep 4
	cat /etc/passwd |grep -i --color sebastien >/dev/null 
if 
    [ ${?} -eq 0 ] 
then 
    echo -e "\nYou are cleared, now proceed. type LAUNCH to start program.\n"
    read S
else
echo -e "\nCalling the police sit tight!!!\n" 
    exit 911
fi

sleep 2
echo -e "\n
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 +                                                                                           +
 +    COMPLETE JENKINS, GIT, JAVE, AND MAVEN INSTALLATION AND CONFIGURATION PACKAGE WITH     +
 +    SET OF INSTRUCTIONS ON HOW TO INTEGRATE GIT, JAVA, AND MAVEN. YOU WILL FIND GUIDES     +
 +    AFTER SCRIPT COMPLETION... THANKS!!                                                    +
 +                                                                                           +
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
sleep 6

usage ()

{

if
    [[ ${?} -ne 0 ]]
 then
    echo -e "\ninstallation failed!\n"
else
    echo -e "\nsuccess!!\n"
fi

}

OS_VERSION=`cat /etc/*release |grep VERSION_ID |awk -F\" '{print $2}'`
OS_TYPE=`cat /etc/*release|head -1|awk '{print $1}'`


echo -e "\n Checking if server is connected to the network\n...."

sleep 4

ping google.com -c 4 
echo
usage
    sleep 3
    echo
echo -e "\n Checking OS-version \n"

if 
    [[ ${OS_VERSION} -eq 7 ]] && [[ ${OS_TYPE} == CentOS ]]
 then
    echo -e "\nDetected that you are running CentOS 7 \n"
fi

sleep 6
echo -e "\ninstalling Java 11 and other packages...\n"
    sleep 3
    yum install java-11-openjdk-11.0.14.1.1-1.el7_9.x86_64 wget vim epel-release -y
    sleep 3
echo
usage

echo -e "\nchecking java version, please wait\n"
    echo
    sleep 3
    java -version
    
echo -e"\naInstall & configure Maven build tool on Jenkins\n"
    sleep 3
    echo

 # Creating maven directory under /opt
    mkdir /opt/maven
    cd /opt/maven
 echo -e "\ndownloading maven\n"
    sleep 3
    wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz --no-check-certificate
    tar -xvzf apache-maven-3.8.5-bin.tar.gz
sleep 3
echo
usage

echo -e "\nsetting up maven and java path please wait....\n"
    sleep 3
    
sed -i '9i M2_HOME=/opt/maven/apache-maven-3.8.5' ~/.bash_profile
sed -i '10i M2=$M2_HOME/bin' ~/.bash_profile
sed -i '11i JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.14.1.1-1.el7_9.x86_64' ~/.bash_profile
sed -i 's#PATH=$PATH:$HOME/bin#PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2#g' ~/.bash_profile

    sleep 3
    echo
    source ~/.bash_profile
echo  
usage

echo -e "\nnow donloading jenkins...\n"
    sleep 4
    echo
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    echo "extracting the package..."
    sleep 3
    echo
    sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
    echo
    echo -e \n"installing jenkins...\n"
    echo
    sleep 3
    yum clean all
    yum install wget net-tools git -y
    yum install jenkins -y
echo
usage
echo
    echo "Start jenkins services"
    sleep 3 
    systemctl start jenkins
    systemctl enable jenkins

usage
sleep 3
echo
#echo -e "\n Installing ip tables package...\n"

#sleep 3
#yum install iptables-services -y 

echo -e "\nconfiguring firewall for jenkins server\n"
    sleep 3
    systemctl restart firewalld 
    firewall-cmd --permanent --add-port=8080/tcp
    firewall-cmd --reload
#sed -i '/:OUTPUT ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT' /etc/sysconfig/iptables
#echo 
#echo "Restart iptables services "
#service iptables restart
    sleep 3
echo
usage

echo

echo -e "\nInstalling Git on Jenkins server\n"
    yum install git -y
    sleep 3
echo

usage

echo -e "\nGit and Jenkins intergration steps on browser\n"

    echo -e "\n
    #Setup Git on jenkins console
    #Install git plugin without restart

    #Manage Jenkins > Jenkins Plugins > available > github
    #Configure git path
    #Manage Jenkins > Global Tool Configuration > git\n"
    sleep 3
    echo -e "\ndone!!\n"
    sleep 3

echo -e "\nmaven and java integration with jenkins console\n"
    sleep 3
echo -e "\n
    Install maven plugin without restart
    Manage Jenkins > Jenkins Plugins > available > Maven Invoker
    Manage Jenkins > Jenkins Plugins > available > Maven Integration
    Configure maven path
    Manage Jenkins > Global Tool Configuration > Maven\n"
echo

echo -e "\nHere is the java path = JAVA_HOME\n"

echo -e "\nand here is the maven path = M2_HOME"

echo -e "\nUse this link to access your jenkins server. http://$(ifconfig eth0|head -2|tail -1|awk '{print $2}'):8080\n"

echo "shuss!!"

