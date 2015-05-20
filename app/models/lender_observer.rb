class LenderObserver < ActiveRecord::Observer
  
  observe :lender

  def after_create(lenders)
#    Notifier.signup_notification(lenders).deliver
  end

  def after_save(lenders)

     
#    Notifier.new_lender_record(lenders).deliver
    
  end

def after_update(lenders)


#    Notifier.updated_lender_record(lenders).deliver

  end



end
