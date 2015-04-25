class HomeController < ApplicationController


  def items_listing
   
    session[:background] = true
    respond_to do |format|
      format.html
    end
  end

  def show
    do_show

  end

  def about
    session[:notice] = ''
    session[:background] = true
  end
  
  def donate
    session[:background] = true
  end

  def legal
    session[:background] = true
  end

  def index
    reset_session
    session[:background] = false

  end

  def errorpage
  end

  def emailsuccess
  end

  private

  def do_show

    if (params[:id] == 'errorpage')
      render :action => 'errorpage'
    elsif (params[:id] == 'emailsuccess')
      render :action => 'emailsuccess'
    else
      #      session[:notice] = ''
      render :action=>'index'
    end


  end

end
