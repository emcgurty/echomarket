class CommunityMemberController < ApplicationController
  def advise
    session[:notice] = ''
    session[:background] = true
    if params[:id].blank?
      @community_members = CommunityMembers.new()

    else
      session[:community_id] = params[:id]
      @community_members = CommunityMembers.find(:all)

    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def m_list
    session[:notice] = ''
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
        else
         format.html { redirect_to :action=>'advise' , :id => @community_members.community_id}
        end
      
      else
        format.html { render action: "new" }

      end
    end
  end

 # POST /community_members
  # POST /community_members.json
  def add

    @community_members = CommunityMembers.new(params[:community_members])

    respond_to do |format|
      if @community_members.save
        format.html { redirect_to :action=>'edit'}

      else
        format.html { render action: "new" }

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
        format.html { redirect_to :action=>'advise' , :id => @community_members.community_id}
      else
        format.html { render action: "new" }

      end
    end
  end

  # POST /community_members
  # POST /community_members.json
  def update_row
    puts "UPdate Row"
    puts     params[:id]
    puts "params"
    puts params[:community_members].to_yaml
    @cm = CommunityMembers.find(params[:id])
    @cm.update_attributes(params[:community_members])
    @cm_saved = @cm.save
    puts "cm saved?"
    puts @cm_saved
    
    respond_to do |format|
      if @cm_saved
        if params[:view] == 'm_list'
          format.html { redirect_to :action=>'m_list'}
        else
          format.html { redirect_to :action=>'advise' , :id => session[:community_id]}
        end    
      else
        format.html { render action: "new" }

      end
    end
  end

  # PUT /community_members/1
  # PUT /community_members/1.json
  def update
    @community_member = CommunityMember.find(params[:id])

    respond_to do |format|
      if @community_member.update_attributes(params[:community_member])
        format.html { redirect_to @community_member, notice: 'Community member was successfully updated.' }

      else
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
