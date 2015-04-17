class SearchController < ApplicationController
  
  def item_search
    
    # session[:notice] = ''
    session[:background] = true
 if params[:id]
      @search = Searches.find(params[:id].to_i)
      
    else
      @search = Searches.new
    end    
   
  end
  
  def create
    @search = Searches.new(params[:searches])
    @save_search = @search.save(:validate => false)
    redirect_to :action => :item_search, :id => @search.id 
  end
  
  def index
      
  end
  
end
