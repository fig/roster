module MCO
  class Finder
    def self.find(user, date)
      candidates = Turn.where(
        shift: user.preference,
        base_roster: user.base_roster,
        date.strftime('%a').downcase => true,
        )
    end
  end
end