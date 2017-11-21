FROM node:9-alpine
WORKDIR /src
COPY app/ .
RUN npm install --quiet && npm test
EXPOSE 3000
CMD npm start
