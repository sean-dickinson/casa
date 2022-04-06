class UserParameters < SimpleDelegator
  def initialize(params, key = :user)
    params =
      params.require(key).permit(
        :email,
        :casa_org_id,
        :display_name,
        :password,
        :active,
        :type, 
        address_attributes: [:street_address, :unit, :city, :state, :zip, :id] 
      )

    super(params)
  end

  def with_organization(organization)
    params[:casa_org_id] = organization.id
    self
  end

  def with_password(password)
    params[:password] = password
    self
  end

  def with_type(type)
    params[:type] = type
    self
  end

  def without_type
    params.delete(:type)
    self
  end

  def without_active
    params.delete(:active)
    self
  end

  def with_only(*keys)
    params.slice!(*keys)
    self
  end

  def without(*keys)
    params.reject! { |key| keys.include?(key) }
  end

  private

  def params
    __getobj__
  end
end
