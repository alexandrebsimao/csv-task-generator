require 'active_support/all'

str = "ID;Atividade;Situacao;Inicio;Fim;Duracao;Recurso\n"

situations = { 'pending' => 1440, 'documentation' => 480, 'development' => 1440, 'test' => 1440, 'reworking' => 480, 'finished' => 60}
resources = [ 'Bob', 'Jonh', 'Mary', 'Ashley', 'Marie', 'Joana', 'Luke', 'Rob' ]

start_time = '2012-05-06 08:00:00'.to_datetime
end_time = nil
max_date = nil

count = 0
resource_id = 0

1000.times do
  count += 1

  id = count
  name = "Task ##{count}"

  resource = resources[resource_id]

  situations.each do |sit, time|
    duration = rand((time - (time * 0.10))..(time + (time * 0.10))).to_i.minutes
    start_time = end_time != nil ? end_time : start_time
    end_time = start_time.to_datetime + duration

    situation = sit

    resource = resources[rand(0..(resources.size-1))] if rand(0..1)

    str += "#{count};#{name};#{situation};#{start_time};#{end_time};#{duration};#{resource}\n"
  end
  
  puts resource_id
  puts max_date

  if resource_id == resources.size
    resource_id = 0
    start_time = max_date
    end_time = max_date
  else
    # start_time = '2020-05-06 08:00:00'.to_datetime
    max_date = end_time if max_date == nil || max_date < end_time
    end_time = nil
  end

  resource_id += 1

end

puts str
