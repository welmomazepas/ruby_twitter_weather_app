class ApplicationController < ActionController::API

    def check_city_info()
    end

    def success_code(response = {})
        msg = { :status => 200, :message => "success!" }.merge(response)
        render :json => msg
    end

    def failure_code(response = {})
        render :json => { :status => 500 }.merge(response)
    end

    def unauthorized_code(response = {})
        render status: :unauthorized, :json => { :status => 401 }.merge(response)
    end

end
