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
eps=${lay%lay}eps

echo ${lay}
echo ${eps}

cat > lay2eps.mcr <<EOF
#!MC 1410
\$!OPENLAYOUT  "${lay}"
\$!EXPORTSETUP EXPORTFORMAT = EPS
\$!PRINTSETUP PALETTE = COLOR
\$!EXPORTSETUP EPSPREVIEWIMAGE{IMAGETYPE = NONE}
\$!EXPORTSETUP EXPORTFNAME = '${eps}'
\$!EXPORT 
  EXPORTREGION = ALLFRAMES
\$!QUIT
EOF

tec360 lay2eps.mcr

rm -f batch.log
rm -f lay2eps.mcr

epstopdf ${eps}
rm ${eps}
