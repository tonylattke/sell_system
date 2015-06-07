class Combo < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "108x108>", :original => "108x108>" },
    :url  => "/assets/combos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/combos/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']

  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :stock_amount, :presence => true
  validates :sales_amount, :presence => true

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

  default_scope { order('sales_amount DESC') }  
end
