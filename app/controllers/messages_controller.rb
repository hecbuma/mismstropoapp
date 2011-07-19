class MessagesController < ApplicationController
  # Process an SMS message request from Tropo
  def sms
    #values = params[:session][:parameters]
    request_token = '06a748a14827484b94cf6a54ae796f5dcca4ca9ee1c87810470d6efaba46681a1303749943b18bb4b55faf7c'
    request_user = '534'
    request_ticket = Time.now.to_i

    # Generate Tropo response 
    t = Tropo::Generator.new
    t.call(:to => '+523121194496', :network => "SMS")
    t.say(:value => "its aliveee!")
    tropo_message = t.response

    respond_to do |format|
      format.html  { redirect_to root_path }
      format.json  { render :json => tropo_message }
    end
  end  
end
