# snowhrest

---
Running the Hedera connector for ServiceNow in a Docker container

## What's inside?

The provided Dockerfile build a Docker image based on the Alpine:latest os image. Alpine has been chosen for its lightweight, performances and security level.
Git, Node.js and NPM are installed using the apk package manager.
The Nicola Attico's hrest repository is cloned in the image.
Then "npm update" and "npm install" update the dependencies and install the third party needed modules described in the package.json file. 

When the container is running, the hrest connector listen on the port **3000**.

## Deploying the container:

1. Cloning the repository

`git clone git@github.com:cgirdal/snowhrest.git`

2. Preparing the local folders that will be mounted into the container

```
mkdir snowhrest/certs
mkdir snowhrest/wallets
```

3. Creating the configuration file for the certificate

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

4. Creating the certificate  

```
openssl genrsa -out mykey 2048
openssl req -new -x509 -key mykey -out mycert -days 3650 -subj /CN=servicenow.com -extensions SAN -config 'my.conf'
```
You should now have 3 files in the *certs* folder: *my.conf*, *mycert* and *mykey*



