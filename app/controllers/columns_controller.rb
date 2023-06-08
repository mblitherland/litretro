class ColumnsController < ApplicationController
  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      if params[:column][:supplied].empty?
        headers = params[:column][:curated].split(%r{,\s*})
        puts(">>> curated: #{headers.to_yaml}")
      else
        headers = params[:column][:supplied].split(%r{,\s*})
        puts(">>> supplied: #{headers.to_yaml}")
      end
      i = 0
      headers.each do |header|
        @retro.columns.create({
          retro_id: params[:retro_id],
          name: header,
          rank: i += 1
        })

      end
    else
      redirect_to retros_path, status: :forbidden
    end
    redirect_to @retro
  end
end
