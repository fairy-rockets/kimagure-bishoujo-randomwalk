#! /bin/bash

max=72001
for ((i=0; i <= $max; i++)); do
  fname=$(printf "%07d.png" $i)
  #printf "%07d/%07d (%s%%)\n" $i $max \
  #  $(echo "scale=2; $i * 100 / $max"| bc -l)
  echo montage \
    img.0000/$fname \
    img.0001/$fname \
    img.0002/$fname \
    img.0003/$fname \
    img.0004/$fname \
    img.0005/$fname \
    img.0006/$fname \
    img.0007/$fname \
    img.0008/$fname \
    img.0009/$fname \
    img.0010/$fname \
    img.0011/$fname \
    img.0012/$fname \
    img.0013/$fname \
    img.0014/$fname \
    img.0015/$fname \
    img.0016/$fname \
    img.0017/$fname \
    img.0018/$fname \
    img.0019/$fname \
    img.0020/$fname \
    img.0021/$fname \
    img.0022/$fname \
    img.0023/$fname \
    img.0024/$fname \
    img.0025/$fname \
    img.0026/$fname \
    img.0027/$fname \
    img.0028/$fname \
    img.0029/$fname \
    img.0030/$fname \
    img.0031/$fname \
    img.0032/$fname \
    img.0033/$fname \
    img.0034/$fname \
    img.0035/$fname \
    img.0036/$fname \
    img.0037/$fname \
    img.0038/$fname \
    img.0039/$fname \
    -tile 8x5 -geometry 128x128+0+0 -border 2 \
    img.all/${fname}
done

