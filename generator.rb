require 'active_support/all'

str = "ID;Atividade;Situacao;Inicio;Fim;Duracao;Recurso\n"

situations = { 'pending' => 1440, 'documentation' => 480, 'development' => 2400, 'test' => 2400, 'reworking' => 480, 'finished' => 60}
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
    next if sit == 'reworking' && rand(0..1).to_i

    duration = rand((time - (time * 0.20))..(time + (time * 0.20))).to_i.minutes
    start_time = end_time != nil ? end_time : start_time
    end_time = start_time.to_datetime + duration

    situation = sit

    resource = resources[rand(0..(resources.size-1))] if rand(0..1).to_i

    str += "#{count};#{name};#{situation};#{start_time};#{end_time};#{duration};#{resource}\n"
  end

  if resource_id == resources.size
    resource_id = 0
    start_time = max_date
    end_time = max_date
  else
    max_date = end_time if max_date == nil || max_date < end_time
    end_time = nil
  end

  resource_id += 1
end

puts str
