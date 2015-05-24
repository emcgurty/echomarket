class AdvertiserController < ApplicationController
  def new
    @advertiser = Advertiser.new

    respond_to do |f|
      f.html
    end

  end

  def create
    session[:notice] = ''

    respond_to do |f|

      unless params[:advertiser].blank?
        @req = params[:advertiser]
        @hold_picture_file = params[:item_image_upload]
        @advertiser = Advertiser.new(
          :title => @req[:title].to_s,
          :description=> @req[:description].to_s,
          :advertiser_email=> @req[:advertiser_email].to_s,
          :advertiser_url=> @req[:advertiser_url].to_s,
          :category_id => @req[:category_id],
          :category_other=> @req[:category_other],
          :is_active => 1,
          :is_activated => 0,
          :date_created => Time.now,
          :approved => 0,
          :remote_ip => @req[:remote_ip],
          :advertiser_logo => "NA"
)
       
       
        if  @advertiser.save(:validate => true) && @advertiser.errors.empty? 
          unless @hold_picture_file.blank?
            @img =  Itemimage.new(:advertiser_id => @advertiser.advertiser_id,
              :borrower_id => '',  :lender_id => '',
              :item_image_upload=> @hold_picture_file,
              :item_image_caption=> '',
              :date_created =>Time.now,
              :is_active => 1)
            @img.save

            @mynewhash =  Hash.new
            @mynewhash = [:advertiser_logo => @img.item_image_id.to_s]
          @advertiser.update_attributes(@mynewhash[0])
          end

          Notifier.notify_advertiser(@advertiser).deliver
          session[:notice] = "Your Advertisement record has been saved, and validation email has been sent to you at #{@advertiser.advertiser_email}."
          f.html {redirect_to  home_items_listing_url}

        else
          f.html { render :action => 'new'}
        end
      end
      
    end
  end

  def activate
    if params[:id]
      @ad = Advertiser.find(params[:id])
      @myupdatehash = [:is_active => 1, :is_activated => 1]
      if @ad.update_attributes(@myupdatehash[0])
        session[:notice] = "Your Advertisement account record has been activated.  Thanks so much for your participation...."
        redirect_to  :controller => "home", :action => 'items_listing'
      else
        session[:notice] = "For some reason Echo Market was not able to activate your Advertisement account record.  Please try again, or kindly contact us."
        redirect_to  :controller => "home", :action => 'items_listing'
      end
    end

  end

end
