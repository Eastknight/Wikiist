class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.private != true || record.user == user || record.collaborating_users.include?(user) || (user && user.role == 'admin')
  end

  def mine?
    user.present?
  end
end