require 'securerandom'

class RetrosController < ApplicationController
  before_action :authenticate_user!

  Page_size = 5

  def index
    retros = get_retros
    @retros = retros[0, Page_size]
    @retros_offset = retros[Page_size] ? Page_size : 0
    guest_retros = get_guest_retros
    @guest_retros = guest_retros[0, Page_size]
    @guest_offset = guest_retros[Page_size] ? Page_size : 0
  end

  def retro_offset
    offset = params[:offset].to_i
    retros = get_retros(offset)
    render partial: 'summary_offset',
      locals: { 
        retros: retros[0, Page_size],
        owner: true,
        offset: retros[Page_size] ? offset + Page_size : 0,
        last_offset: offset
      }
  end

  def guest_offset
    offset = params[:offset].to_i
    retros = get_guest_retros(offset)
    render partial: 'summary_offset',
      locals: { 
        retros: retros[0, Page_size],
        owner: false,
        offset: retros[Page_size] ? offset + Page_size : 0,
        last_offset: offset
      }
  end

  def show
    @retro = Retro.find(params[:id])

    @retros = Retro.where(user_id: current_user.id).order(retro_date: :desc).limit(6)
  end

  def new
    @custom = Customization.get_custom('new_retro')
    @retro = Retro.new
  end

  def create
    if current_user.guest
      redirect_to retros_path, alert: 'Guest users may not create retros'
    else
      @retro = Retro.new(retro_params)
      @retro[:user_id] = current_user.id

      if @retro.save
        redirect_to @retro
      else
        render :new, alert: 'Error creating retro'
      end
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

      @retro.broadcast_update_to(
        "retro_#{@retro.id}",
        partial: 'common/show_redirect',
        locals: {
          page: nil,
          retro: @retro
        }
      )

      redirect_to "/#{@retro.state}/#{@retro.id}"
    else
      render :new, alert: 'Not permitted'
    end
  end

  def destroy
    @retro = Retro.find(params[:id])
    if @retro[:user_id] == current_user.id
      @retro.destroy
      redirect_to retros_path, notice: 'Retro deleted'
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end

  def add_guest_link
    @retro = Retro.find(params[:id])
    @retro[:guest_link] ||= SecureRandom.uuid
    @retro.save!
    @retros = Retro.where(user_id: current_user.id).order(retro_date: :desc).limit(6)
    @tab = 'guest'
    render :show
  end

  def remove_guest_link
    @retro = Retro.find(params[:id])
    @retro[:guest_link] = nil
    @retro.save!
    @retros = Retro.where(user_id: current_user.id).order(retro_date: :desc).limit(6)
    @tab = 'guest'
    render :show
  end

  def icebreaker_tab
    @retro = Retro.find(params[:id])
    @retros = Retro.where(user_id: current_user.id).order(retro_date: :desc).limit(6)
    @tab = 'icebreaker'
    render :show
  end

  def theme_tab
    @retro = Retro.find(params[:id])
    @retros = Retro.where(user_id: current_user.id).order(retro_date: :desc).limit(6)
    @tab = 'theme'
    render :show
  end

  private

  def retro_params
    params.require(:retro).permit(:description, :retro_date, :state)
  end

  def get_retros(offset = 0)
    Retro.where(user_id: current_user.id).order(retro_date: :desc).offset(offset).limit(Page_size + 1)
  end

  def get_guest_retros(offset = 0)
    Retro
      .where.not(user_id: current_user.id)
      .joins(:participants)
      .where(participants: { email: current_user.email })
      .order(retro_date: :desc)
      .offset(offset)
      .limit(Page_size + 1)
  end

  def verify_participants(participants)
    participants.each do |participant|
      next if participant.user_id.nil?

      user ||= User.where(email: participant.email).first
      if user
        participant.user_id = user.id
        participant.save!
      end
    end
  end
end
