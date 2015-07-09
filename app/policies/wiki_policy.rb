class WikiPolicy < ApplicationPolicy
  

  def index?
    true
  end 

  def destroy?
    user.present? && (record.user == user || user.moderator?)
  end 
end
