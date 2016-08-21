#!/usr/bin/env nix-shell
#!nix-shell -p iperf bird coreutils iproute fping -i bash

set -e

subnet=0
pkill bird || true

loop=0
ip=0

length=2
width=4
for f in `ip netns list | awk '{ print $1 }'`; do ip netns delete $f; done
for f in $(seq 0 $length); do
  for g in $(seq 0 $((width -1))); do
    ip netns add $f-$g
  done
done
for f in $(seq 0 $((length -1))); do
  for g in $(seq 0 $((width-1))); do
    for h in $(seq 0 $((width-1))); do
			nearnode=$f-$g
			farnode=$((f+1))-$((h % (width)))
			nearint=$f$g-$((f+1))$(( h % (width) ))
			farint=$((f+1))$((h % (width) ))-$f$g
			nearip="10.0.$(( ip / 256)).$((ip % 256))"
      ip=$((ip + 1 ))
			farip="10.0.$(( ip / 256)).$((ip % 256))"
      ip=$((ip + 1 ))
			ip link add $nearint type veth peer name $farint

			ip link set $nearint netns $nearnode
			ip link set $farint  netns $farnode

			ip netns exec $nearnode ip link set $nearint up
			ip netns exec $farnode  ip link set $farint up

			ip netns exec $nearnode  ip addr add $nearip peer $farip dev $nearint
			ip netns exec $farnode   ip addr add $farip peer $nearip dev $farint
      ip netns exec $nearnode tc qdisc add dev $nearint root tbf rate 10mbit burst 15000 latency 20ms
    done
  done
done

for ns in $( ip netns list | awk '{ print $1 }' ); do
  ip netns exec $ns ip addr add 10.1.${ns/\-/.}/32 dev lo
  ip netns exec $ns ip link set lo up
  ip netns exec $ns bird -c bird.conf -s $ns.sock
done

ip netns exec $length-$((width-1)) iperf -s >/dev/null &
while ! $( ip netns exec 0-0 ip route | grep -q bird); do
  sleep 1
done
ip netns exec 0-0 iperf -c 10.1.$((length)).$((width-1))
kill $!


