class Api::V1::CollectionsController < ApplicationController

    include Pundit
    before_action :authenticate_with_token!
    before_action :authorize_collection, only: [:update, :destroy]

    def index
        user = user.find_by(api_token: request.headers['Authorization'])
        if user
            collections = user.collections.select(:id, :name, :description, :category_id, :user_id)
            render json: collections
        else
            render json: {error: 'Unauthorized'}, status: :unauthorized
        end
    end

    def create
        user = User.find_by(api_token: request.headers['Authorization'])
        if user
            collection = user.collections.build(collection_params)
            if collection.save
                render json: collection, status: :created
            else
                render json: collection.errors, staus: :unprocessable_entity
            end
        else
            render json: {error: 'Unauthorized'}, status: :unauthorized
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
        api_token = request.headers['Authorization']
        head :unauthorized unless User.exists?(api_token: api_token)
    end

    def collection_params
        params.require(:collection).permit(:name, :description, :category_id)
    end

    def authorize_collection
        authorize @collection
    end


end