class Scheduler
  def self.which_turn(user, date)
    week, day = (date - user.roster_epoch).to_i.divmod(7)
    week = week % roster_size(user)
    user.base_roster.lines[week].days[day].turn
  end

  def self.which_driver(turn, date)

    # find day of week from date
    day = date.strftime('%a').downcase.to_sym

    # find line  where day has turn
    line = Line.find_by(day => turn.name)

    # find difference in weeks between date and now
    diff = ((date.beginning_of_week - Date.today.beginning_of_week) / 7).to_i

    # calc difference modulo total lines (number of weeks to next occurance)
    diff = diff % roster_size(line)

    # current week for tgt driver is line number - modulo
    driver_on_week = line.number.to_i - diff

    driver_on_week += roster_size(line) while driver_on_week < 1
    # find driver on that week

    drivers = User.all
    drivers_lines = drivers.map(&:current_line)
    index = drivers_lines.index driver_on_week - 1
    drivers[index]
  end

  def self.roster_size(obj)
    obj.base_roster.lines_count
  end
end
