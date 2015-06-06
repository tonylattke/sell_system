class Client < ActiveRecord::Base
  validates :dni, :presence => true, :length => { :minimum => 1 }
  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :subscription_date, :presence => true
  validates :balance, :presence => true

  def to_s
    return "#{@name}"
  end
  
  def self.search(search)
    if search
      where('dni ILIKE ? or name ILIKE ?', "%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
