class Bill < ActiveRecord::Base
  belongs_to :client, :class_name => 'Client'

  validates :client, :presence => true
end
