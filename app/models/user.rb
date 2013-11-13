class User < ActiveRecord::Base
	has_many :locatables, :as => :owner
	has_many :addresses, :through => :locatables, :dependent => :destroy
	has_many :transactions
	has_many :vehicles, :through => :transactions

	accepts_nested_attributes_for :locatables, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
