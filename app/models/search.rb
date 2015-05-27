class Search < ActiveRecord::Base

##  Thanks to Ryan Bates RailsCast 111
require 'date'
   
attr_accessor   :found_zip_codes
attr_accessible :start_date, :end_date, :keyword, :postal_code, :category_id, :lender_or_borrower, :is_community, :user_id , :zip_code_radius, :remote_ip  
    
    
  def get_items
    
    if lender_or_borrower == 2
    @borrowers ||= find_borrowers
    elsif lender_or_borrower == 1
    @lenders ||= find_lenders
    end  
  end

   

private

def find_borrowers
puts postal_code
puts postal_code.present?
  if postal_code.present?
    borrowers = Borrower.joins(:addresses).where([getUserType, conditions].join(' AND ') )
  else
    borrowers = Borrower.find(:all, :readonly, :conditions =>  [getUserType, conditions].join(' AND ') )
  end    
  

end

def find_lenders

  if postal_code.present?
    lenders = Lender.joins(:addresses).where([getUserType, conditions].join(' AND ') )
  else
    lenders = Lender.find(:all, :readonly, :conditions =>  [getUserType, conditions].join(' AND ') )
  end  
end


def getUserType
  
  if is_community == 1  
       ["user_id = '#{user_id}' "]
  else
       ["is_active = 1 AND is_community = 0 "]
  end

end

def description_conditions
   [" item_description like '%#{keyword}%'"] if keyword.present?
end

def model_conditions
   [" item_model like '%#{keyword}%'"] if keyword.present?
end


def category_conditions
  ["category_id = #{category_id.to_i}"] if category_id.present?
end

def date_conditions
  if end_date.present?
  @date_plus_one = end_date + 1.days
  end
   
  ["( date_created > '#{start_date}' AND date_created < '#{@date_plus_one.to_s}' )"] if start_date.present? and end_date.present?
 
end

def postalcode_conditions
if found_zip_codes.present?
  ["postal_code IN '(#{found_zip_codes})' "]  
elsif postal_code.present? 
  ["postal_code like '#{postal_code}%' "]  
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
