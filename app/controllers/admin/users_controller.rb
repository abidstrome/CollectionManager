module Admin
    class UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :require_admin!

        def index
            @users = User.all
        end

        def block
            user= User.find(params[:id])
            user.update(blocked: true)
            redirect_to admin_users_path, notice: "User blocked."
        end

        def unblock
            user = User.find(params[:id])
            user.update(blocked: false)
            redirect_to admin_users_path, notice: "User unblocked."
        end

        def make_admin
            user = User.find(params[:id])
            user.update(role: :admin)
            redirect_to admin_users_path, notice: "Added to admin."
        end

        def remove_admin
            user = User.find(params[:id])
            if user == current_user
                user.update(role: :user)
                sign_out current_user
                redirect_to root_path, notice: "You have removed your own admin rights."
            else
                user.update(role: :user)
                redirect_to admin_users_path, notice: "Removed from admin"
            end
        end

        def destroy
            user = User.find(params[:id])
            user.destroy
            redirect_to admin_users_path, notice: "User deleted."
        end

        private

        def require_admin!
            unless current_user.admin?
             redirect_to root_path, alert:"You are not authorized to access this page."
            end
        end
    end
end


