echo "Defining nomad version"
CHECKPOINT_URL="https://checkpoint-api.hashicorp.com/v1/check"
NOMAD_VERSION=$(curl -s "${CHECKPOINT_URL}"/nomad | jq .current_version | tr -d '"')

echo "Downloading nomad installer"
cd /tmp/
curl -s https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip

echo "Installing nomad version ${NOMAD_VERSION} ..."
unzip nomad.zip
chmod +x nomad
mv nomad /usr/bin/nomad

mkdir /etc/nomad.d
chmod a+w /etc/nomad.d
