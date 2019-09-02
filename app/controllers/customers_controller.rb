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
  def blacklist
    render json: Customer.all.where(blacklisted: true)
  end

  # Добавляем Customer в черный список по телефону
  def add_to_blacklist
    customer = Customer.find_by_phone(params[:phone])
    if customer.update(blacklisted: true)
      render json: {message: "Клиент #{customer.name} добавлен в черный список."}
    else
      render json: {message: 'Не удалось добавить в черный список.'}
    end
  end

  # Убираем Customer из черного списка
  def remove_from_blacklist
    customer = Customer.find(params[:id])
    if customer.update(blacklisted: false)
      render json: {message: "Клиент #{customer.name} исключен из черного списка."}
    else
      render json: {message: 'Не удалось исключить из черного списка.'}
    end
  end


  private

  def customer_params
    c_params = params.require(:customer).permit(:name, :phone, :description, :blacklisted)
    c_params.select { |_, p| p.present? }
  end
end
