CREATE TABLE device_types (
	device_type_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
	type VARCHAR(100)
);

INSERT INTO device_types (device_type_id, type) VALUES (gen_random_uuid(), 'smart_devices');

CREATE TABLE devices (
	device_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
	device_type_id uuid,
	serial_number VARCHAR(100),
	status VARCHAR(30)
);
