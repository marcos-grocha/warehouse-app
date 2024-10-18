class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params_and_check_user, only: [ :show, :edit, :update ]

  def index
    @orders = current_user.orders
  end

  def show; end

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
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = "NEGADOOO"
      render :new
    end
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    @order.update(save_params)
    redirect_to @order, notice: "Pedido atualizado com sucesso."
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  private

  def set_params_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, alert: "Você não possui acesso a este pedido."
    end
  end

  def save_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
