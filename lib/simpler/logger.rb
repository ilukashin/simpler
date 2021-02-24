module Simpler
  class Logger

    def initialize
      # 'log/app.log'
      @log_dir = Simpler.root.join('log')
      @log_file_path = @log_dir.join('app.log')
    end
    
    # Request: GET /tests?category=Backend
    # Handler: TestsController#index
    # Parameters: {'category' => 'Backend'}
    # Response: 200 OK [text/html] tests/index.html.erb
    def log(env)
      message = Time.now.to_s + 
        " Request: #{env['REQUEST_METHOD']} #{env['PATH_INFO']}\n" +
        "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}\n" +
        "Parameters: #{env['simpler.controller'].request.params}\n" +
        "Status: #{env['simpler.controller'].response.status} [#{env['simpler.controller'].response.headers['Content-type']}] #{env['simpler.template']}\n"

      File.write(@log_file_path, message, mode: 'a')
    end
  end
end
