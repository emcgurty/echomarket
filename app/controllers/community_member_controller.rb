class CommunityMemberController < ApplicationController
  def advise
     
    if params[:id].blank?
      @community_members = CommunityMembers.new()
      puts "NEW"
    else
      session[:community_id] = params[:id]
      @community_members = CommunityMembers.find(:all)
      puts "Find All"
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /community_members/1
  # GET /community_members/1.json
  def show
    @community_member = CommunityMembers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb

    end
  end

  # GET /community_members/new
  # GET /community_members/new.json
  def new
    @community_member = CommunityMembers.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /community_members/1/edit
  def edit
    
    @community_members = CommunityMembers.find(:all, :conditions => ["community_id = ?", session[:community_id]])
    if @community_members.blank?
      @community_members = CommunityMembers.new
    end
  end

  # POST /community_members
  # POST /community_members.json
  def create

    @community_members = CommunityMembers.new(params[:community_members])

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
        
    @cm = CommunityMembers.find(params[:id])
    @saved_cm = @cm.update_attributes(params[:community_members])
    respond_to do |format|
      if @saved_cm
        format.html { redirect_to :action=>'advise' , :id => session[:community_id]}
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
