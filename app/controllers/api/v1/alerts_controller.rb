class API::V1::AlertsController  < ActionController::API
  def create
    binding.pry
    alert_params = permit_alert_params
    if alert_params["contacts"].present?
      alert_params["contacts"] = alert_params["contacts"].join(",")
    end

    location = Location.new alert_params
    if location.save

      # Send SMS to contacts
      # alert_params["contacts"].each do |contact|

      # end

      render json: { 
        :success => true
      }, status: :created and return
    end

    render json: { 
      :errors => "Error"
    }, status: :unprocessable_entity
  end

  private

  def permit_alert_params
    params.permit(:device_id, :longitude, :latitude, :message, :contacts => [])
  end
end