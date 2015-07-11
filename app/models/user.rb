class User < ActiveRecord::Base
  has_many :collaborators
  has_many :wikis, through: :collaborators

  after_initialize :default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def admin?
    role == 'admin'
  end 
  
  def premium?
    role == 'premium'
  end 

  def default_role
    default_role ||= 'standard'   
  end  


end
