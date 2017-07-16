#Only strings
def ReplaceAndReverse(string)
  string.gsub(/[aeiouAEIOU]+/){|s| s=""}.reverse
end

p ReplaceAndReverse("Abecedario")
p ReplaceAndReverse("Constante")
p ReplaceAndReverse("AERopUeRto")
