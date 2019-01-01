# TipAlert Fall Detector

This is a tiny NodeMCU Lua project for detecting and reporting certian kinds of falls.

## Setup
First, build the firmware, download the NodeMCU-PyFlasher, install the USB driver, and flash the firmware.

### terminal windows
Now you can verify that NodeMCU was flashed properly and try out a few commands by using a terminal emiulator. From my mac, I do this:

    ls /dev/*USB* # to find the USB serial port my board is plugged into
    screen /dev/dev/tty.SLAB_USBtoUART 115200
    # hit enter
    > print('hello')
    hello

When you are done messing around, you can go to another terminal window and type `screen -d` to detatch from the tty and then `screen -r` to reattach.

If you have a message that looks like the terminal is busy, it might be time to clean up. Use `screen -ls` to figure out the names of running sessions and `screen -X -S <screen-id> quit` to quit a session.

### init.lua
The `init.lua` file runs at startup or when the reset button is pressed. You can upload your own init.lua by following the instructions here: https://nodemcu.readthedocs.io/en/master/en/upload/



## Programming

Resources
=========

1. https://learn.adafruit.com/adafruit-feather-huzzah-esp8266/using-nodemcu-lua
2. https://nodemcu.readthedocs.io/en/latest/en/upload/#initlua
3. https://github.com/marcelstoer/nodemcu-pyflasher/releases
4. https://nodemcu.readthedocs.io/en/latest/en/flash/
5. https://www.limpkin.fr/index.php?post/2016/04/17/A-Small-Collection-of-NodeMCU-Lua-Scripts-for-Data-Collection
6. https://nodemcu-build.com/


