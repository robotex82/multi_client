class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :set_clients, only: [:create, :new]
  # GET /sessions/new
  def new
    @session = Session.new
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)
    @client = MultiClient::Client.find(@session.client_id)

    if @session.valid?
      redirect_to root_with_subdomain_url(subdomain: @client.subdomain), notice: 'Session was successfully created.'
    else
      render :new
    end
  end

  # DELETE /posts/1
  def destroy
    redirect_to root_url, notice: 'Session was successfully destroyed.'
  end

  private

  def set_clients
    @clients = MultiClient::Client.all
  end

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:client_id)
  end
end