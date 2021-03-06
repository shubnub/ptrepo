#!/usr/bin/env python

import socket
import struct
import getopt
import sys
import time

group = '224.1.1.1'
port = 5007
size = 256

def help ():
    print("%s <OPTIONS>" % sys.argv[0])
    print("Where OPTIONS are:")
    print("\t-h | --help\t\t\tPrint this")
    print("\t-u | --udp\t\t\tUse UDP (default)")
    print("\t-t | --tcp\t\t\tUse TCP")
    print("\t-g <group> | --group=<group>\tThe group to use. (Default: %s)" % (group))
    print("\t-p <port> | --port=<port>\tThe port to use. (Default: %d)" % (port))
    print("\t-s <size> | --size=<size>\tPad messages out to this size using trailing spaces. (Default: %d)" % (size))
    sys.exit(1)

try:
    options, other = getopt.getopt(sys.argv[1:], 'hutg:ps:', ['help',
                                                             'udp',
                                                             'tcp',
                                                             'group=',
                                                             'port=',
                                                             'size='
                                                             ])
except getopt.GetoptError:
    help()

proto = ""
sock_type = ""

for opt, arg in options:
    if opt in ('-h', '--help'):
        help()
    elif opt in ('-u', '--udp'):
        pass
    elif opt in ('-t', '--tcp'):
        proto = socket.IPPROTO_TCP
        sock_type = socket.SOCK_STREAM
    elif opt in ('-g', '--group'):
        group = arg
    elif opt in ('-p', '--port'):
        port = int(arg)
    elif opt in ('-s', '--size'):
        size = int(arg)

if (proto == ""):
    proto = socket.IPPROTO_UDP
if (sock_type == ""):
    sock_type = socket.SOCK_DGRAM

sock = socket.socket(socket.AF_INET, sock_type, proto)
sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 2)

hostname = socket.gethostname()
try:
    while True:
        message = "%s -- %s" % (hostname, time.asctime())
        padded = message.ljust(size)
        sock.sendto( padded, (group, port) )
        time.sleep(1)
except KeyboardInterrupt:
    pass
