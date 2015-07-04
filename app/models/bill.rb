class Bill < ActiveRecord::Base
  has_many :bill_articles

  belongs_to :client, :class_name => 'Client'

  default_scope { order('created_at DESC') }  
end
