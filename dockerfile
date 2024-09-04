FROM node:9

WORKDIR /usr/node

COPY package*.json ./

RUN npm install

COPY . .
EXPOSE 3031
CMD [ "node", "server.js" ]

