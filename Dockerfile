FROM alpine:latest AS base
RUN apk add --no-cache nodejs npm tini
WORKDIR /app
ENTRYPOINT ["/sbin/tini", "--"]
COPY package.json .

FROM base AS dependencies
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production
RUN cp -R node_modules prod_node_modules
RUN npm install

FROM base AS release
COPY --from=dependencies /app/prod_node_modules node_modules
COPY . .
EXPOSE 8080
CMD npm run start
