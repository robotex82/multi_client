class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :set_tenants, only: [:create, :new]
  # GET /sessions/new
  def new
    @session = Session.new
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)
    @tenant = Tenant.find(@session.tenant_id)

    if @session.valid?
      redirect_to root_with_subdomain_url(subdomain: @tenant.subdomain), notice: 'Session was successfully created.'
    else
      render :new
    end
  end

  # DELETE /posts/1
  def destroy
    redirect_to root_url, notice: 'Session was successfully destroyed.'
  end

  private

  def set_tenants
    @tenants = Tenant.all
  end

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:tenant_id)
  end
end
