class InventoryItemsController < ApplicationController
  def index
    @inventory_items = InventoryItem.all
  end

  def show
    @inventory_item = InventoryItem.all
  end

  def new
    @inventory_item = InventoryItem.new
  end

  def edit
    @inventory_item = InventoryItem.find(params[:id])
  end

  def create
    @inventory_item = InventoryItem.new(params[:inventory_item])

    respond_to do |format|
      if @inventory_item.save
        redirect_to @inventory_item, notice: 'Inventory was successfully created.'
      else
        render action: "new"
      end
    end
  end

  def update
    @inventory_item = InventoryItem.find(params[:id])

    respond_to do |format|
      if @inventory_item.update_attributes(params[:inventory_item])
        redirect_to @inventory_item, notice: 'Inventory was successfully updated.'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.destroy

    respond_to do |format|
      redirect_to inventories_url
    end
  end
end
