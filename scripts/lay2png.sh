#!/usr/bin/env bash

if [ -z "$1" ] ; then
    for lay in `ls *.lay` ; do
	$0 ${lay}
    done
    exit 0
fi

if (( $# > 1 )) ; then
    for lay in "$@" ; do
	$0 ${lay}
    done
    exit 0
fi

lay=$1
png=${lay%lay}png

echo ${lay}
echo ${png}

cat > lay2png.mcr <<EOF
#!MC 1410
\$!OPENLAYOUT  "${lay}"
\$!EXPORTSETUP IMAGEWIDTH = 1024
\$!EXPORTSETUP USESUPERSAMPLEANTIALIASING = YES
\$!EXPORTSETUP CONVERTTO256COLORS = NO
\$!EXPORTSETUP EXPORTFNAME = '${png}'
\$!EXPORT 
  EXPORTREGION = ALLFRAMES
\$!QUIT
EOF

tec360 lay2png.mcr

rm -f lay2png.mcr

