class PartiesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_party, only: %i[show update destroy match]
  before_action :is_owner?, only: %i[show update destroy match]

  def index
    @parties = current_user.parties
  end

  def create
    # title: "New Secret santa"
    @party = Party.new(party_params)

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party successfully created.' }
      else
        format.html { redirect_to root_path, alert: @party.errors }
      end
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @party.update(party_params)
        format.json { render json: true }
      else
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @party.destroy

    respond_to do |format|
      format.json { render json: true }
    end
  end

  def match
    respond_to do |format|
      if @campaign.status != "pending"
        format.json { render json: 'Já foi sorteada', status: :unprocessable_entity }
      elsif @campaign.members.count < 3
        format.json { render json: 'A campanha precisa de pelo menos 3 pessoas', status: :unprocessable_entity }
      else
        CampaignRaffleJob.perform_later @campaign
        format.json { render json: true }
      end
    end
  end

  private

  def set_party
    @party = Party.find(params[:id])
  end

  def party_params
    params.require(:party)
      .permit(:title, :description, :event_date, :event_hour, :location)
      .merge(user: current_user)
  end

  def is_owner?
    unless current_user.eql(@party.user)
      respond_to do |format|
        format.json { render json: false, status: :forbidden }
        format.html { redirect_to root_path }
      end
    end
  end
end
