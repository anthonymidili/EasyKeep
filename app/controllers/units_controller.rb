class UnitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!

  def index
    @units = current_company.units.all
  end

  def show
    @unit = current_company.units.find(params[:id])
  end

  def new
    @unit = current_company.units.new
  end

  def edit
    @unit = current_company.units.find(params[:id])
  end

  def create
    @unit = current_company.units.new(params[:unit])

    if @unit.save
      redirect_to units_path, notice: 'Unit type was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @unit = current_company.units.find(params[:id])

    if @unit.update_attributes(params[:unit])
      redirect_to units_path, notice: 'Unit type was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @unit = current_company.units.find(params[:id])
    @unit.destroy

    redirect_to units_url
  end
end
