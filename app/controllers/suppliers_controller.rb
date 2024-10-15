class SuppliersController < ApplicationController
  before_action :set_supplier, only: [ :show ]
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(save_params)

    if @supplier.save()
      redirect_to @supplier, notice: "Deu certo caraiiii"
    else
      flash.now[:notice] = "não deu certo brother"
      render "new"
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def save_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
  end
end
