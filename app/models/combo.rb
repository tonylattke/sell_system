class Combo < ActiveRecord::Base
  has_many :prices
  has_many :combo_products
  
  has_attached_file :photo, :styles => { :small => "108x108>", :original => "108x108>", :cropped_thumb => {:geometry => "108x108#", :jcrop => true} },
    :url  => "/assets/combos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/combos/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']

  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :sales_amount, :presence => true

  def to_s
    return "#{@name}"
  end

  def self.search(search)
    if search
      where('name ILIKE ? and active=true', "%#{search}%")
    else
      scoped
    end
  end

  def self.searchBestsellers()
    return where('active=true')
  end

  default_scope { order('sales_amount DESC') }  
end
