class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [ :show, :edit, :update, :destroy ]

  def show
    @stocks = @warehouse.stock_products.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    # 2 -- Criar um novo galpão no banco de dados
    @warehouse = Warehouse.new(warehouse_params)

    # 3 -- Salvar o galpão que foi criado
    if @warehouse.save()
      # 4 -- Redirecionar para a tela inicial
      redirect_to root_path, notice: "Galpão cadastrado com sucesso!"
    else
      flash.now[:notice] = "Galpão não cadastrado."
      render "new"
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: "Galpão atualizado com sucesso!"
    else
      flash.now[:notice] = "Galpão não atualizado."
      render "edit"
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: "Galpão removido com sucesso"
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params # 1 -- Receber os dados enviados # => Strong Parameters
    params.require(:warehouse).permit(:name, :description, :code, :address, :city, :cep, :area)
  end
end
