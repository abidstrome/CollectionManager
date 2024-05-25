class ItemsController < ApplicationController
    before_action :authenticate_user!, expect: [:index, :show]
    before_action :set_collection
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
        @items = @collection.items.order(params[:sort])
        if params[:filter].present?
          @items = @items.where("name LIKE ?", "%#{params[:filter]}%")
        end
        authorize @items
    end

    def show
        authorize @item
        @comments = @items.comments
    end

    def new
        @item = @collection.items.build
        authorize @item
    end

    def edit
        authorize @item
    end

    def create
        @item = @collection.items.new(item_params)
        authorize @item

        if @item.save
            redirect_to [@collection, @item], notice: 'Item created successfully.'
        else
            render :new
        end
    end

    def update
        authorize @item
        if @item.update(item_params)
            redirect_to [@collection, @item], notice: 'Item updated successfully.'
        else
            render :edit
        end
    end

    def destroy
        authorize @item
        @item.destroy
        redirect_to collection_items_path(@collection), notice: 'Item deleted successfully.'
    end

    private

    def set_collection
        @collection = Collection.find(params[:collection_id])
    end

    def set_item
        @item = @collection.items.find(params[:id])
    end

    def item_params
        params.require(:item).permit(:name, :tags, :custom_string1,
                                     :custom_string2, :custom_string3, :custom_text1,
                                     :custom_text2, :custom_text3, :custom_int1, :custom_int2,
                                     :custom_int3, :custom_bool1, :custom_bool2, :custom_bool3,
                                     :custom_date1, :custom_date2, :custom_date3)
    end

    def authorize_user!
        redirect_to collection_items_path(@collection), alert: 'Not authorized' unless current_user == @collection.user
    end

                                    

end
