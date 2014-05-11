class InventoryItemsController < ApplicationController
  def index
    @inventory_items = current_company.inventory_items.all
  end

  def show
    @inventory_item = current_company.inventory_items.find(params[:id])
  end

  def new
    @inventory_item = current_company.inventory_items.new
  end

  def edit
    @inventory_item = current_company.inventory_items.find(params[:id])
  end

  def create
    @inventory_item = current_company.inventory_items.new(params[:inventory_item])

    if @inventory_item.save
      redirect_to @inventory_item, notice: 'Inventory was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @inventory_item = current_company.inventory_items.find(params[:id])

    if @inventory_item.update_attributes(params[:inventory_item])
      redirect_to @inventory_item, notice: 'Inventory was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @inventory_item = current_company.inventory_items.find(params[:id])
    @inventory_item.destroy

    redirect_to inventory_items_path
  end
end
