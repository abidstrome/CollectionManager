class UsersController < ApplicationController
    before_action :authenticate_user!
    #before_action :set_user, only: [:show]

    def show
        @user = User.find(params[:id])
        authorize @user

        @collections = if @user== current_user
                        @user.collections
                       else
                        policy_scope(Collection)
                       end
                       

    end

    private

    # def set_user
    #     @user = User.find(params[:id])
    # end

end
