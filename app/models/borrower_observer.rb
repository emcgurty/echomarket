class BorrowerObserver < ActiveRecord::Observer
  
  observe :borrower

  def after_create(borrowers)
#    Notifier.signup_notification(lenders).deliver
  end

  def after_save(borrowers)

     
#    Notifier.new_borrower_record(lenders).deliver
    
  end

def after_update(borrowers)


#    Notifier.updated_borrower_record(lenders).deliver

  end



end
