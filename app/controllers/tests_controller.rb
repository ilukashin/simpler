class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create

  end

  def plain
    headers['Content-Type'] = 'text/plain'
    render plain: "Plain text response"
  end

  def json
    status 201
    render json: "Simple json text reponse"
  end

end
