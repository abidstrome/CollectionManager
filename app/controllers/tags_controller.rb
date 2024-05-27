class TagsController < ApplicationController
    def index
        tags = ActsAsTaggableOn::Tag.where("name LIKE ?", "%#{params[:q]}%")
        render json: tags.map(&:name)
    end
end