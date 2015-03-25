class CommunityMemberController < ApplicationController
 
  def m_list
      session[:notice] = ''
      session[:background] = true
      @community_members = CommunityMembers.find(:all, :conditions => ["community_id = ?", session[:community_id]])
  end

  # POST /community_members
  # POST /community_members.json
  def create

    @community_members = CommunityMembers.new(params[:community_members])
    
    respond_to do |format|
      
      if @community_members.save && @community_members.errors.empty? 
        if params[:commit] == 'Add'
          format.html { redirect_to :action=>'m_list' }
       
        end
      
      else
        format.html { render action: "new" }

      end
    end
  end

 # POST /community_members
  # POST /community_members.json
  def add
  #Parameters: {"utf8"=>"√", "authenticity_token"=>"8b3H95PyT131qgJxSIR9+19VxS9A4MyV579W9KywLvU=", "community_members"=>{"first_name_h"=>"Liz", "mi_h"=>"m", "last_name_h"=>"mcgurty", "alias_h"=>"", "first_name"=>"d", "mi"=
  #>"m", "last_name"=>"l", "alias"=>"", "is_creator"=>"0"}, "commit"=>"Add", "view"=>"m_list"}
    myaddhash = Hash.new
    myaddhash = [:community_id => session[:community_id], :first_name => params[:community_members][:first_name], :mi=>params[:community_members][:mi], :last_name => params[:community_members][:last_name], :alias=> params[:community_members][:alias]]

    @community_members = CommunityMembers.new(myaddhash[0])

    respond_to do |format|
      if @community_members.save
        format.html { redirect_to :action=>'m_list'}

      else
        session[:notice]  = "Echo Market error in adding new community mmber."
        format.html { redirect_to home_items_listing_url }

      end
    end
  end
  
  # POST /community_members
  # POST /community_members.json
  def remove

    @community_members = CommunityMembers.find(params[:id])
    @community_members.destroy
    respond_to do |format|
      if @community_members.save
        format.html { redirect_to :action=>'m_list' , :id => @community_members.community_id}
      else
        session[:notice] = 'Echo Market application error in removing a member'
        format.html { redirect home_items_listin_url}

      end
    end
  end

  
  # PUT /community_members/1
  # PUT /community_members/1.json :  :       /*  'community_member/update_row/(:f)/(:m)/(:la)/(:al)/(:ci)' */
  def update_row
    @community_member = CommunityMembers.find(params[:ci])
    unless @community_member.blank?
      myupdatehash = Hash.new
      myupdatehash = [:first_name => params[:fi], :mi => params[:mi],:last_name => params[:la], :alias => params[:al], :is_creator => 0, :date_updated=> Time.now]
    end

    respond_to do |format|
      if @community_member.update_attributes(myupdatehash[0])
        format.html { redirect_to :action=>'m_list' , :id => @community_members.community_id}
      else
        session[:notice] = "The Echo Market Application encoutered an error in updating you selected Community Member row."        
        format.html { render action: "edit" }
      end
    end
  end


  # DELETE /community_members/1
  # DELETE /community_members/1.json
  def destroy
    @community_member = CommunityMembers.find(params[:id])
    @community_member.destroy

    respond_to do |format|
      format.html { redirect_to community_members_url }

    end
  end
end
