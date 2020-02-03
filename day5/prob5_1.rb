$arr = []
File.open('prob5_1.txt').each do |line|
  $arr = line.split(',').map(&:to_i)
end

OPCODE_LENGTH = 100

def log(opcode, params, args)
  puts "[LOG] code:#{opcode}, params:#{params}, args:#{args}"
end

def opcode1(modes, params)
  # log(1, params, args)
  # val1 = get_value(params[0], args[0])
  # val2 = get_value(params[1], args[1])
  # puts "[CODE1] Putting #{val1 + val2} in #{args[-1]}"
  $arr[params[-1]] = get_value(modes[0], params[0]) + get_value(modes[1], params[1])
end

def opcode2(modes, params)
  # log(2, params, args)
  # val1 = get_value(params[0], args[0])
  # val2 = get_value(params[1], args[1])
  # puts "[CODE2] Putting #{val1 + val2} in #{args[-1]}"
  $arr[params[-1]] = get_value(modes[0], params[0]) * get_value(modes[1], params[1])
end

def opcode3(pos)
  print "Input number: "
  $arr[pos] = gets.strip.to_i
end

def opcode4(modes, val)
  # log(4, params, val)
  puts get_value(modes[0], val)
end

def get_value(param_mode, val)
  param_mode == 0 || !param_mode ? $arr[val] : val
end

instr_ptr   = 0
while true
  instr  = $arr[instr_ptr]
  opcode = instr % OPCODE_LENGTH
  modes = (instr / OPCODE_LENGTH).to_s.split('').map(&:to_i).reverse

  case opcode
  when 1
    opcode1(modes, $arr[instr_ptr+1..instr_ptr+3])
    instr_ptr += 4
  when 2
    opcode2(modes, $arr[instr_ptr+1..instr_ptr+3])
    instr_ptr += 4
  when 3
    opcode3($arr[instr_ptr+1])
    instr_ptr += 2
  when 4
    opcode4(modes, $arr[instr_ptr+1])
    instr_ptr += 2
  when 99
    break
  end
end
