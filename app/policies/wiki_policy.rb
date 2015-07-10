class WikiPolicy < ApplicationPolicy
  

  def index?
    true
  end 

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end 

  class Scope
    attr_reader :user, :Scope

    def initializer(user, scope)
      @user = user
      @scope = scope
    end 

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all 
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end 
      else 
        all_wikis = scope.all 
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public || wiki.users.include?(user)
            wikis << wiki
          end 
        end 
      end 
      wikis
    end 
  end 
end
