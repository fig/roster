module ProfilesHelper
  def roster_suffix
    current_user.base_roster.suffix
  end
end
