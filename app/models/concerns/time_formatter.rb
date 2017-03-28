module TimeFormatter
  extend ActiveSupport::Concern
  
  def format_hhmm(duration)
    hh, ss = duration.divmod(3600)
    mm = ss / 60
    format('%d:%02d', hh, mm)
  end
end