class Role
  RAW_ROLES = {
    0 => :everybody,
    1 => :guest,
    4 => :padawan,
    8 => :player,
    12 => :moderator,
    16 => :admin
  }


  def self.all
    RAW_ROLES
  end

  def self.get_id(from_sym)
    RAW_ROLES.key from_sym
  end

  def self.get_sym(from_id)
    RAW_ROLES[from_id]
  end

end
