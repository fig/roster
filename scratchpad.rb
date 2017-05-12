Day.joins(:turn).find_by({ name: 'wed', turns: { name: '21', base_roster_id: 5}})

days = Day.joins(:turn).where( {
  name: 'wed',
  turns: {
    shift: 'late',
    base_roster_id: 5
  }
} )