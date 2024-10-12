class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    # 1 -- Receber os dados enviados # => Strong Parameters
    warehouse_params = params.require(:warehouse).permit(:name, :description, :code, :address, :city, :cep, :area)

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
end
