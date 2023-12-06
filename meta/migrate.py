with open("old","r") as f:
	c = f.read()

t = c.split("},\n")
t = [x[1:] for x in t][:-1]
# print(t)
# t = ["[" + x[1] + "]" + x[2:] for x in t]
# print("\n".join(t))
pools = {}
for x in t:
	weight = x.split(",")[1].replace(" ","").replace("\t","")
	lines = x[x.find("{"):x.find("}")+1]
	pool = x.split("\"")[1]
	if not pool in pools.keys():
		pools[pool] = []
	pools[pool].append((weight,lines))
print(pools)
built = "return {"
for v in pools.items():
	built += f"[\"{v[0]}\"] = {{"
	print("babans")
	print(v)
	for e in v[1]:
		print(e)
		built += f"{{weight = {e[0]}, lines = {e[1]}}},\n"
	built += "},\n"
built = built[:-1] + "}"
print(built)
with open("out.lua","w") as f:
	f.write(built)