# 1. Create the build files
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# Creates app assets in /app/build
RUN npm run build

# 2. Run the built files in Nginx
FROM nginx
# Take shit from the previous phase FROM TO
# /usr/share/nginx/html taken from Nginx docs - its the default dir for serving static content
COPY --from=builder /app/build /usr/share/nginx/html
# No need for RUN because nginx image does that automagically