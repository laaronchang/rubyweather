require "http"
require "json"
require "uri"

# OBTAINS PUBLIC IP ADDRESS
ip_address = HTTP.get(URI("https://api.ipify.org"))

# DETECTS LOCATION BASED ON IP ADDRESS
geo_data = HTTP.get("http://ip-api.com/json/#{ip_address}").parse

lat = geo_data["lat"]
lon = geo_data["lon"]


# PRINTS OUT CITY AND STATE
puts "Location: " "#{geo_data['city']}, #{geo_data['region']}", "#{lat}, #{lon}"
puts "\n"
# Clean up below
#puts (lat), (lon)
#puts geo_data["city"],geo_data["region"]


# PING WEATHER.GOV WITH CURRENT LOCATION
weather_url = "https://api.weather.gov/points/#{lat},#{lon}"
weather_uri = URI(weather_url)


# ALL WEATHER DATA
weather_response = HTTP.get(weather_uri)
weather_data = JSON.parse(weather_response)
#puts weather_data


# CURRENT WEATHER CONDITIONS DATA
current_conditions_url = weather_data["properties"]["forecastHourly"]
current_conditions_uri = URI(current_conditions_url)
# Other Data
extra_conditions_url = weather_data["properties"]["forecastGridData"]
extra_conditions_uri = URI(extra_conditions_url)


# PING FOR CURRENT WEATHER DATA
current_weather_response = HTTP.get(current_conditions_uri)
current_weather_data = JSON.parse(current_weather_response)
extra_weather_response = HTTP.get(extra_conditions_uri)
extra_weather_data = JSON.parse(extra_weather_response)


# RETRIEVE THE WEATHER DATA
time = current_weather_data["properties"]["generatedAt"]
short_forecast = current_weather_data["properties"]["periods"][0]["shortForecast"]
temperature = current_weather_data["properties"]["periods"][0]["temperature"]
humidity = current_weather_data["properties"]["periods"][0]["relativeHumidity"]["value"]
precipitation = current_weather_data["properties"]["periods"][0]["probabilityOfPrecipitation"]["value"]
wind = current_weather_data["properties"]["periods"][0]["windSpeed"]
elevation = current_weather_data["properties"]["elevation"]["value"]
snow = extra_weather_data["properties"]["snowFallAmount"]
dewpoint = current_weather_data["properties"]["periods"][0]["dewpoint"]["value"]
pressure = extra_weather_data["properties"]["pressure"]["values"]



# PRINTS WEATHER DATA
puts "Time: #{time}"
puts "Conditions: #{short_forecast}"
puts "Current Temperature: #{temperature}°F"
puts "Humidity: #{humidity}%" 
puts "Precipitation: #{precipitation}%"
puts "Wind Speed: #{wind}"
puts "Elevation: #{elevation} meters"
puts "Snow: #{snow} mm"
# puts "Barometric Pressure: #{pressure} hPa"
puts "Dewpoint: #{dewpoint.round(3)}"

# BAROMETRIC PRESSURE - ALTERNATE
def fetch_surface_pressure(lat, lon)
  url = URI("https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{lon}&current=surface_pressure&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=America%2FLos_Angeles&forecast_days=1")
  
  response = HTTP.get(url)
  data = JSON.parse(response)
  
  # Extract the surface pressure
  baro_pressure = data.dig('current', 'surface_pressure')
  
  puts "Barometric Pressure: #{baro_pressure} hPa"
end
fetch_surface_pressure(lat, lon)