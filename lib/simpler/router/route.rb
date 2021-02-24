module Simpler
  class Router
    class Route
      
      PATH_PARAMS_PATTERN = /:\w+/

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action

      end

      def match?(method, path)
        @method == method && path.match(Regexp.new('^' + @path.gsub(PATH_PARAMS_PATTERN, '(\w|\d)+') + '$'))
      end

      def extract_params(env)
        env['simpler.route_params'] = {}

        request_path = env['PATH_INFO'].split('/')
        @path.split('/').each_with_index do |el, index|
          if el.start_with?(':')
            env['simpler.route_params'][el.delete_prefix(':').to_sym] = request_path[index]
          end
        end
      end
    end
  end
end
