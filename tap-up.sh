#!/bin/sh

echo "=== $0 $*"

PREFIX6=2001:500:4:

V6="$PREFIX6`/sbin/ifconfig tap0 | /usr/bin/awk '/inet/ { if ( $2 !~ /^169/ ) { split($2,octet,\".\"); third=octet[3]; fourth=octet[4] }} END { print third\"::\"fourth }'`"
NEWDEFROUTE=`/bin/echo $V6 | /usr/bin/sed 's/^\(.*\)::.*$/\1::1/'`

/sbin/ifconfig tap0 inet6 $V6/64
# delete the v6 default route, if it exists
OLDDEFROUTE=`/usr/sbin/netstat -nr -f inet6 | /usr/bin/awk '/default/ { print $2 }'`
if [ -n "$OLDDEFROUTE" ]; then
	/sbin/route delete -inet6 default
fi
/sbin/route add -inet6 default $NEWDEFROUTE

