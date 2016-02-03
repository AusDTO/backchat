class Ability
  include CanCan::Ability

  def initialize(user)

    if user

      can :access, :rails_admin       # allow all users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      if user.admin?
        can :read, :all                 # allow admins to read everything
        can :manage, :all             # allow superadmins to do anything
      else
        can :manage, [Form, Output], :owner_id => user.id
        can :read, Submission, :form => { :owner_id => user.id }
        #can :manage, [Form, Output], :user => user.id
      end
    end
  end
end
