class Scheduler

  attr_reader :args

  def initialize(args)
    @user = args[:user]
    @date = args[:date]
    @turn = args[:turn]
  end

  def which_turn
    week, day = (@date - @user.roster_epoch).to_i.divmod(7)
    linenum = week % roster_size(@user)
    line = @user.base_roster.lines.includes(days: :turn).find_by(number: linenum + 1)
    line.days[day].turn
  end

  def which_driver
    drivers = User.all.includes :profile, :base_roster
    drivers_lines = drivers.map(&:current_line)
    index = drivers_lines.index week - 1
    drivers[index]
  end

  private

  def week
    week = line.number - diff
    week += roster_size line while week < 1
    week
  end

  def day
    @date.strftime('%a').downcase.to_sym
  end

  def line
    Line.find_by(day => @turn.name)
  end

  def diff
    ((@date.beginning_of_week - Date.today.beginning_of_week) / 7).to_i % roster_size(line)
  end

  def roster_size(obj)
    obj.base_roster.lines_count
  end
end
