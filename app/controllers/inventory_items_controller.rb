class InventoryItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!

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
    @inventory_item = current_company.inventory_items.new(params[:inventory_item])

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

    if @inventory_item.update_attributes(params[:inventory_item])
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
end
