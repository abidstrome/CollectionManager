class HomeController < ApplicationController
    def index
        @collections = policy_scope(Collection)
        @latest_items = Item.order(created_at: :desc).limit(5)
        @top_collections = Collection.joins(:items).group('collections.id').order('COUNT(items.id) DESC').limit(5)
        @tags = ActsAsTaggableOn::Tag.most_used(10)
          
    end

    def search
        @query = params[:query]
        if @query.present?
            @items = Item.where('name ILIKE ? OR tags ILIKE ?', "%#{@query}%", "%#{@query}%")
        else
            @items = Item.none
         end

       @items = policy_scope(@items)
    end
    
    
end