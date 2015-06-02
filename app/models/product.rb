class Product < ActiveRecord::Base

  has_attached_file :photo, :styles => { :small => "108x108>" },
    :url  => "/assets/products/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']

  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :stock_amount, :presence => true
  validates :sales_amount, :presence => true

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
