FROM nginx:alpine

# Copy build output to nginx html directory
COPY dist /usr/share/nginx/html

# Expose port 3000 (your requirement)
EXPOSE 3000

# Overwrite nginx config to use port 3000
RUN sed -i 's/80;/3000;/' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
