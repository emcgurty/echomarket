class SearchController < ApplicationController
  
  def item_search
    
    # session[:notice] = ''
   session[:background] = true
    if params[:id]
      @search = Searches.find(params[:id].to_i)
      unless @search.blank?
    @s_get_items = @search.get_items
    if @s_get_items.blank?
                
      if params[:which].to_i == 1
        redirect_to :controller => "lender", :action => 'rapid_lender_offering'
      elsif params[:which].to_i == 2
        redirect_to :controller => "borrower", :action => 'rapid_borrower_seeking'
      end  
    else
      @search
    end    
   end
      
    else
      @search = Searches.new
    end
    
    
  end
  
  def create
    @search = Searches.new(params[:searches])
    @save_search = @search.save(:validate => false)
    session[:rapid_id] = @search.id
    redirect_to :action => :item_search, :id => @search.id,  :which => @search.lender_or_borrower
    
  end
  
  def index
      
  end
  
end
