class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_if_company?, only: [ :new, :create ]

  def show
    @company = current_user.company

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    @company = current_user.build_company

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
    @company = current_user.company
  end

  def create
    @company = current_user.build_company(params[:company])

    respond_to do |format|
      if @company.save && current_user.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company = current_user.company

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = current_user.company
    @company.destroy

    respond_to do |format|
      format.html { redirect_to new_company_path }
      format.json { head :no_content }
    end
  end

  private

  def redirect_if_company?
    if current_user.company
      @company = current_user.company
      redirect_to edit_company_path(@company)
    end
  end
end
