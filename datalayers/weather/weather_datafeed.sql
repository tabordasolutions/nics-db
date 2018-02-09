
-- table to hold raws weather data
create table raws
(
	id serial not null
		constraint raws_pkey
			primary key,
	station_id varchar not null
		constraint raws_unique_station_id
			unique,
	station_name varchar not null,
	status varchar not null,
	state varchar not null,
	air_temperature double precision,
	wind_speed double precision,
	wind_direction double precision,
	wind_gust double precision,
	dew_point_temperature double precision,
	relative_humidity double precision,
	more_observations varchar,
	description varchar,
	observation_recorded_at timestamp with time zone not null,
	created_at timestamp with time zone not null,
	the_geom geometry(Point,3857) not null,
	qc_status varchar(20)
)
;

-- view for geoserver raws layer
CREATE OR REPLACE VIEW public.raws_view AS 
 SELECT raws.id,
    raws.station_id,
    raws.station_name,
    raws.status,
    raws.description,
    round(raws.air_temperature) as air_temperature,
    raws.wind_speed,
    raws.wind_gust,
    raws.wind_direction,
    raws.observation_recorded_at,
    raws.the_geom,
    raws.qc_status
   FROM raws where upper(raws.status) = 'ACTIVE';

-- index on status
CREATE INDEX raws_status_index ON raws ((upper(status)));

