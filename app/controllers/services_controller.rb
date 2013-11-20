class ServicesController < ApplicationController
  before_filter :set_account
  # GET /services
  # GET /services.json
  def index
    @services = @account.services

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service = @account.services.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @service = @account.services.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @service = @account.services.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    @service = @account.services.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to [@account, @service], notice: 'Service was successfully created.' }
        format.json { render json: @service, status: :created, location: @service }
      else
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @service = @account.services.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to [@account, @service], notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = @account.services.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to account_services_url }
      format.json { head :no_content }
    end
  end

private

  def set_account
    @account = current_company.accounts.find(params[:account_id])
  end

end
