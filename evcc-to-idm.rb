require 'mqtt'
require 'rmodbus'

MODBUS_HOST = ''
MODBUS_PORT = 502
# Example MQTT_URL = 'mqtt://mqtt:password!@192.168.1.124:1883'
MQTT_URL = ''

def send_modbus(register, value)
  ModBus::TCPClient.new(MODBUS_HOST, MODBUS_PORT) do |cl|
    cl.with_slave(1) do |slave|
      if value.is_a?(Float)
        slave.holding_registers[register..register+1] = [value].from_32f
      else
        slave.holding_registers[register] = value
      end
    end
  end
end

client = MQTT::Client.connect(MQTT_URL)

client.get('evcc/site/#') do |topic, message|
  if topic == 'evcc/site/pvPower'
    puts "#{topic}: #{message}"
    send_modbus(78, message.to_f / 1000.0)
  elsif topic == 'evcc/site/homePower'
    puts "#{topic}: #{message} #{message.class}"
    send_modbus(82, message.to_f / 1000.0)
  elsif topic == 'evcc/site/batteryPower'
    puts "#{topic}: #{message} #{message.class}"
    send_modbus(84, message.to_f / 1000.0)
  elsif topic == 'evcc/site/batterySoc'
    puts "#{topic}: #{message} #{message.class}"
    send_modbus(86, message.to_i)
  elsif topic == 'evcc/site/gridPower'
    power = message.to_f
    puts "#{topic}: #{message}"
    send_modbus(74, power / 1000.0 * -1.0)
  end
end

