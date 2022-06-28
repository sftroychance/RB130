=begin

The following list contains the names of individuals who are pioneers in
  the field of computing or that have had a significant influence on the field. The names are in an encrypted form, though, using a simple (and incredibly weak) form of encryption called Rot13.

A:
- read file
- for each line
  - split array into characters
  - for each character
    - if char =~ /[A-Ma-m]/ replace char with (char.ord + 13).chr
    else replace char with (chr.ord - 13).chr
  - join
  - print encrypted name & unencrypted name
=end

def decrypt(str)
  str.split('')
     .map do |c|
       case c
       when /[A-Ma-m]/ then (c.ord + 13).chr
       when /[N-Zn-z]/ then (c.ord - 13).chr
       else c
       end
     end.join
end

def process_encrypted_file(filename)
  file = File.open(filename)
  file.each { |line| yield(line.chomp) }
  file.close
end

process_encrypted_file('encrypted_names.txt') do |name|
  puts "#{name} : #{decrypt(name)}"
end