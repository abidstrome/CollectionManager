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
        items_scope = policy_scope(Item)
        @items = items_scope.search_by_name_comments_and_tags(@query)
  
        collections_scope = policy_scope(Collection)
        @collections = collections_scope.search_by_name_or_description(@query)
      else
        @items = Item.none
        @collections = Collection.none
      end
    end
    
    
end