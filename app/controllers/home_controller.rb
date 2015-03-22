class HomeController < ApplicationController
  #caches_page :show

 
  def item_search
    session[:notice] = ''
    session[:background] = true
    session[:item_search_query]  =''
    if request.post?
      session[:on_search_open] = false
      showor = false
      search_product_string = (params[:search_product].blank? ? "" : "Product: " + params[:search_product])
      search_postal_code_string = (params[:search_postal_code].blank? ? "" : (search_product_string.blank? ? "Postal Code: " +  params[:search_postal_code]:
            " and/or Postal Code: " +  params[:search_postal_code]))
      session[:search_params]= search_product_string + search_postal_code_string
      build_conditions_string = ""
      @item_search_query = ""
     
      if params[:itemsearch] == '1'

        unless params[:search_product].blank?
          split_query_string = params[:search_product].split(" ").map!(&:strip)    ## /\s/
          @search_cats_array = Array.new
          @search_conditions_array = Array.new
          @search_items_array = Array.new

          split_query_string.each do |sqs|
            get_search_value = "%" + sqs.upcase + "%"
            @search_images = Itemimages.find(:all,:select => 'lender_item_id',  :readonly => true, :conditions => ["UPPER(image_file_name) like ? OR UPPER(item_image_caption) like ?", get_search_value, get_search_value])
            @search_conditions = Itemconditions.find(:all, :select=> 'item_conditions_id', :readonly => true, :conditions => ["UPPER(conditions) like ?", get_search_value])
            @search_cats = Categories.find(:all, :select=> 'category_id', :readonly => true, :conditions => ["UPPER(category_type) like ?", get_search_value])
            @search_items = Lenders.find(:all, :select=> 'lender_item_id',:readonly => true, :conditions => ["UPPER(item_model) like ?
	              OR UPPER(item_description) like ? AND is_active = 1 and is_saved = 1", get_search_value, get_search_value])


            unless @search_items.blank?
              @search_items.each do |si|
                @search_items_array << "'" + si.lender_item_id.to_s + "'"
              end
              unless @search_items_array.blank?
                @search_items_array.uniq!
              end
            end

            unless @search_images.blank?
              @search_images.each do |si|
                @search_items_array <<  "'" + si.lender_item_id.to_s  + "'"
              end
              unless @search_items_array.blank?
                @search_items_array.uniq!
              end
            end

            unless @search_conditions.blank?
              @search_conditions.each do |si|
                @search_conditions_array << si.item_conditions_id.to_i
              end
              unless @search_conditions_array.blank?
                @search_conditions_array.uniq!
              end
            end

            unless @search_cats.blank?
              @search_cats.each do |si|
                @search_cats_array << si.category_id.to_i
              end
              unless @search_cats_array.blank?
                @search_cats_array.uniq!
              end
            end
          end

          ## user_id IN (?)", [1,2,3]
          unless ( @search_cats_array.blank? &&  @search_conditions_array.blank? && @search_items_array.blank?)

            build_conditions_string = ""
            unless @search_cats_array.blank?
              if @search_cats_array.length > 1
                build_conditions_string = build_conditions_string  + " item_category_id IN (#{@search_cats_array.join(",")}) "
              else
                build_conditions_string = build_conditions_string  + " item_category_id = #{@search_cats_array[0]} "
              end
              showor = true
            end

            unless @search_conditions_array.blank?
              if @search_conditions_array.length> 1
                build_conditions_string =  build_conditions_string  + (showor ? " OR item_condition_id IN (#{@search_conditions_array.join(",")}) " : " item_condition_id IN (#{@search_conditions_array.join(",")}) ")
              else
                build_conditions_string =  build_conditions_string  + (showor ? " OR item_condition_id = #{@search_conditions_array[0]} " : " item_condition_id = #{@search_conditions_array[0]} ")
              end

              showor = true
            end

            unless @search_items_array.blank?
              if @search_items_array.length > 1
                build_conditions_string = build_conditions_string  + (showor ? " OR lender_item_id IN (#{@search_items_array.join(",")} )" : " lender_item_id IN (#{@search_items_array.join(",")}) ")
              else
                build_conditions_string = build_conditions_string  + (showor ? " OR lender_item_id = '#{@search_items_array[0].to_s}' " : " lender_item_id = '#{@search_items_array[0].to_s}' ")
              end
            end

            unless build_conditions_string.blank?
              build_conditions_string  = build_conditions_string  + "  "
            end
          end

        end
        is_active_is_save = " AND is_active = 1 AND is_saved = 1 "
        if build_conditions_string.blank?
          unless params[:search_postal_code].blank?
            postal_code_string = params[:search_postal_code].gsub("*", "")
            build_conditions_string = " postal_code like '#{postal_code_string}%'"

            @item_search_query = Lenders.find(:all, :readonly => true, :conditions => build_conditions_string + is_active_is_save )
            session[:item_search_query] = "lender"
          end
        else
          replace_square_brackets = build_conditions_string.gsub("[", "(")
          replace_square_brackets =  replace_square_brackets.gsub("]", ")")
          unless params[:search_postal_code].blank?
            postal_code_string = params[:search_postal_code].gsub("*", "")
            replace_square_brackets =  "(" + replace_square_brackets + " OR postal_code like '#{postal_code_string}%' )"
            
          end
          @item_search_query = Lenders.find(:all, :readonly => true, :conditions => replace_square_brackets +  is_active_is_save).uniq
          session[:item_search_query] = "lender"
        end

          
      elsif params[:itemsearch] == '2'

        unless params[:search_product].blank?
          split_query_string = params[:search_product].split(" ").map!(&:strip)    ## /\s/
          @search_cats_array = Array.new
          @search_conditions_array = Array.new
          @search_items_array = Array.new

          split_query_string.each do |sqs|
            get_search_value = "%" + sqs.upcase + "%"
            @search_images = Itemimages.find(:all,:select => 'borrower_item_id',  :readonly => true, :conditions => ["UPPER(image_file_name) like ? OR UPPER(item_image_caption) like ?", get_search_value, get_search_value])
            @search_conditions = Itemconditions.find(:all, :select=> 'item_conditions_id', :readonly => true, :conditions => ["UPPER(conditions) like ?", get_search_value])
            @search_cats = Categories.find(:all, :select=> 'category_id', :readonly => true, :conditions => ["UPPER(category_type) like ?", get_search_value])
            @search_items = Borrowers.find(:all, :select=> 'borrower_item_id',:readonly => true, :conditions => ["UPPER(item_model) like ?
	              OR UPPER(item_description) like ? AND is_active = 1 and is_saved = 1", get_search_value, get_search_value])

            unless @search_items.blank?
              @search_items.each do |si|
                @search_items_array << "'" + si.borrower_item_id.to_s  + "'"
              end
              unless @search_items_array.blank?
                @search_items_array.uniq!
              end
            end

            unless @search_images.blank?
              @search_images.each do |si|
                @search_items_array << "'" + si.borrower_item_id.to_s + "'"

              end
              unless @search_items_array.blank?
                @search_items_array.uniq!
              end
            end

            unless @search_conditions.blank?
              @search_conditions.each do |si|
                @search_conditions_array << si.item_conditions_id.to_i
              end
              unless @search_conditions_array.blank?
                @search_conditions_array.uniq!
              end
            end

            unless @search_cats.blank?
              @search_cats.each do |si|
                @search_cats_array << si.category_id.to_i
              end
              unless @search_cats_array.blank?
                @search_cats_array.uniq!
              end
            end
          end

          ## user_id IN (?)", [1,2,3]
          unless ( @search_cats_array.blank? && @search_conditions_array.blank? && @search_items_array.blank?)

            build_conditions_string = ""
            unless @search_cats_array.blank?
              if @search_cats_array.length> 1
                build_conditions_string = build_conditions_string  + " item_category_id IN (#{@search_cats_array.join(",")}) "
              else
                build_conditions_string = build_conditions_string  + " item_category_id = #{@search_cats_array[0]} "
              end
              showor = true
            end

            unless @search_images_array.blank?
              if @search_images_array.length> 1
                build_conditions_string = build_conditions_string  + (showor ? " OR item_image_id IN (#{@search_images_array.join(",")}) " : " item_image_id IN (#{@search_images_array.join(",")}) ")
              else
                build_conditions_string = build_conditions_string  + (showor ? " OR item_image_id = '#{@search_images_array[0].to_s}' " : " item_image_id = '#{@search_images_array[0].to_s}' ")
              end
              showor = true
            end

            unless @search_conditions_array.blank?
              if @search_conditions_array.length> 1
                build_conditions_string =  build_conditions_string  + (showor ? " OR item_condition_id IN (#{@search_conditions_array.join(",")} )" : " item_condition_id 
           IN (#{@search_conditions_array.join(",")} )")
              else
                build_conditions_string =  build_conditions_string  + (showor ? " OR item_condition_id = #{@search_conditions_array[0]} " : " item_condition_id = #{@search_conditions_array[0]} ")
              end

              showor = true
            end

            unless @search_items_array.blank?
              if @search_items_array.length> 1
                build_conditions_string = build_conditions_string  + (showor ? " OR borrower_item_id IN (#{@search_items_array.join(",")} )" : " borrower_item_id IN (#{@search_items_array.join(",")} )")
              else
                build_conditions_string = build_conditions_string  + (showor ? " OR borrower_item_id = '#{@search_items_array[0].to_s}' " : " borrower_item_id = '#{@search_items_array[0].to_s}' ")
              end
            end

            unless build_conditions_string.blank?
              build_conditions_string  = build_conditions_string  + "  "
            end
          end

        end
        is_active_is_save = " AND is_active = 1 AND is_saved = 1 "
        if build_conditions_string.blank?
          unless params[:search_postal_code].blank?
            postal_code_string = params[:search_postal_code].gsub("*", "")
            build_conditions_string = " postal_code like '#{postal_code_string}%'"
            @item_search_query = Borrowers.find(:all, :readonly => true, :conditions => build_conditions_string  + is_active_is_save)
            session[:item_search_query] = "borrower"
          end
        else
          replace_square_brackets = build_conditions_string.gsub("[", "(")
          replace_square_brackets =  replace_square_brackets.gsub("]", ")")
          unless params[:search_postal_code].blank?
            postal_code_string = params[:search_postal_code].gsub("*", "")
            replace_square_brackets = "(" + replace_square_brackets + " OR postal_code like '#{postal_code_string}%' )"

          end
          @item_search_query = Borrowers.find(:all, :readonly => true, :conditions => replace_square_brackets + is_active_is_save).uniq
          session[:item_search_query] = "borrower"
        end
   
      end  ## if search value 1 or 2
    else
      session[:on_search_open] = true
      @item_search_query = ''
    end  ## if request.post

    if respond_to do |format|
        format.html
      end
    end ## end respond_to

  end  ## end def

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
