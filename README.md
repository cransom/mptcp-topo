requirements: have nix, be in linux, run as root.


the length and width variable create a topology of connected nodes LxW.

run it with ./topo.sh and mptcp enabled and disabled and you'd get something
like:
```
root@ogre> sysctl net.mptcp.mptcp_enabled=0
net.mptcp.mptcp_enabled = 0
root@ogre> ./topo.sh
Connecting to host 10.1.2.3, port 5201
[  4] local 10.0.0.6 port 33137 connected to 10.1.2.3 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  1.41 MBytes  11.8 Mbits/sec   10   32.5 KBytes       
[  4]   1.00-2.00   sec  1.14 MBytes  9.57 Mbits/sec    0   38.2 KBytes       
[  4]   2.00-3.00   sec  1.14 MBytes  9.57 Mbits/sec    0   26.9 KBytes       
[  4]   3.00-4.00   sec  1.14 MBytes  9.57 Mbits/sec    0   33.9 KBytes       
[  4]   4.00-5.00   sec  1.14 MBytes  9.57 Mbits/sec    0   21.2 KBytes       
[  4]   5.00-6.00   sec  1.14 MBytes  9.55 Mbits/sec    0   29.7 KBytes       
[  4]   6.00-7.00   sec  1.14 MBytes  9.57 Mbits/sec    0   35.4 KBytes       
[  4]   7.00-8.00   sec  1.14 MBytes  9.57 Mbits/sec    0   24.0 KBytes       
[  4]   8.00-9.00   sec  1.14 MBytes  9.57 Mbits/sec    0   31.1 KBytes       
[  4]   9.00-10.00  sec  1.14 MBytes  9.57 Mbits/sec    0   38.2 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec  11.7 MBytes  9.79 Mbits/sec   10             sender
[  4]   0.00-10.00  sec  11.4 MBytes  9.60 Mbits/sec                  receiver

iperf Done.
root@ogre> sysctl net.mptcp.mptcp_enabled=1
net.mptcp.mptcp_enabled = 1
root@ogre> ./topo.sh
Connecting to host 10.1.2.3, port 5201
[  4] local 10.0.0.4 port 56579 connected to 10.1.2.3 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  6.96 MBytes  58.4 Mbits/sec    0   14.1 KBytes       
[  4]   1.00-2.00   sec  4.48 MBytes  37.5 Mbits/sec    0   14.1 KBytes       
[  4]   2.00-3.00   sec  4.46 MBytes  37.4 Mbits/sec    0   14.1 KBytes       
[  4]   3.00-4.00   sec  4.51 MBytes  37.8 Mbits/sec    0   14.1 KBytes       
[  4]   4.00-5.00   sec  4.49 MBytes  37.7 Mbits/sec    0   14.1 KBytes       
[  4]   5.00-6.00   sec  4.48 MBytes  37.6 Mbits/sec    0   14.1 KBytes       
[  4]   6.00-7.00   sec  4.50 MBytes  37.7 Mbits/sec    0   14.1 KBytes       
[  4]   7.00-8.00   sec  4.51 MBytes  37.8 Mbits/sec    0   14.1 KBytes       
[  4]   8.00-9.00   sec  4.55 MBytes  38.2 Mbits/sec    0   14.1 KBytes       
[  4]   9.00-10.00  sec  4.47 MBytes  37.5 Mbits/sec    0   14.1 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec  47.4 MBytes  39.8 Mbits/sec    0             sender
[  4]   0.00-10.00  sec  45.1 MBytes  37.8 Mbits/sec                  receiver

iperf Done.
root@ogre>
```
