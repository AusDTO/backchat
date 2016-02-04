class Ability
  include CanCan::Ability
  def initialize(user)
    if user
      can :access, :rails_admin       # allow all users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      if user.admin?
        can :manage, :all             # allow admins to do anything
      else
        # ensure users cannot assign objects to other users
        # https://github.com/sferik/rails_admin/wiki/How-to-set-current_user-to-the-field
        can :create, [Form, Output], owner_id: user.id if user
        can :manage, [Form, Output], :owner_id => user.id
        can :read, Submission, :form => { :owner_id => user.id }
      end
    end
  end
end
