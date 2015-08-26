class API::V1::AlertsController  < ActionController::API
  def create
    alert_params = permit_alert_params
    # if alert_params[:contacts].present?
    #   alert_params[:contacts] = alert_params[:contacts].join(",")
    # end

    location = Location.where(:device_id => alert_params[:device_id]).first_or_create
    location.update_attributes alert_params
    contacts = alert_params[:contacts].split(",")

    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    failed_contacts = []
    sms_message = "#{location.sender} needs your help now.\n" \
                  "Emergency time: #{location.updated_at.strftime("%d-%m-%Y %H:%M:%S UTC")}\n" \
                  "Click here to see location: " \
                  "#{request.protocol}#{request.host}/location/#{alert_params[:device_id]}"
    contacts.each do |contact|
      begin
        message = @client.account.messages.create ({
          :body => sms_message,
          :to => contact,
          :from => ENV["TWILIO_PHONE_FROM"]
        })
      rescue Exception => e
        puts "*" * 40
        puts e.to_s
        failed_contacts << contact
      end
    end

    if failed_contacts.count > 0
      render json: { 
        :failure => true,
        :failed_contacts => failed_contacts.join(","),
      }, status: :created and return
    end

    render json: { 
      :success => true
    }, status: :created
  end

  private

  def permit_alert_params
    params.permit(:device_id, :sender, :longitude, :latitude, :message, :contacts)
  end
end