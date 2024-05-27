class LikesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_collection
    before_action :set_item

    def create
        @like = @item.likes.build(user: current_user)
        authorize @like
        if @like.save
            redirect_to collection_item_path(@collection, @item)
        else
            redirect_to collection_item_path(@collection, @item)
        end
    end

    def destroy
        @like = @item.likes.find(params[:id])
        authorize @like
        @like.destroy
        redirect_to collection_item_path(@item.collection, @item)
    end

    private

    def set_item
        @item = Item.find(params[:item_id])
    end

    def set_collection
        @collection= Collection.find(params[:collection_id])
    end
end
