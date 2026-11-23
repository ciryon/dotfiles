-- Omarchy binds ALT + SPACE to "Toggle dictation" by default; release it so
-- oma-cast gets the key. SUPER + CTRL + X still toggles dictation.
hl.unbind("ALT + SPACE")
o.bind("ALT + SPACE", "oma-cast launcher", hl.dsp.global("oma-cast:toggle"))
