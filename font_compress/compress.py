import fontforge

font = fontforge.open("Iansui094-Regular.ttf")

to_reserve = open("characters.txt", "r", encoding="utf8").readline()
err_l = []

for glyph in font:
    if str(glyph).startswith("uni"):
        try:
            if (chr(int(str(glyph)[3:7], 16)) not in to_reserve):
                font.selection.select(("more",), glyph)
        except:
            pass

font.clear()
font.save("modified_font.ttf")
font.close()

# 還需要再使用 fontforge 將大小壓到更低