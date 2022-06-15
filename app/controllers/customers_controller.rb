class CustomersController < ApplicationController
    before_action :set_customer, only: %i[ edit update show destroy ]

    def index
        @customers = Customer.all
    end

    def new
        @customer = Customer.new
    end

    def create
        @customer = Customer.new(customers_params)

        if @customer.save
            redirect_to customers_path, notice: "Cliente cadastrado com sucesso"
        else
            render :new
        end
    end

    def show
        @customer = Customer.find(params[:id])
    end

    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])

        if @customer.update(customers_params)
            redirect_to customer_path(@customer.id), notice: "Cliente atualizado com sucesso"
        else
            render :edit
        end
    end

    def destroy
        if @customer.destroy
            redirect_to customers_path, notice: "Cliente excluido com sucesso"
        else
            render :index
        end
    end

    private

    def set_customer
        @customer = Customer.find(params[:id])
    end

    def customers_params
        params.require(:customer).permit(:id, :name, :email, :smoker, :phone, :avatar)
    end
end
