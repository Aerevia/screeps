FROM node:10-alpine
RUN apk add python make g++
VOLUME /screeps
WORKDIR /app
ENV SCREEPS_VERSION 3.1.7
ENV DB_PATH=/screeps/db.json ASSET_DIR=/screeps/assets \
	MODFILE=/screeps/mods.json GAME_PORT=21025 \
	GAME_HOST=0.0.0.0 CLI_PORT=21026 CLI_HOST=0.0.0.0 \
	STORAGE_PORT=21027 STORAGE_HOST=localhost \
	DRIVER_MODULE="@screeps/driver"

RUN yarn add screeps@$SCREEPS_VERSION \
&& ln -s /app/node_modules/.bin/* /usr/local/bin/ 

COPY start.sh /screeps/
COPY custom_mods.json /screeps/
RUN chmod +x /screeps/start.sh
WORKDIR /screeps

CMD ["sh","./start.sh"]
