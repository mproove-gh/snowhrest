# snowhrest
Running the Hedera connector for ServiceNow in a Docker container

What's inside?

The provided Dockerfile build a Docker image based on the Alpine:latest os image. Alpine has been chosen for its lightweight, performances and security level.
Git, Node.js and NPM are installed using the apk package manager.
The Nicola Attico's hrest repository is cloned in the image.
Then "npm update" and "npm install" update the dependencies and install the third party needed modules described in the package.json file. 

When the container is running, the hrest connector listen on the port 3000.

Deploying the container:
