class Locatable < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :address

  accepts_nested_attributes_for :address
end
