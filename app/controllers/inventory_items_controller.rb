class InventoryItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    if params[:tag]
      @inventory_items = current_company.tagged_with(params[:tag]).page(params[:page]).per(20)
    else
      @inventory_items = current_company.inventory_items.page(params[:page]).per(20)
    end
  end

  def show
    @inventory_item = current_company.inventory_items.find(params[:id])
  end

  def new
    @inventory_item = current_company.inventory_items.new
  end

  def create
    @inventory_item = current_company.inventory_items.new(inventory_item_params)

    if @inventory_item.save
      redirect_to inventory_items_path, notice: 'Inventory was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @inventory_item = current_company.inventory_items.find(params[:id])
  end

  def update
    @inventory_item = current_company.inventory_items.find(params[:id])

    if @inventory_item.update_attributes(inventory_item_params)
      redirect_to inventory_items_path, notice: 'Inventory was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @inventory_item = current_company.inventory_items.find(params[:id])
    @inventory_item.destroy

    redirect_to inventory_items_path
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def inventory_item_params
    params.require(:inventory_item).permit(:company_id, :description, :serial_number, :quantity, :tag_list,
                                           :new_unit_type)
  end
end
