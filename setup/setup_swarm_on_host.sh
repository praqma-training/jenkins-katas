export J_URL=127.0.0.1:8080
export J_USR=admin
export J_PSW=adminpassword
export J_LABELS=swarm
export J_SWARM_VERSION=3.24
export J_WORKDIR="/home/ubuntu/jenkins/agent"
export TZ="Europe/Copenhagen"
export DEBIAN_FRONTEND=noninteractive
sudo apt update && sudo apt install -y openjdk-11-jdk  apt-transport-https ca-certificates curl software-properties-common wget
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
#apt install -y docker-ce
mkdir -p "${J_WORKDIR}/remoting"
cd ${J_WORKDIR}
wget https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${J_SWARM_VERSION}/swarm-client-${J_SWARM_VERSION}.jar
nohup java -jar swarm-client-${J_SWARM_VERSION}.jar -master http://${J_URL} -username ${J_USR} -password ${J_PSW} -labels "${J_LABELS}" -executors 2 -failIfWorkDirIsMissing -workDir ${J_WORKDIR} &