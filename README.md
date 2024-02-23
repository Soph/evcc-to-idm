# evcc-to-idm

This is a small script that can be run to forward PV related data from [evcc](https://evcc.io) to an IDM Heatpump. This was tested with a IDM AERO ALM 10-24.

![Screenshot of the IDM Navigator Pro overview showing PV data](docs/ScreenshotIDM.png)

## Preconditions

1. a running mqtt broker for example [Mosquitto MQTT](https://mosquitto.org)
2. evcc setup to send metrics to mqtt
```
mqtt:
  broker: 192.168.1.124:1883
  topic: evcc
  user: mqtt
  password: password!
```
3. Modbus TCP enabled in IDM Navigator Pro 
![Enabled Modbus TCP in GLT section in IDM Navigator UI](docs/ScreenshotGLT.png)

## Setup

1. clone the repository
2. run `bundle install`
3. set `MODBUS_HOST`, `MODBUS_PORT` and `MQTT_URL` to your values in `evcc-to-idm.rb`
4. run `bundle exec ruby evcc-to-idm.rb`

To run this continously I have it running in a screen on a raspberry pi that runs other monitoring in my home. 