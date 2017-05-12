# Find Days which start a set of lates

start_of_set = proc do |day|
  index = day.line.days.index(day)
  day.line.days[index - 1].turn_id.nil?
end

Day.includes(line: [:days])
   .joins(:turn)
   .where(name: %w(wed fri),
          turns: {
            shift: 'late',
            base_roster_id: 5
          })
   .find_all(&start_of_set)

# As a one-liner:
Day.includes(line:[:days]).joins(:turn).where(name:['wed','fri'],turns:{shift:'late',base_roster_id:5}).find_all(&start_of_set)
