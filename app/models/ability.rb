class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :create, Movie
      can :read, Movie 
      can :update, Movie
      can :destroy, Movie  
    elsif user.role == 'user'
      can :create, Review
      can :read, Review
      can [:update,:destroy], Review, user = user
      can :read, Movie
    end
  end
end
