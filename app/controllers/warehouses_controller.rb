class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  def create
    # 1 -- Receber os dados enviados # => Strong Parameters
    warehouse_params = params.require(:warehouse).permit(:name, :description, :code, :address, :city, :cep, :area)

    # 2 -- Criar um novo galpão no banco de dados
    w = Warehouse.new(warehouse_params)

    # 3 -- Salvar o galpão que foi criado
    w.save()

    # 4 -- Redirecionar para a tela inicial
    redirect_to root_path, notice: "Galpão cadastrado com sucesso!"
  end
end
