require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params
    end

    def render(template)
      if template.is_a?(Hash)
        type = template.keys.first
        @request.env['simpler.ui_type'] = type
        @request.env['simpler.ui_payload'] = template[type]
      else
        @request.env['simpler.template'] = template
      end
    end

    def status(code)
      @response.status = code
    end

    # access for Content-Type with hash-syntax like
    # headers['Content-Type']
    def headers
      @response
    end

  end
end
