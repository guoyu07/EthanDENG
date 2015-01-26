mkdir out
for %%B in (*.jpg) do convert "%%B" -colorspace Gray "out/%%B"
