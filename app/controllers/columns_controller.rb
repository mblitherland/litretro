class ColumnsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      if params[:column][:supplied].empty?
        headers = params[:column][:curated].split(%r{,\s*})
      else
        headers = params[:column][:supplied].split(%r{,\s*})
      end

      # We're replacing the columns here if new ones were provided
      @retro.columns.each(&:delete) if @retro.columns.length > 0
      i = 0
      headers.each do |header|
        @retro.columns.create({
          retro_id: params[:retro_id],
          name: header,
          rank: i += 1
        })
      end
      redirect_to "/retros/#{@retro.id}/theme"
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end
end
