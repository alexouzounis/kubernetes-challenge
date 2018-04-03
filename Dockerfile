FROM node:9-alpine AS base
ARG NAME
ENV NAME=${NAME:-k8s}
ARG PORT
ENV PORT=${PORT:-3000}

RUN npm set progress=false && npm config set depth 0
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


FROM base AS dependencies
COPY app/package*.json ./
RUN JOBS=MAX npm install --production \
  && cp -R node_modules prod_node_modules \
  && npm install \
  && npm cache --force clean && rm -rf /tmp/*

FROM dependencies AS test
RUN apk --no-cache add curl 
ENV DEBUG express:*
ENV NAME="k8s-test"
ENV ASSERTION "Hello k8s-test!"
COPY app/ .
RUN npm test
RUN npm start & sleep 1s \
  && [[ "$(curl -s http://localhost:$PORT)" == "$ASSERTION" ]] \
  && echo "Server is smoked" || exit 1;

FROM base as release
COPY --from=dependencies /usr/src/app/prod_node_modules ./node_modules
COPY app/ .
ENV NODE_ENV=production
EXPOSE ${PORT}/tcp
USER node
CMD ["node", "app.js"]
