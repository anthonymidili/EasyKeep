class CompaniesController < ApplicationController
  before_filter :authenticate_admin!

  def show
    @company = current_admin.company

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    if current_admin.company.nil?
      @company = current_admin.build_company

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @company }
      end
    else
      @company = current_admin.company
      redirect_to edit_company_path(@company)
    end
  end

  def edit
    @company = current_admin.company
  end

  def create
    @company = current_admin.build_company(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company = current_admin.company

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
    @company = current_admin.company
    @company.destroy

    respond_to do |format|
      format.html { redirect_to new_company_path }
      format.json { head :no_content }
    end
  end
end
