require 'sinatra'
require 'pg'

post '/devices/:device_id/telemetry' do
  data = JSON.parse(request.body.read)
  device_id = params[:device_id]

  conn = db_connection
  conn.exec_params('INSERT INTO telemetry_data (device_id, data) VALUES ($1, $2)', [device_id, data.to_json])
  conn.close

  content_type :json
  { status: 'success', message: 'Telemetry data added successfully' }.to_json
end

get '/devices/:device_id/telemetry' do
  device_id = params[:device_id]

  conn = db_connection
  data = conn.exec('SELECT * FROM telemetry_data WHERE device_id = $1', [device_id])
  conn.close

  content_type :json
  { status: :success, data: data.to_a }.to_json
end

get '/devices/:device_id/telemetry/latest' do
  device_id = params[:device_id]

  conn = db_connection
  data = conn.exec('SELECT * FROM telemetry_data WHERE device_id = $1 ORDER BY created_at DESC LIMIT 1', [device_id])
  conn.close

  content_type :json
  { status: :success, data: data.first }.to_json
end

def db_connection
  PG.connect(
    dbname: 'telemetry',
    user: 'user',
    password: 'password',
    host: 'telemetry-db'
  )
end
