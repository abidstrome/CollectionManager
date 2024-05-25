class CategoriesController < ApplicationController
    before_action :authenticate_user!
    # before_action :admin_only, except: [:index, :show]
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @categories = Category.all
    end

    def show
        @collections = @categories.collections
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category, notice: 'Category created successfully'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            redirect_to @category, notice: 'Category updated successfully'
        else
            render :edit
        end
    end

    def destroy
        @category.destroy
        redirect_to categories_path, notice: 'Category deleted successfully'
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end

    def admin_only
        redirect_to root_path, alert: 'Access denied' unless current_user.admin?
    end
end
