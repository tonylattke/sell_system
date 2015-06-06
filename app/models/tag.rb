class Tag < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 2 }

  def to_s
    return "#{@name}"
  end
  
  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
