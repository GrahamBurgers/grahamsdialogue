path = "C:/Users/natha/Documents/code/noitadat/data/fonts/font_pixel_big.xml"
with open(path, "r") as f:
    text = f.read()
chars = [chr(int(x.split("\"")[1])) for x in text.split("id")[1:]]
widths = [int(x.split("\"")[1]) for x in text.split("width")[1:]]
stuff = {}
for a, b in zip(chars, widths):
    stuff[a] = b
stuff["\\\""] = stuff["\""]
stuff.pop("\"")
stuff["\\\\"] = stuff["\\"]
stuff.pop("\\")
o = "return {"
for k, v in stuff.items():
    o += f"[\"{k}\"] = {v},\n"
o = o[:-2]
o = o + "\n}"
print(o)
with open("out.lua", "w") as f:
    f.write(o)
