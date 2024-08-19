#!/bin/bash

# URL to check
URL="https://guvi.in"

# Send a HEAD request to the URL and capture the HTTP status code
http_status=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

# Print the HTTP status code
echo "HTTP Status Code: $http_status"

# Print success or failure message based on the status code
case $http_status in
    200)
        echo "Success: The website is reachable."
        ;;
    400)
        echo "Failure: Bad Request."
        ;;
    401)
        echo "Failure: Unauthorized."
        ;;
    403)
        echo "Failure: Forbidden."
        ;;
    404)
        echo "Failure: Not Found."
        ;;
    500)
        echo "Failure: Internal Server Error."
        ;;
    502)
        echo "Failure: Bad Gateway."
        ;;
    503)
        echo "Failure: Service Unavailable."
        ;;
    *)
        echo "Failure: An unexpected error occurred. HTTP Status Code: $http_status"
        ;;
esac
