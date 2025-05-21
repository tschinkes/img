#!/bin/bash
clear
# ---------------------------------- Update ---------------------------------- #
echo "Update System"
sleep 1
apt-get update && apt-get upgrade -y
sleep 1
apt-get autoclean -y
sleep 1
clear
# ---------------------- Benötigte Dateien installieren ---------------------- #
apt-get install ca-certificates curl gnupg lsb-release -y
sleep 1
clear
# ------------------------------------ Key ----------------------------------- #
echo "Key wird geholt...."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 1
clear
# --------------------------- Sourcelist hinzufügen -------------------------- #
echo "Sourcelist wird hinzugefügt..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 1
echo "... und updaten"
apt-get update
sleep 1
clear
# ---------------------------- Docket installieren --------------------------- #
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sleep 1
clear
# ----------------------------- Docker ausführen ----------------------------- #
docker run -d -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo "Portainer läuft unter Port 9443"