class BorrowerObserver < ActiveRecord::Observer
  
  observe :borrower

  def after_create(borrower)
#    Notifier.signup_notification(borrowers).deliver
  end

  def after_save(borrower)

     
#    Notifier.new_borrower_record(borrowers).deliver
    
  end

def after_update(borrower)


#    Notifier.updated_borrower_record(borrowers).deliver

  end



end
