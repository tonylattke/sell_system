class Provider < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 1 }

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
