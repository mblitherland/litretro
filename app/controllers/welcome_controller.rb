class WelcomeController < ApplicationController
  before_action :authenticate_user!

  include ActionController::Live

  def index
    @retro = Retro.find(params[:id])

    # TODO: Make sure this user is actually allowed to access this retro
  end

  def stream
    @retro = Retro.find(params[:id])
    response.headers['Content-Type'] = 'text/event-stream'
    1000.times do
      response.stream.write "/#{@retro.state}/#{@retro.id}"
      sleep 10
    end
  ensure
    response.stream.close
  end
end
