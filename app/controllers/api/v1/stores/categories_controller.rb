class Api::V1::Stores::CategoriesController < ApplicationController

  def index
    render json: Category.first
    # token = request.headers['X_TOKEN']
    # if JsonTokenHandler.authenticate_token(token)
    #   store_name = request.params(:store)
    #   store = Store.find_by(name: store_name)
    #   if store
    #     render json: Category.all
    #   else
    #     render json: nil
    #   end
    # else
    #   render json: nil
    # end
  end

end
