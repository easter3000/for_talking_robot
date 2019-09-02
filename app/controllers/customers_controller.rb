class CustomersController < ApplicationController

  # Показывааем все Customer, которые не в черном списке
  def index
    render json: Customer.all.where(blacklisted: false)
  end

  # Редактируем конкретного Customer
  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      render json: customer
    else
      render json: {message: 'Не удалось обновить ваши данные.'}
    end
  end

  # Показываем черный список Customer
  def blacklisted
    render json: Customer.all.where(blacklisted: true)
  end


  private

  def customer_params
    c_params = params.require(:customer).permit(:name, :phone, :description, :blacklisted)
    c_params.select {|_, p| p.present?}
  end
end
