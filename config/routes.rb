Simpler.application.routes do
  get '/tests', 'tests#index'
  post '/tests', 'tests#create'

  get '/plain', 'tests#plain'
  get '/json', 'tests#json'
end
