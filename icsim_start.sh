#!/system/bin/sh

CAN_IFACE="$1"

# ICSim Display (Display :1, VNC 5900, noVNC 6080)
export DISPLAY=:1
Xvfb :1 -screen 0 692x350x16 &
sleep 5
fluxbox &
sleep 2
x11vnc -display :1 -nopw -forever -bg -rfbport 5900
cd /opt/car_hacking/ICSim/builddir
./icsim "$CAN_IFACE" &

# Controls Display (Display :2, VNC 5901, noVNC 6081)
export DISPLAY=:2
Xvfb :2 -screen 0 692x350x16 &
sleep 5
fluxbox &
sleep 2
x11vnc -display :2 -nopw -forever -bg -rfbport 5901
./controls "$CAN_IFACE" &

# noVNC proxies
cd /opt/noVNC
./utils/novnc_proxy --vnc localhost:5900 --listen 6080 &
./utils/novnc_proxy --vnc localhost:5901 --listen 6081 &
