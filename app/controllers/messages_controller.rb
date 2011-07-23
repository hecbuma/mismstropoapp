class MessagesController < ApplicationController
require 'net/http'
  # Process an SMS message request from Tropo
      def index
      end

      def send_sms
        http = Net::HTTP.new(URI.parse(('http://mismstropapp.heroku.com')))
        token = '06a748a14827484b94cf6a54ae796f5dcca4ca9ee1c87810470d6efaba46681a1303749943b18bb4b55faf7c'
        path = "/1.0/sessions?action=create&token=#{token}&msg=#{CGI::escape(params[:text])}&to=#{params[:phone]}&callerID=#{AppConfig[Rails.env]['tropo']['app_phone']}"
        resp = http.get(path)
        resp.code
        if resp.code == '200'
          flash[:notice] = 'Sent!'
        else
          flash[:error] = "#Fail! (error code: #{resp.code}) everything else: #{resp}"
        end
        redirect_to root_url
      end

      def tropo_callback
        sessions_object = Tropo::Generator.parse request.filtered_parameters
        msg = sessions_object[:session][:parameters][:msg]
        number_to_dial = sessions_object[:session][:parameters][:to]
        tropo = Tropo::Generator.new do
          message({
            :to => "#{number_to_dial}",
            :channel => 'TEXT',
            :network => 'SMS'}) do
              say :value => msg
            end
        end
        response = tropo.response
        render :json => JSON.parse(response)
      end

    end
