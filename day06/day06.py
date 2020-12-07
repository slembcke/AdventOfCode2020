import io
import sys

def parse_group(stream):
	abc = 256*[0]
	count = 0
	
	while True:
		str = stream.readline()
		if str == "": return None
		if str == "\n": break
		for q in str.strip(): abc[ord(q)] += 1
		count += 1
	
	sum = 0
	for elt in abc:
		if elt == count: sum += 1
	return sum


sum = 0
stream = open(sys.argv[1])
while True:
	count = parse_group(stream)
	if count == None: break
	sum += count

print(sum)
