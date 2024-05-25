class LikesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_item

    def create
        @item.likes.create(user: current_user)
        redirect_to collection_item_path(@item.collection, @item)
    end

    def destroy
        @item.likes.where(user: current_user).destroy_all
        redirect_to collection_item_path(@item.collection, @item)
    end

    private

    def set_item
        @item = Item.find(params[:item_id])
    end

end
