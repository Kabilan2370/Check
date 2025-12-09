## Build and Develop the Strapi docker image using dockerfile and launched as docker container

![Alt Text](./docker-strapi.png)

[loome link](https://www.loom.com/share/f88349ceb9084231b8413fadf4d6e7ba)

### ⚙️ Server Requirements
To run and develop a Strapi application smoothly, you need **at least 2 vCPUs and 8 GB RAM**.  
Otherwise, the server will lag heavily during the build process. So I used t3.large instance type.

---
### 🟢 Step 1: Created a Strapi project locally on my machine using the Strapi CLI.

### 🟢 Step 2: Wrote a Dockerfile to containerize the Strapi application.

### 🟢 Step 3: First install the nodejs on your machine and install the neccessary files.
Using the node install the "npm install -g yarn" because using this yarn we are going to build and develop the strapi.

### 🟢 Step 4: Built a Docker image from the Dockerfile using docker build.
sudo docker build --no-cache -t strapi-docker .

### 🟢 Step 5 : Launched the Strapi application by running the Docker container with port forwarding using -p 1337:1337.
sudo docker run -d --name strapi -p 1337:1337 strapi-docker

### 🟢 Step 6: Accessed the Strapi Admin Panel through after the container started successfully.
<instance-ip>:1337
