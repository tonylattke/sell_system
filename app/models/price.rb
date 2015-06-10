class Price < ActiveRecord::Base
  validates :value, :presence => true
  validates :type_option, :presence => true
  validates :creation_date, :presence => true
  
  def to_s
    return "#{@type_option} #{@value} #{@creation_date}"
  end

  default_scope { order('creation_date DESC') }  
end
