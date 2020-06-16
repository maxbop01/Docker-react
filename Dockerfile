FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80 
#dice che porta esporre al servizio AWS (dove si deploya l'app)
COPY --from=builder /app/build /user/share/nginx/html 
#copio dalla fase builder il file creato in quella fase
#non serve esplicitare il comando per far partire nginx