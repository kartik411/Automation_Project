FROM node:16-alpine
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
ENTRYPOINT [ "node", "server.js" ]
