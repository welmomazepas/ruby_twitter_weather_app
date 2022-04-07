require 'httparty'

class OpenWeather

    def get_city_weather(city, state, country_code)
        latitude, longitude = get_geo_locale(city, state, country_code)
        if latitude.present? && longitude.present?
            weather_info = get_weather_onecall(latitude, longitude)
            if weather_info.present?
                return weather_info
            end
        end
        
        return nil
    end

    def get_geo_locale(city, state, country_code)
        begin 
            if state.length > 2
                state_code = StatesCodes.get_code_from_state(state)
            else
                state_code = state
            end
            url_route = "geo/1.0/direct?q=#{city},#{state_code},#{country_code}&limit=5"
            geo_locale_response = get(url_route)
            if geo_locale_response.success?
                for city_match in geo_locale_response
                    if (city_match["name"] == city) && (state_code == StatesCodes.get_code_from_state(city_match["state"]))
                        return city_match["lat"], city_match["lon"]
                    end
                end
            end
            return nil, nil
        rescue
            Rails.logger.error("Error while trying to fetch Latitude and Longitude")
            return nil, nil
        end
    end

    def get_weather_onecall(latitude, longitude)
        begin 
            url_route = "data/2.5/onecall?lat=#{latitude}&lon=#{longitude}"
            onecall_response = get(url_route)
            if onecall_response.code == 200
                return onecall_response
            else
                return nil
            end
        rescue
            Rails.logger.error("Error while trying to fetch Open Weather OneCall")
            return nil
        end
    end

    private

    def get(route)
        HTTParty.get(
            URI.escape("#{ENV['OPEN_WEATHER_URL']}/#{route}&appid=#{ENV["OPEN_WEATHER_API_KEY"]}"),
            :headers => {
            "Accept" => "application/json",
            "Content-Type" => "application/json",
            }        
        ).parsed_response
    end
    
end