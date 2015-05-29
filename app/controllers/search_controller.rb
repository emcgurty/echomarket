class SearchController < ApplicationController
  def item_search

    ##session[:notice] = ''
    session[:background] = true
    if params[:id]
      @search = Search.find(params[:id].to_i)

      if session[:community_name].blank?
        unless @search.blank?
          @s_get_items = @search.get_items
          if @s_get_items.blank?
            if params[:which].to_i == 2
              redirect_to :controller => "lender", :action => 'rapid_lender_offering'
            elsif params[:which].to_i == 1
              redirect_to :controller => "borrower", :action => 'rapid_borrower_seeking'
            end
          end
        end
      else
      @search
      end
    else
      @search = Search.new
    end
    @search
  end

  def create
    @search = Search.new(params[:search])
    @save_search = @search.save(:validate => false)
    session[:rapid_id] = @search.id
    redirect_to :action => :item_search, :id => @search.id,  :which => @search.lender_or_borrower

  end

  def index

  end

end

