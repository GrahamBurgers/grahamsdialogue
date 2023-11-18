path = "D:/Steam/steamapps/common/Noita/mods/grahamsdialogue/files/font_data/font_pixel_huge.xml"

with open(path, "r") as f:
    text = f.read()
print([x.split("\"")[1] for x in text.split("id")[1:]])
chars = [chr(int(x.split("\"")[1])) for x in text.split("id=")[1:]]
print(chars)
widths = [int(x.split("\"")[1]) for x in text.split("width=")[1:]]
stuff = {}
for a, b in zip(chars, widths):
    stuff[a] = b
try:
    stuff["\\\""] = stuff["\""]
    stuff.pop("\"")
except:
    pass
try:
    stuff["\\\\"] = stuff["\\"]
    stuff.pop("\\")
except:
    pass
o = "return {"
for k, v in stuff.items():
    o += f"[\"{k}\"] = {v},\n"
o = o[:-2]
o = o + "\n}"
print(o)
import codecs
with codecs.open("out.lua", "w","utf-8") as f:
    f.write(o)
