class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.create(params.require(:order).permit!)
    redirect_to @order
  end

  def update
    @order = Order.find(params[:id])
    @order.update(params.require(:order).permit!)
    redirect_to @order
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_path
  end
end
