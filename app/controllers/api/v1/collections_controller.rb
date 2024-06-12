class Api::V1::CollectionsController < ApplicationController
  include Pundit
  before_action :authenticate_with_token!
  before_action :set_collection, only: [:update, :destroy]
  before_action :authorize_collection, only: [:update, :destroy]

  def index
    user = current_user
    if user
      collections = user.collections.select(:id, :name, :description, :category_id).as_json
      collections.each do |collection|
        collection_record = Collection.find(collection['id'])
        collection['item_count'] = collection_record.items.count
      end
      render json: collections
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def create
    user = current_user
    if user
      collection = user.collections.build(collection_params)
      if collection.save
        render json: collection, status: :created
      else
        render json: collection.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def update
    if @collection.update(collection_params)
      render json: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @collection.destroy
    head :no_content
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def authenticate_with_token!
    api_token = request.headers['Authorization'].to_s.split(' ').last
    head :unauthorized unless User.exists?(api_token: api_token)
  end

  def current_user
    api_token = request.headers['Authorization'].to_s.split(' ').last
    User.find_by(api_token: api_token)
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :category_id)
  end

  def authorize_collection
    authorize @collection
  end
end
