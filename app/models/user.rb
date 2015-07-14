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

  def add_collaborator(user)
    collaboration = Collaborator.where(wiki: @wiki, user: self).first
    if collaboration
      return true
    else
      return false
    end 
  end 

  def downgrade_wikis
    the_wikis = Wiki.where(user_id: self.id, private: true)
    the_wikis.each do |wiki|
      wiki.update_attributes(private: false)
    end
  end

end
