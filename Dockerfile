FROM meteor/meteor-base:node14.21.4-10.2023 AS build
# WORKDIR /app
# COPY --chown=mt . /app/

COPY --chown=mt . /usr/src/app
WORKDIR /usr/src/app

# RUN chmod -R 700 /usr/src/app/.meteor/local
RUN meteor npm install

ENV ROOT_URL="https://treehouse.gartner.io"
EXPOSE 3000
CMD ["npm", "start"]

# RUN meteor build --directory /app/output/

# FROM zodern/meteor AS deploy
# COPY --from=build --chown=app:app /app/output/bundle /built_app
# RUN cd /built_app/programs/server && npm install

# ARG NODE_VERSION="node version" 
# ENV ROOT_URL=https://treehouse.gartner.io
