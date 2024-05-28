class CollectionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_collection, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    before_action :set_categories, only: [:new, :edit, :update, :create]
    def index
        @collections = policy_scope(Collection)
    end

    def show
        authorize @collection
        @items = @collection.items.order(params[:sort])
        if params[:filter].present?
            @items = @items.where("name LIKE ?", "%#{params[:filter]}%")
        end
    end


    def new
        @collection = current_user.collections.build
        authorize @collection
    end

    def create
        @collection = current_user.collections.build(collection_params)
        authorize @collection
        if @collection.save
            redirect_to @collection, notice: 'Collection created successfully'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit

        authorize @collection

    end

    def update
        authorize @collection
        puts "Updating collection with params: #{collection_params.inspect}"
        if @collection.update(collection_params)
            redirect_to @collection, notice: 'Collection updated successfully'
        else
            render :edit
        end
    end

    def destroy
        authorize @collection
        @collection.destroy
        redirect_to collections_path, notice: 'Collection deleted successfully.'
      end

    private

    def set_collection
        @collection= Collection.find(params[:id])
    end

    def set_categories
        @categories= Category.all
    end

    def collection_params
        params.require(:collection).permit(:name, :description, :image_url, :category_id,
                                           :custom_string1_state, :custom_string1_name,
                                           :custom_string2_state, :custom_string2_name,
                                           :custom_string3_state, :custom_string3_name,
                                           :custom_text1_state, :custom_text1_name,
                                           :custom_text2_state, :custom_text2_name,
                                           :custom_text3_state, :custom_text3_name,
                                           :custom_int1_state, :custom_int1_name,
                                           :custom_int2_state, :custom_int2_name,
                                           :custom_int3_state, :custom_int3_name,
                                           :custom_bool1_state, :custom_bool1_name,
                                           :custom_bool2_state, :custom_bool2_name,
                                           :custom_bool3_state, :custom_bool3_name,
                                           :custom_date1_state, :custom_date1_name,
                                           :custom_date2_state, :custom_date2_name,
                                           :custom_date3_state, :custom_date3_name)
      end

    def authorize_user!
        # redirect_to collections_path, alert: 'Not authorized' unless current_user == @collection.user
        authorize @collection
    end

end
