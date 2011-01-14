require 'js_message'
require 'rails'

module JsMessage
  class Railtie < Rails::Railtie
    initializer "js_message.initializer" do |app|
      ActionController::Base.class_eval do
        include JsMessage::ControllerMethods
      end

      Mime::Type.register_alias "application/json", :jsm
    end

    rake_tasks do
      load "js_message/tasks.rake"
    end
  end
end
