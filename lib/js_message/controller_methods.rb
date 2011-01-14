module JsMessage
  module ControllerMethods
    # Helper to render the js_message response.
    #
    # Pass in a type of message (:ok, :error, :redirect) and any other
    # data you need. Default data attributes in the response are:
    #
    #   * html
    #   * message
    #   * to (used for redirects)
    #
    # Examples:
    #
    #   # Send a successful response with some html
    #   render_js_message :ok, :html => "<p>It worked!</p>"
    #
    #   # Send a redirect
    #   render_js_message :redirect, :to => "http://www.google.com"
    #
    #   # Send an error response with a message
    #   render_js_message :error, :message => "Something broke!"
    #
    # Of course, if you don't need other data sent back in the response
    # this works as well:
    #
    #   render_js_message :ok
    #
    def render_js_message(type, hash = {})
      unless [ :ok, :redirect, :error ].include?(type)
        raise "Invalid js_message response type: #{type}"
      end

      js_message = {
        :status => type,
        :html => nil,
        :message => nil,
        :to => nil
      }.merge(hash)

      render_options = {:json => js_message}
      render_options[:status] = 400 if type == :error

      render(render_options)
    end

  end
end
