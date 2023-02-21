# snowhrest

---
Running the Hedera connector for ServiceNow in a Docker container

## What's inside?

The provided Dockerfile build a Docker image based on the Alpine:latest os image. Alpine has been chosen for its lightweight, performances and security level.
Git, Node.js and NPM are installed using the apk package manager.
The Nicola Attico's hrest repository is cloned in the image.
Then "npm update" and "npm install" update the dependencies and install the third party needed modules described in the package.json file. 

When the container is running, the hrest connector listen on the port **3000**.
it runs with an unprivileged user having **9999** for **uid** and **gid**. 

## Deploying the container:

### Creating the hedera user on you docker host system
This user and its group must have the uid (& gid) 9999
*Here's an example on a Ubuntu 22.04 system:*
```
addgroup --gid 9999 hedera
adduser --uid 9999 -ingroup hedera hedera
```

### Cloning the repository
```
git clone git@github.com:mproove-gh/snowhrest.git
```

### Removing the git configuration
```
rm -rf snowhrest/.git
```

### Preparing the local folders that will be mounted into the container
```
mkdir snowhrest/certs
mkdir snowhrest/wallets
mkdir snowhrest/users
```

### Creating the configuration file for the certificate
```
cd snowhrest/certs
vi my.conf
```

*or use nano if you prefer*

The my.conf file must have the following content:  
```
[req]  
distinguished_name=req  
[SAN]  
subjectAltName=IP:<Your server (public) IP address>  
[alternate_names]  
DNS.1=<Your server fqdn>
```  
Replace *\<Your server (public) IP address\>* and *\<Your server fqdn\>* by the real values

### Creating the certificate  
```
openssl genrsa -out mykey 2048
openssl req -new -x509 -key mykey -out mycert -days 3650 -subj /CN=servicenow.com -extensions SAN -config 'my.conf'
```
You should now have 3 files in the *certs* folder: *my.conf*, *mycert* and *mykey*

### Change the ownership of the snowhrest folder and its content
```
chown -R hedera:hedera snowhrest
```

### Creating the files for the secrets (HCLI_PAYER & HCLI_PAYERPRIVKEY)
Create, in the same folder as the docker-compose.yaml file, 2 text files:
- *secret.hcli_payer.txt* => containing only the main hedera account id for the connector
- *secret.hcli_payerprivkey.txt* => containing only the private key of the main hedera account

### Modifying the docker-compose.yaml file
- Map the correct paths to the *certs*, *wallets* and *users* folders in the **volumes** section

### Build the image and run the container
```
docker-compose build
docker-compose up -d
```