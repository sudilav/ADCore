; This program tests the NDDriverStdArrays driver by writing writing to
; EPICS PVs to cause the driver to run

prefix = '13NDSA1:cam1:'

; Start acquire

nDimensions = 3
dimensions = intarr(nDimensions)

xSize = 512
ySize = 512
dimensions[0] = 3
dimensions[1] = xSize
dimensions[2] = ySize
dataType = 'UInt8'
colorMode = 'RGB1'
arrayMode = 'Overwrite'

t = caput(prefix + 'NDimensions', nDimensions)
t = caput(prefix + 'Dimensions', dimensions)
t = caput(prefix + 'DataType', dataType)
t = caput(prefix + 'ColorMode', colorMode)
t = caput(prefix + 'ArrayMode', arrayMode)
t = caput(prefix + 'Acquire', 1)

data = dblarr(3, xSize, ySize)
for i=1, 100 do begin
  data[0,*,*] = 100*sin(shift(dist(xSize, ySize)/i, xsize/2, ysize/2))
  data[1,*,*] = 100*sin(shift(dist(xSize, ySize)/(i*2), xsize/2, ysize/2))
  data[2,*,*] = 100*sin(shift(dist(xSize, ySize)/(i*3), xsize/2, ysize/2))
  t = caput(prefix + 'ArrayIn', data)
  wait, .1
endfor

end
