FROM node:9-alpine
WORKDIR /src
COPY app/ .
RUN npm install --quiet && npm test
CMD npm start
