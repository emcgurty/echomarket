class AdvertiserController < ApplicationController
  
   def new
    if params[:advertiser]
      create  
    else
    @advertiser = Advertiser.new
    end
  end
  
   def create
   session[:notice] = ''
    unless params[:advertiser].blank?
        @req = params[:advertiser]
        @comp = Companies.new(
          :advertiser_name => @req[:advertiser_name].to_s,
          :description=> @req[:description].to_s,
          :advertiser_email=> @req[:advertiser_email].to_s,
          :advertiser_url=> @req[:advertiser_url].to_s,
          :advertiser_category_id => @req[:advertiser_category_id].to_i,
          :category_other=> @req[:category_other],
          :is_active => 1,
          :is_activated => 1,
          :date_created => Time.now,
          :approved => 1,
          :remote_ip => @req[:remote_ip]
              
 )
         if @comp.save(:validate => true) 
           session[:notice] = "Your Advertisement record has been saved, and validation email has been sent to you."
           redirect_to  :controller => "home", :action => 'items_listing' 
         end
         
     end       
 end
  
  
end
