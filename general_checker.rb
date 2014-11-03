def check_parens(parens_string)
  stack = []
  parens_string.each_char do |char|
    if ["(", "{", "["].include?(char)
      stack.push(char)
    else
      return false if stack.empty?
      if ( stack.last == "(" && char == ")" ) || ( stack.last == "{" && char == "}" ) || ( stack.last == "[" && char == "]" )
        stack.pop
      else
        return false
      end
    end
  end
  stack.empty?
end

puts check_parens("({}[])")
puts check_parens("(){}[]")
puts check_parens("({[]})")
puts check_parens("([]}")
puts check_parens("([]{])")