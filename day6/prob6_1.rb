orbits = {}

def find_num_links(orbits, obj)
  return 0 if obj == "COM"
  if orbits[obj][:links] != 0
    orbits[obj][:links]
  else
    orbits[obj][:links] = find_num_links(orbits, orbits[obj][:orbits]) + 1
  end
end

File.open('prob6_1.txt').each do |line|
  obj1, obj2 = line.strip.split(')')
  if !orbits.has_key?(obj1)
    orbits[obj1] = { orbits: nil, links: 0 }
  end
  orbits[obj2] = { orbits: obj1, links: 0 }
end

total_links = 0
orbits.each do |key, value|
  total_links += find_num_links(orbits, key)
end

puts total_links
