ARG IMAGE_BASE
FROM ${IMAGE_BASE}

ARG JAVA=17

# https://adoptium.net/installation/linux/
RUN <<EOT
set -eux
export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get install -y wget apt-transport-https gnupg ca-certificates
update-ca-certificates

wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

apt-get update
apt-get install -y "temurin-${JAVA}-jdk"

java -version
javac -version
EOT
