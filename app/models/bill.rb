class Bill < ActiveRecord::Base
  has_many :bill_articles
  has_many :sale_transactions

  belongs_to :client, :class_name => 'Client'

  default_scope { order('created_at DESC') }
end
