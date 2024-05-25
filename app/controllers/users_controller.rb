class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def show
        authorize @user
        @collections = @user.collections
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

end
