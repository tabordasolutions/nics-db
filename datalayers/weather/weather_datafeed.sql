
-- table to hold raws weather data
CREATE TABLE raws
(
  id serial,
  station_id character varying NOT NULL,
  station_name character varying NOT NULL,
  status character varying NOT NULL,
  state character varying NOT NULL,
  air_temperature double precision,
  wind_speed double precision,
  wind_direction double precision,
  wind_gust double precision,
  dew_point_temperature double precision,
  relative_humidity double precision,
  more_observations character varying,
  description character varying,
  observation_recorded_at timestamp with time zone NOT NULL,
  created_at timestamp with time zone NOT NULL,
  the_geom geometry(Point,3857) NOT NULL,
  CONSTRAINT raws_pkey PRIMARY KEY (id),
  CONSTRAINT raws_unique_station_id UNIQUE (station_id)
);

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
    raws.the_geom
   FROM raws where upper(raws.status) = 'ACTIVE';

-- index on status
CREATE INDEX raws_status_index ON raws ((upper(status)));

