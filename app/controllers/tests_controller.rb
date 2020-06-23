class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create

  end

  def plain
    render plain: "Plain text response"
  end

  def json
    render json: "Simple json text reponse"
  end

end
