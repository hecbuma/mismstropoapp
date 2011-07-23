Tropo::Application.routes.draw do
  post 'send_sms' => 'messages#send_sms'
  post 'tropo_callback' => 'messages#tropo_callback'
  root :to => "messages#index"
end
