class Address < ActiveRecord::Base
	has_many :locatables
	has_many :owners, :through => :locatables
	has_many :transactions, :through => :locatables, 
                                      :source => :owner,
                                      :source-type => "Transaction"

	def kind
		self.locatables.where(:owner_type => "User").last.kind
	end	

	geocoded_by :full_address
	after_validation :geocode, :if => :full_address_changed?

	def full_address
	  [street, city, state, zip, country].compact.join(', ') # => "street, city, state, zip, country"
  end

  private
  
  def full_address_changed?
		street_changed? || city_changed? || state_changed? || zip_changed? || country_changed?
  end
end