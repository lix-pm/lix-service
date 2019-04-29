FROM node:12

RUN yarn global add lix pm2

ENV PORT=8080
ENV PATH="/root/.yarn/bin:${PATH}"
EXPOSE 8080
WORKDIR /controller
CMD ["pm2-runtime", "start", "index.js"]
ENTRYPOINT []

COPY bin/controller/index.js /controller/index.js
