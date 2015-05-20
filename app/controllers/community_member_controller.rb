class CommunityMemberController < ApplicationController
 
  def m_list
      session[:background] = true
      @community_members = CommunityMember.find(:all, :conditions => ["community_id = ?", session[:community_id]])
  end

  # POST /community_members
  # POST /community_members.json
  def create

    @community_members = CommunityMember.new(params[:community_members])
    
    respond_to do |format|
      
      if @community_members.save && @community_members.errors.empty? 
        if params[:commit] == 'Add'
          format.html { redirect_to :action=>'m_list' }
       
        end
      
      else
        format.html { render :action => "new" }

      end
    end
  end

 # POST /community_members
  # POST /community_members.json
  def add
  #Parameters: {"utf8"=>"?", "authenticity_token"=>"8b3H95PyT131qgJxSIR9+19VxS9A4MyV579W9KywLvU=", "community_members"=>{"first_name_h"=>"Liz", "mi_h"=>"m", "last_name_h"=>"mcgurty", "alias_h"=>"", "first_name"=>"d", "mi"=
  #>"m", "last_name"=>"l", "alias"=>"", "is_creator"=>"0"}, "commit"=>"Add", "view"=>"m_list"}
    myaddhash = Hash.new
    myaddhash = [:community_id => session[:community_id], :first_name => params[:community_members][:first_name], 
    :mi=>params[:community_members][:mi], :last_name => params[:community_members][:last_name], 
    :alias=> params[:community_members][:alias], :is_creator => 0, :remote_ip => params[:community_members][:remote_ip]]

    @community_members = CommunityMember.new(myaddhash[0])

    respond_to do |format|
      if @community_members.save
        format.html { redirect_to :action=>'m_list'}

      else
        session[:notice]  = "Echo Market error in adding new community member."
        format.html { redirect_to :action=>'m_list'}
      end
    end
  end
  
  # POST /community_members
  # POST /community_members.json
  def remove
    
    begin
      CommunityMember.delete(params[:id])
      redirect_to :action=>'m_list'
    rescue 
        session[:notice] = 'Echo Market application error in removing your selected member.'
        redirect_to :action=>'m_list'
    end
    
  end

  
  # PUT /community_members/1
  # PUT /community_members/1.json :  :       /*  /*    match 'community_member/update_row/(:fi)/(:m)/(:la)/(:al)/(:ci)/(:com_id)/(:is_c)'=> "community_member#update_row", :as=> :community_member_update_row */ */
  def update_row
    @community_member = CommunityMember.find(params[:ci])
    
    unless @community_member.blank?
      myupdatehash = Hash.new
       if (params[:is_c] == '1')
            my_alias_str = params[:fi] + (params[:m].blank? ? "" : params[:m]) + params[:la]
           myupdatehash = [:first_name => params[:fi], :mi => params[:m],:last_name => params[:la], :alias => my_alias_str, :date_updated=> Time.now]
       else
           myupdatehash = [:first_name => params[:fi], :mi => params[:m],:last_name => params[:la], :alias => params[:al], :date_updated=> Time.now]
       end      
    end

    
      if @community_member.update_attributes(myupdatehash[0])
        if (params[:is_c] == '1')
          @c = Communities.find(params[:com_id])
          @c.first_name = params[:fi]
          @c.mi = params[:m]
          @c.last_name = params[:la]
          @c.date_updated = Time.now
          @c.save(:validate => false)
                 
        end
        redirect_to :action=>'m_list' , :id => params[:ci]
      else
        session[:notice] = "The Echo Market Application encountered an error in updating your selected Community Member row."        
        redirect_to :action=>'m_list' , :id => params[:ci]
      end
    
 
 
  end


  # DELETE /community_members/1
  # DELETE /community_members/1.json
  def destroy
    @community_member = CommunityMember.find(params[:id])
    @community_member.destroy

    respond_to do |format|
      format.html { redirect_to community_members_url }

    end
  end
end
