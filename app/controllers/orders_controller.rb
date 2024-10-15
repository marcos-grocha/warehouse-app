class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :new ]

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(save_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: "Pedido registrado com sucesso."
    else
      flash.now[:notice] = "NEGADOOO"
      render :new
    end
  end

  private

  def save_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
