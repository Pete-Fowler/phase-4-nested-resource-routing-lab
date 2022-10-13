class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id] 
      user = User.find(params[:user_id])
      items = user.items.all
    else  
      items = Item.all
    end 
    render json: items, include: :user
  end 

  def show 
    if params[:user_id] 
      user = User.find(params[:user_id]) 
      item = user.items.find(params[:id]) 
    else 
      item = Item.find(params[:items_id])
    end
    render json: item 
  end 

  def create
    if params[:user_id]
      user = User.find(params[:user_id]) 
      item = user.items.create(item_params)
    else 
      item = Item.create(item_params)
    end 
    render json: item, status: :created
  end 

  private 

  def item_params 
    params.permit(:name, :description, :price)
  end 

  def render_not_found
    render json: {errors: 'Record not found'}, status: :not_found 
  end 

end
