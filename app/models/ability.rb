class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all # allow admins to do anything
      else
        # ensure users cannot assign objects to other users
        # https://github.com/sferik/rails_admin/wiki/How-to-set-current_user-to-the-field
        can :create, [Form, Output], owner_id: user.id if user
        can :manage, [Form, Output], :owner_id => user.id
        can :read, OutputJob, :form => {:owner_id => user.id}
        can :read, Submission, :form => {:owner_id => user.id}
        can :manage, User, :id => user.id
      end
    else
      can :create, Submission
    end
  end
end
