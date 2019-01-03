# TipAlert Fall Detector

This is a tiny project for detecting and reporting certian kinds of falls. This README is mostly for capturing my notes, others may find it useful as a guide.

![TipAlert photo](tipalert-photo.jpg)

## System Architecture
This system is designed to detect a fall where someone in a wheelchair falls over, is prevented from falling on the floor by a seatbelt, but cannot right themselves. To detect this situation, two pressure sensitive buttons are placed behind the user's leg and back. A fall is then detected when for some length of time, the back button is not pressed but the leg button is pressed. This minimizes false positives when the user is completely out of the wheelchair or sitting normally.

In order to alert a caregiver or local authorities about the fall, we send a customizable text message. To send the text message, we use the REST API of the [Twilio Messages](https://www.twilio.com/docs/sms/send-messages) service. 

This means that the development board must have the following capabilities:

1. Ability to read two general purpose IO pins and provide a stable 3.3 volts power to the pressure sensing buttons.
2. Ability to be portable, small, and battery operated. Onboard power management and LiPo battery charging are desireable.
3. Ability to connect to the Internet via WiFi (802.11 and a stable TCP/IP stack).
4. Mature firmware with utilities for the above capabilities.

The [Adafruit Feather HUZZAH ESP8266](https://learn.adafruit.com/adafruit-feather-huzzah-esp8266/overview) running NodeMCU Lua fits all the above requirements.

## Setup
First, build the firmware, download the NodeMCU-PyFlasher, install the USB driver, and flash the firmware.

### Terminal windows
Now you can verify that NodeMCU was flashed properly and try out a few commands by using a terminal emiulator. From my mac, I do this:

    ls /dev/*USB* # to find the USB serial port my board is plugged into
    screen /dev/dev/tty.SLAB_USBtoUART 115200
    # hit enter
    > print('hello')
    hello

When you are done messing around, you can go to another terminal window and type `screen -d` to detatch from the tty and then `screen -r` to reattach.

If you have a message that looks like the terminal is busy, it might be time to clean up. Use `screen -ls` to figure out the names of running sessions and `screen -X -S <screen-id> quit` to quit a session.

## Programming
To send application files to the device, I have been using ESPlorer and nodemcu-uploader. They each have their merits, ESPlorer is a nice graphical UI and allows me to make minor edits, click a button to upload directly to the board, and then monitor standard outupt. nodemcu-uploader is better for quick command line uploads.

## Code
There are three files: init.lua, params.lua, and falldetector.lua.

### init.lua
The `init.lua` file runs at startup or when the reset button is pressed. You can upload your own init.lua by following the instructions here: https://nodemcu.readthedocs.io/en/master/en/upload/

My init.lua just gets a WiFi connection going and then passes control to the `falldectector.lua` script.

### falldetector.lua
This is the main logic of the application. The logic is that it will read from the digital
pressure sensitive buttons every 3 seconds. If it detects that the leg sensor is pressed but the back sensor is not pressed 10 times in a row, it will alarm. The alarm is in the form of a text message.

To send the text message, I am using the Twilio service. The Twilio Message REST API is exercised in the fallDetected function and parameterized by the `params.lua` file.

### params.lua
`params.lua` contains secrets like your wifi SSID and password and Twilio credentials. It gets loaded by `init.lua`. You can enter your own secrets in params_lua.example and save as params.lua.

Resources
=========

1. https://learn.adafruit.com/adafruit-feather-huzzah-esp8266/using-nodemcu-lua
2. https://nodemcu.readthedocs.io/en/latest/en/upload/#initlua
3. https://github.com/marcelstoer/nodemcu-pyflasher/releases
4. https://nodemcu.readthedocs.io/en/latest/en/flash/
5. https://www.limpkin.fr/index.php?post/2016/04/17/A-Small-Collection-of-NodeMCU-Lua-Scripts-for-Data-Collection
6. https://nodemcu-build.com/


