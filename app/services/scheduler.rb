module Scheduler
  class WhichTurn
    include Scheduler
    attr_accessor :user, :date

    def initialize(user, date)
      @user = user
      @date = date
    end

    def turn
      week, day = (date - user.roster_epoch).to_i.divmod(7)
      week = week % roster_size(user)
      user.base_roster.lines[week].days[day].turn
    end
  end

  class WhichDriver
    include Scheduler
    attr_accessor :turn, :date

    def initialize(turn, date)
      @turn = turn
      @date = date
    end

    def driver
      drivers = User.all
      drivers_lines = drivers.map(&:current_line)
      index = drivers_lines.index week - 1
      drivers[index]
    end

    def week
      week = line.number.to_i - diff
      week += roster_size line while week < 1
      week
    end

    def day
      date.strftime('%a').downcase.to_sym
    end

    def line
      Line.find_by(day => turn.name)
    end

    def diff
      ((date.beginning_of_week - Date.today.beginning_of_week) / 7).to_i % roster_size(line)
    end
  end

  def roster_size(obj)
    obj.roster_size
  end
end
