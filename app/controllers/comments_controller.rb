class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_collection
    before_action :set_item
    

    def create
        
        @comment = @item.comments.build(comment_params)
        @comment.user = current_user
        authorize @comment

        if @comment.save
            redirect_to collection_item_path(@collection, @item), notice: 'Comment added.'

        else
            redirect_to collection_item_path(@collection, @item), alert: 'Unable to add comment.'

        end
    end

    def destroy
       
        @comment = @item.comments.find(params[:id])
        authorize @comment
        @comment.destroy
        redirect_to collection_item_path(@collection, @item), notice: 'Comment deleted.'
    end

    private

    def set_collection
        @collection = Collection.find(params[:collection_id])
    end

    def set_item
        @item = @collection.items.find(params[:item_id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

end
