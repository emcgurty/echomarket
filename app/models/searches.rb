class Searches < ActiveRecord::Base

##  Thanks to Ryan Bates RailsCast 111

   
   attr_accessible :start_date, :end_date, :keyword, :postal_code, :category_id, :lender_or_borrower, :is_community, :user_id
    
    
  def get_items
    
    if lender_or_borrower == 2
    @borrowers ||= find_borrowers
    elsif lender_or_borrower == 1
    @lenders ||= find_lenders
    end  
  end

private

def find_borrowers

  borrowers = Borrowers.find(:all, :readonly, :conditions => getUserType + conditions)
  

end

def find_lenders

  lenders = Lenders.find(:all, :readonly, :conditions => conditions)

end


def getUserType
  
  if is_community == 1  
       ["user_id = ? AND ", "#{user_id}"]
  else
       ["is_active = 1 AND is_community = 0 AND "]
  end

end

def keyword_conditions
   ["item_description like ?  OR item_model like ?", "%#{keyword}%",  "%#{keyword}%"] if keyword.present?
end

def category_conditions
  ["item_category_id = #{category_id.to_i}"] if category_id.present?
end

def date_conditions
    ["date_created >= ?", "#{start_date}"] if start_date.present? and !end_date.present?
    ["date_created <= ?", "#{end_date}"] if !start_date.present? and end_date.present?
    ["( date_created >= ? AND date_created <= ? )", "#{start_date}", "#{end_date}"] if start_date.present? and end_date.present?
end

def postalcode_conditions
  ["postal_code like ?", "#{postal_code}%"]  if postal_code.present?
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
