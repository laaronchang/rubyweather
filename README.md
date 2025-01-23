# rubyweather
Simple Ruby Based Weather API with IP Geo-location

Implemented into this weather retrieveal API are two other API's to acquire a location.
The first step is acquiring one's public IP address, here we are using [https://api.ipfy.org/](https://api.ipify.org), note that a VPN might affect the retrieval of the actual public IP.
Second step is using that public IP address and determining an approximate location, for this we are using [http://ip-api.com/](https://ip-api.com/). This offers many variables, only latitude and longitude are needed.

The final step in the process is the U.S. National Weather Service (https://www.weather.gov/) website's API (https://api.weather.gov)
