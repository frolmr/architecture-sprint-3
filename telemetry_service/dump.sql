CREATE TABLE telemetry_data (
	telemetry_data_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
	device_id uuid,
	data JSONB,
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
