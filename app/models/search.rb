class Search < ActiveRecord::Base

##  Thanks to Ryan Bates RailsCast 111
require 'date'
   
attr_accessor   :found_zip_codes
attr_accessible :start_date, :end_date, :keyword, :postal_code, :category_id, :lender_or_borrower, :is_community, :user_id , :zip_code_radius, :remote_ip, :found_zip_codes  
    
    
  def get_items
    
    if lender_or_borrower == 2
    @borrower ||= find_borrowers
    elsif lender_or_borrower == 1
    @lender ||= find_lenders
    end  
  end

   

private


def find_borrowers
  
    borrowers = Borrower.joins(:addresses,:category,:item_condition).select(["borrowers.id AS id", "borrowers.item_description AS item_description", "borrowers.item_model AS item_model", "item_conditions.condition AS 'condition'",  "categories.category_type AS category_type", "addresses.postal_code AS postal_code", "addresses.address_type AS address_type"]).where([getUserType, conditions].join(' AND ') )

end

def find_lenders

   lenders = Lender.joins(:addresses,:category,:item_condition).select(["lenders.id AS id", "lenders.item_description AS item_description", "lenders.item_model as item_model", "item_conditions.condition AS 'condition'", "categories.category_type AS category_type", "addresses.postal_code AS postal_code", "addresses.address_type AS address_type"]).where([getUserType, conditions].join(' AND ') )
  
end


def getUserType
  
      if lender_or_borrower == 2
  
          if is_community == 1  
               [" borrowers.user_id = '#{user_id}' "]
          else
               [" borrowers.is_active = 1 AND borrowers.is_community = 0 "]
          end
  
     else
    
          if is_community == 1  
             [" lenders.user_id = '#{user_id}' "]
          else
             [" lenders.is_active = 1 AND lenders.is_community = 0 "]
          end
    
    end

end

def description_conditions
   
    if lender_or_borrower == 2
   [" borrowers.item_description like '%#{keyword}%'"] if keyword.present?
   else
     [" lenders.item_description like '%#{keyword}%'"] if keyword.present?
   end  
end

def model_conditions
   if lender_or_borrower == 2
   [" borrowers.item_model like '%#{keyword}%'"] if keyword.present?
   else
     [" lenders.item_model like '%#{keyword}%'"] if keyword.present?
   end  
end


def category_conditions
   if lender_or_borrower == 2
  [" borrowers.category_id = #{category_id.to_i}"] if category_id.present?
  else
    [" lenders.category_id = #{category_id.to_i}"] if category_id.present?
  end  
end

def date_conditions
  if end_date.present?
  @date_plus_one = end_date + 1.days
  end
     if lender_or_borrower == 2
  ["( borrowers.date_created > '#{start_date}' AND borrowers.date_created < '#{@date_plus_one.to_s}' )"] if start_date.present? and end_date.present?
  else
    ["( lenders.date_created > '#{start_date}' AND lenders.date_created < '#{@date_plus_one.to_s}' )"] if start_date.present? and end_date.present?
  end
 
end

def postalcode_conditions
if found_zip_codes.present?
     
      [" addresses.postal_code IN '(#{found_zip_codes})' "]
     
      
elsif postal_code.present? 
    
      [" addresses.postal_code like '#{postal_code}%' "]
      
end

end

def conditions
  [conditions_clauses.join(' OR '), *conditions_options]
end

def conditions_clauses
  conditions_parts.map { |condition| condition.first }
end

def conditions_options
  conditions_parts.map { |condition| condition[1..-1] }.flatten
end

def conditions_parts
  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
end

end
