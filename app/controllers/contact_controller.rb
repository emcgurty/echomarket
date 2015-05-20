class ContactController < ApplicationController

  def contact_us
    session[:notice] = ""
    if (request.post?)
      @contact = Contact.new(params[:contacts])
      if @contact.save && @contact.errors.empty?
        message = @contact.comments
        recipient = params[:contacts][:email]
        begin Notifier.comments_received(recipient, message).deliver
          session[:notice] = "Thanks!  Your contact message has been received.  You should hear a response from the Echo Market shortly.  Otherwise, please continue to explore Echo Market"
          redirect_to :controller => "home", :action => 'items_listing'
          
        rescue Exception => e
          session[:notice] = "For some reason email delivery didn't work, please try again later.  Error message: #{e.message}"
          redirect_to :controller => "home", :action => 'items_listing'
          
        end


      end
    else
      @contact = Contact.new
    end

  end
end
