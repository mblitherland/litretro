class RetrosController < ApplicationController
  before_action :authenticate_user!

  def index
    @retros = Retro.where(user_id: current_user.id).order(retro_date: :desc).limit(6)
    # @guest_retros = []
    @guest_retros = Retro
      .joins(:participants)
      .where(participants: { email: current_user.email })
      .order(retro_date: :desc).limit(6)
  end

  def show
    @retro = Retro.find(params[:id])
  end

  def new
    @retro = Retro.new
  end

  def create
    @retro = Retro.new(retro_params)
    @retro[:user_id] = current_user.id

    if @retro.save
      redirect_to @retro
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @retro = Retro.find(params[:id])
  end

  def update
    @retro = Retro.find(params[:id])

    if @retro[:user_id] == current_user.id && @retro.update(retro_params)
      # If any participants haven't been verified yet, now's a good time to check
      verify_participants(@retro.participants)

      redir_location = @retro.state == 'setup' ? '/retros' : "/#{retro.state}/#{retro.id}"

      @retro.broadcast_update_to(
        "retro_#{@retro.id}",
        partial: 'common/show_redirect',
        locals: {
          state: @retro.state,
          redir_location: redir_location
        }
      )

      redirect_to @retro
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @retro = Retro.find(params[:id])
    if @retro[:user_id] == current_user.id
      @retro.destroy
      redirect_to retros_path, status: :see_other
    else
      redirect_to retros_path, status: :forbidden
    end
  end

  private

  def retro_params
    params.require(:retro).permit(:description, :retro_date, :state)
  end

  def verify_participants(participants)
    participants.each do |participant|
      if participant.user_id.nil?
        user ||= User.where(email: participant.email).first
        if user
          participant.user_id = user.id
          participant.save!
        end
      end
    end
  end
end
