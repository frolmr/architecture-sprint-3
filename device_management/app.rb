require 'sinatra'
require 'pg'

post '/devices' do
  data = JSON.parse(request.body.read)

  conn = db_connection
  type = conn.exec_params('SELECT device_type_id FROM device_types LIMIT 1')
  data = conn.exec_params('INSERT INTO devices (serial_number, device_type_id, status) VALUES ($1, $2, $3)', [data['serial_number'], type.first['device_type_id'], data['status']])
  conn.close

  content_type :json
  { status: 'success', message: 'Device successfuly created' }.to_json
end

get '/devices' do
  conn = db_connection
  data = conn.exec_params('SELECT device_id FROM devices')
  conn.close

  content_type :json
  { status: 'success', data: data.to_a }.to_json
end

get '/devices/:device_id' do
  device_id = params[:device_id]

  conn = db_connection
  data = conn.exec('SELECT * FROM devices WHERE device_id = $1 LIMIT 1', [device_id])
  conn.close

  content_type :json
  { status: :success, data: data.first }.to_json
end

get '/devices/:device_id/status' do
  device_id = params[:device_id]

  conn = db_connection
  data = conn.exec('SELECT * FROM devices WHERE device_id = $1 LIMIT 1', [device_id])
  conn.close

  content_type :json
  { status: :success, status: data.first['status'] }.to_json
end


post '/devices/:device_id/commands' do
  device_id = params[:device_id]
  command = JSON.parse(request.body.read)

  # response ok to client first after that:
  send_to_background
  request_device
  # after response from is device
  produce_message
  # notification service will consume the message and send to client in push notification
end

def send_to_background
  puts 'Sending task to background jobs'
end

def request_device
  puts 'Requesting device'
end

def produce_message
  puts 'Producing message to topic'
end

def db_connection
  PG.connect(
    dbname: 'device-management',
    user: 'user',
    password: 'password',
    host: 'device-management-db'
  )
end
