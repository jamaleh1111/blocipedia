class Wiki < ActiveRecord::Base
  belongs_to :user

  def self.visible_to(user)

    if user.present? && (user.admin? || user.premium?)
      return Wiki.all
    else
      return Wiki.where(private: false)
    end
  end
end
