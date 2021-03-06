class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: {minimum: 10 }, presence: true

  def authors
    self.users.map {|user| user.name}.join(", ")
  end

  def get_owner
    User.find(self.user_id).name
  end
  
# Use this with out policy scope
  # def self.visible_to(user)

  #   if user.present? && (user.admin? || user.premium?)
  #     return Wiki.all
  #   else
  #     return Wiki.where(private: false)
  #   end
  # end
end
