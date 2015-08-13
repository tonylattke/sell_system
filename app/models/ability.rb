class Ability

  include CanCan::Ability

  def initialize(user)
    can :read, :all                   # Permite leer toda la información
    if user && user.admin?
      can :access, :rails_admin       # Sólo el admin accede a Rails Admin
      can :dashboard                  # Permite ver el dashboard
      can :manage, :all               # Permite al administrador hacer todo (actualizar, eliminar..)
    end
  end

end