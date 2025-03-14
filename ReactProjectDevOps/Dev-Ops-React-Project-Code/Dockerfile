# Use Nginx to serve the React build
FROM nginx:alpine

# Copy the pre-built React app from your local system to the container
COPY ./build /usr/share/nginx/html

# Expose port 80 to make the app accessible on the web
EXPOSE 80

# Start Nginx to serve the static files
CMD ["nginx", "-g", "daemon off;"]
