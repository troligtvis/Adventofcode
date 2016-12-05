require 'digest'

input = "ffykfhsq"
password = Array.new(8)
index = 0
count = 0

class Object
	def number_or_nil(string)
  		num = string.to_i
  		num if num.to_s == string
	end
end

until count == 8 do
	md5Hex = Digest::MD5.hexdigest(input + index.to_s)
	if md5Hex.start_with?('00000') && number_or_nil(md5Hex[5]) 	
		position = md5Hex[5].to_i
		if password[position] == nil && position < 8
			password.delete_at(position)
			password.insert(position, md5Hex[6])
			count += 1
		end
	end

	index += 1
end

puts password.join("")