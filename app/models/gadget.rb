class Gadget < ActiveRecord::Base
  has_many :parts

  def complete_weight
    "#{weight} #{weight_unit}"
  end
  
  def verbose_id
    "gadget_#{id}_#{idified_name}"
  end

  def idified_name
    name.strip.downcase.gsub(/\s+/," ").gsub(" ","_")
  end
end
