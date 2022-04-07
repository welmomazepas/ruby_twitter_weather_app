class WeatherController < ApplicationController

    def get_city_weather
        if params[:city] && params[:state] && params[:country_code]
            begin
                weather_result = OpenWeather.get_city_weather(params[:city], params[:state], params[:country_code])
                if weather_result.present?
                    return success_code({weather_info: weather_result})
                end
            rescue
                return failure_code()
            end
        end
        return failure_code()
    end

    def post_city_weather_to_twitter
        result = get_city_weather(params)
        TwitterBot.post_city_weather_to_twitter(result)
    end

end