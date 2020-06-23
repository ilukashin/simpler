require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      type = @env['simpler.ui_type']

      if type == :plain
        @env['simpler.ui_payload']
      elsif type == :json
        @env['simpler.ui_payload'].to_json
      else
        template = File.read(template_path)
  
        ERB.new(template).result(binding)
      end

    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

  end
end
