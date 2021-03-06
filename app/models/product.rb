class Product < ActiveRecord::Base
  has_many :product_tags
  has_many :product_providers
  has_many :prices

  has_attached_file :photo, :styles => { :small => "108x108>", :original => "108x108>", :cropped_thumb => {:geometry => "108x108#", :jcrop => true} },
    :url  => "/assets/products/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

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
      where('name ILIKE ? and active=true and stock_amount > 0', "%#{search}%")
    else
      scoped
    end
  end

  def self.searchBestsellers()
    return where('active=true and stock_amount > 0')
  end

  default_scope { order('sales_amount DESC') }  
end