--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10
-- Dumped by pg_dump version 10.10

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'SQL_ASCII';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

--
-- Name: chirpstack_ns; Type: DATABASE; Schema: -; Owner: chirpstack_ns
--

-- CREATE DATABASE chirpstack_ns WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LC_COLLATE = 'C' LC_CTYPE = 'C';


-- ALTER DATABASE chirpstack_ns OWNER TO chirpstack_ns;

-- \connect chirpstack_ns

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'SQL_ASCII';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

-- CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


-- SET default_tablespace = '';

-- SET default_with_oids = false;

--
-- Name: code_migration; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

-- +migrate Up

-- +migrate StatementBegin

CREATE TABLE code_migration (
    id text NOT NULL,
    applied_at timestamp with time zone NOT NULL
);


-- ALTER TABLE code_migration OWNER TO chirpstack_ns;

--
-- Name: device; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE device (
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    device_profile_id uuid NOT NULL,
    service_profile_id uuid NOT NULL,
    routing_profile_id uuid NOT NULL,
    skip_fcnt_check boolean DEFAULT false NOT NULL,
    reference_altitude double precision NOT NULL,
    mode character(1) NOT NULL
);


-- ALTER TABLE device OWNER TO chirpstack_ns;

--
-- Name: device_activation; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE device_activation (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    dev_eui bytea NOT NULL,
    join_eui bytea NOT NULL,
    dev_addr bytea NOT NULL,
    f_nwk_s_int_key bytea NOT NULL,
    s_nwk_s_int_key bytea NOT NULL,
    nwk_s_enc_key bytea NOT NULL,
    dev_nonce integer NOT NULL,
    join_req_type smallint NOT NULL
);


-- ALTER TABLE device_activation OWNER TO chirpstack_ns;

--
-- Name: device_activation_id_seq; Type: SEQUENCE; Schema: public; Owner: chirpstack_ns
--

-- CREATE SEQUENCE device_activation_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


-- ALTER TABLE device_activation_id_seq OWNER TO chirpstack_ns;

--
-- Name: device_activation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chirpstack_ns
--

-- ALTER SEQUENCE device_activation_id_seq OWNED BY device_activation.id;


--
-- Name: device_multicast_group; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE device_multicast_group (
    dev_eui bytea NOT NULL,
    multicast_group_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL
);


-- ALTER TABLE device_multicast_group OWNER TO chirpstack_ns;

--
-- Name: device_profile; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE device_profile (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    device_profile_id uuid NOT NULL,
    supports_class_b boolean NOT NULL,
    class_b_timeout integer NOT NULL,
    ping_slot_period integer NOT NULL,
    ping_slot_dr integer NOT NULL,
    ping_slot_freq bigint NOT NULL,
    supports_class_c boolean NOT NULL,
    class_c_timeout integer NOT NULL,
    mac_version character varying(10) NOT NULL,
    reg_params_revision character varying(10) NOT NULL,
    rx_delay_1 integer NOT NULL,
    rx_dr_offset_1 integer NOT NULL,
    rx_data_rate_2 integer NOT NULL,
    rx_freq_2 bigint NOT NULL,
    factory_preset_freqs bigint[],
    max_eirp integer NOT NULL,
    max_duty_cycle integer NOT NULL,
    supports_join boolean NOT NULL,
    rf_region character varying(20) NOT NULL,
    supports_32bit_fcnt boolean NOT NULL,
    geoloc_buffer_ttl integer NOT NULL,
    geoloc_min_buffer_size integer NOT NULL
);


-- ALTER TABLE device_profile OWNER TO chirpstack_ns;

--
-- Name: device_queue; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE device_queue (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    dev_eui bytea,
    frm_payload bytea,
    f_cnt integer NOT NULL,
    f_port integer NOT NULL,
    confirmed boolean NOT NULL,
    is_pending boolean NOT NULL,
    timeout_after timestamp with time zone,
    emit_at_time_since_gps_epoch bigint,
    dev_addr bytea
);


-- ALTER TABLE device_queue OWNER TO chirpstack_ns;

--
-- Name: device_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: chirpstack_ns
--

-- CREATE SEQUENCE device_queue_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


-- ALTER TABLE device_queue_id_seq OWNER TO chirpstack_ns;

--
-- Name: device_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chirpstack_ns
--

-- ALTER SEQUENCE device_queue_id_seq OWNED BY device_queue.id;


--
-- Name: gateway; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE gateway (
    gateway_id bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    first_seen_at timestamp with time zone,
    last_seen_at timestamp with time zone,
    location point NOT NULL,
    altitude double precision NOT NULL,
    gateway_profile_id uuid,
    routing_profile_id uuid NOT NULL
);


-- ALTER TABLE gateway OWNER TO chirpstack_ns;

--
-- Name: gateway_board; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE gateway_board (
    id smallint NOT NULL,
    gateway_id bytea NOT NULL,
    fpga_id bytea,
    fine_timestamp_key bytea
);


-- ALTER TABLE gateway_board OWNER TO chirpstack_ns;

--
-- Name: gateway_profile; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE gateway_profile (
    gateway_profile_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    channels smallint[] NOT NULL
);


-- ALTER TABLE gateway_profile OWNER TO chirpstack_ns;

--
-- Name: gateway_profile_extra_channel; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE gateway_profile_extra_channel (
    id bigint NOT NULL,
    gateway_profile_id uuid NOT NULL,
    modulation character varying(10) NOT NULL,
    frequency integer NOT NULL,
    bandwidth integer NOT NULL,
    bitrate integer NOT NULL,
    spreading_factors smallint[]
);


-- ALTER TABLE gateway_profile_extra_channel OWNER TO chirpstack_ns;

--
-- Name: gateway_profile_extra_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: chirpstack_ns
--

-- CREATE SEQUENCE gateway_profile_extra_channel_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


-- ALTER TABLE gateway_profile_extra_channel_id_seq OWNER TO chirpstack_ns;

--
-- Name: gateway_profile_extra_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chirpstack_ns
--

-- ALTER SEQUENCE gateway_profile_extra_channel_id_seq OWNED BY gateway_profile_extra_channel.id;


--
-- Name: gateway_stats; Type: TABLE; Schema: public; Owner: chirpstack_ns
--


CREATE TABLE gateway_stats (
    id bigint NOT NULL,
    gateway_id bytea NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    "interval" character varying(10) NOT NULL,
    rx_packets_received integer NOT NULL,
    rx_packets_received_ok integer NOT NULL,
    tx_packets_received integer NOT NULL,
    tx_packets_emitted integer NOT NULL
);


-- ALTER TABLE gateway_stats OWNER TO chirpstack_ns;

--
-- Name: gateway_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: chirpstack_ns
--

-- CREATE SEQUENCE gateway_stats_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


-- ALTER TABLE gateway_stats_id_seq OWNER TO chirpstack_ns;

--
-- Name: gateway_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chirpstack_ns
--

-- ALTER SEQUENCE gateway_stats_id_seq OWNED BY gateway_stats.id;


--
-- Name: gorp_migrations; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

-- CREATE TABLE gorp_migrations (
--     id text NOT NULL,
--     applied_at timestamp with time zone
-- );


-- ALTER TABLE gorp_migrations OWNER TO chirpstack_ns;

--
-- Name: multicast_group; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE multicast_group (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    mc_addr bytea,
    mc_nwk_s_key bytea,
    f_cnt integer NOT NULL,
    group_type character(1) NOT NULL,
    dr integer NOT NULL,
    frequency bigint NOT NULL,
    ping_slot_period integer NOT NULL,
    routing_profile_id uuid NOT NULL,
    service_profile_id uuid NOT NULL
);


-- ALTER TABLE multicast_group OWNER TO chirpstack_ns;

--
-- Name: multicast_queue; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE multicast_queue (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    schedule_at timestamp with time zone NOT NULL,
    emit_at_time_since_gps_epoch bigint,
    multicast_group_id uuid NOT NULL,
    gateway_id bytea NOT NULL,
    f_cnt integer NOT NULL,
    f_port integer NOT NULL,
    frm_payload bytea
);


-- ALTER TABLE multicast_queue OWNER TO chirpstack_ns;

--
-- Name: multicast_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: chirpstack_ns
--

-- CREATE SEQUENCE multicast_queue_id_seq
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


-- ALTER TABLE multicast_queue_id_seq OWNER TO chirpstack_ns;

-- --
-- -- Name: multicast_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER SEQUENCE multicast_queue_id_seq OWNED BY multicast_queue.id;


--
-- Name: routing_profile; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE routing_profile (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    routing_profile_id uuid NOT NULL,
    as_id character varying(255),
    ca_cert text DEFAULT '' NOT NULL,
    tls_cert text DEFAULT '' NOT NULL,
    tls_key text DEFAULT '' NOT NULL
);


-- ALTER TABLE routing_profile OWNER TO chirpstack_ns;

--
-- Name: service_profile; Type: TABLE; Schema: public; Owner: chirpstack_ns
--

CREATE TABLE service_profile (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    service_profile_id uuid NOT NULL,
    ul_rate integer NOT NULL,
    ul_bucket_size integer NOT NULL,
    ul_rate_policy character(4) NOT NULL,
    dl_rate integer NOT NULL,
    dl_bucket_size integer NOT NULL,
    dl_rate_policy character(4) NOT NULL,
    add_gw_metadata boolean NOT NULL,
    dev_status_req_freq integer NOT NULL,
    report_dev_status_battery boolean NOT NULL,
    report_dev_status_margin boolean NOT NULL,
    dr_min integer NOT NULL,
    dr_max integer NOT NULL,
    channel_mask bytea,
    pr_allowed boolean NOT NULL,
    hr_allowed boolean NOT NULL,
    ra_allowed boolean NOT NULL,
    nwk_geo_loc boolean NOT NULL,
    target_per integer NOT NULL,
    min_gw_diversity integer NOT NULL
);


-- ALTER TABLE service_profile OWNER TO chirpstack_ns;

-- --
-- -- Name: device_activation id; Type: DEFAULT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_activation ALTER COLUMN id SET DEFAULT nextval('device_activation_id_seq'::regclass);


-- --
-- -- Name: device_queue id; Type: DEFAULT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_queue ALTER COLUMN id SET DEFAULT nextval('device_queue_id_seq'::regclass);


-- --
-- -- Name: gateway_profile_extra_channel id; Type: DEFAULT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_profile_extra_channel ALTER COLUMN id SET DEFAULT nextval('gateway_profile_extra_channel_id_seq'::regclass);


-- --
-- -- Name: gateway_stats id; Type: DEFAULT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_stats ALTER COLUMN id SET DEFAULT nextval('gateway_stats_id_seq'::regclass);


-- --
-- -- Name: multicast_queue id; Type: DEFAULT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_queue ALTER COLUMN id SET DEFAULT nextval('multicast_queue_id_seq'::regclass);


-- --
-- -- Name: code_migration code_migration_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY code_migration
--     ADD CONSTRAINT code_migration_pkey PRIMARY KEY (id);


-- --
-- -- Name: device_activation device_activation_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_activation
--     ADD CONSTRAINT device_activation_pkey PRIMARY KEY (id);


-- --
-- -- Name: device_multicast_group device_multicast_group_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_multicast_group
--     ADD CONSTRAINT device_multicast_group_pkey PRIMARY KEY (multicast_group_id, dev_eui);


-- --
-- -- Name: device device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device
--     ADD CONSTRAINT device_pkey PRIMARY KEY (dev_eui);


-- --
-- -- Name: device_profile device_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_profile
--     ADD CONSTRAINT device_profile_pkey PRIMARY KEY (device_profile_id);


-- --
-- -- Name: device_queue device_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_queue
--     ADD CONSTRAINT device_queue_pkey PRIMARY KEY (id);


-- --
-- -- Name: gateway_board gateway_board_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_board
--     ADD CONSTRAINT gateway_board_pkey PRIMARY KEY (gateway_id, id);


-- --
-- -- Name: gateway gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway
--     ADD CONSTRAINT gateway_pkey PRIMARY KEY (gateway_id);


-- --
-- -- Name: gateway_profile_extra_channel gateway_profile_extra_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_profile_extra_channel
--     ADD CONSTRAINT gateway_profile_extra_channel_pkey PRIMARY KEY (id);


-- --
-- -- Name: gateway_profile gateway_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_profile
--     ADD CONSTRAINT gateway_profile_pkey PRIMARY KEY (gateway_profile_id);


-- --
-- -- Name: gateway_stats gateway_stats_mac_timestamp_interval_key; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_stats
--     ADD CONSTRAINT gateway_stats_mac_timestamp_interval_key UNIQUE (gateway_id, "timestamp", "interval");


-- --
-- -- Name: gateway_stats gateway_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_stats
--     ADD CONSTRAINT gateway_stats_pkey PRIMARY KEY (id);


-- --
-- -- Name: gorp_migrations gorp_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gorp_migrations
--     ADD CONSTRAINT gorp_migrations_pkey PRIMARY KEY (id);


-- --
-- -- Name: multicast_group multicast_group_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_group
--     ADD CONSTRAINT multicast_group_pkey PRIMARY KEY (id);


-- --
-- -- Name: multicast_queue multicast_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_queue
--     ADD CONSTRAINT multicast_queue_pkey PRIMARY KEY (id);


-- --
-- -- Name: routing_profile routing_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY routing_profile
--     ADD CONSTRAINT routing_profile_pkey PRIMARY KEY (routing_profile_id);


-- --
-- -- Name: service_profile service_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY service_profile
--     ADD CONSTRAINT service_profile_pkey PRIMARY KEY (service_profile_id);


-- --
-- -- Name: idx_device_activation_dev_eui; Type: INDEX; Schema: public; Owner: chirpstack_ns
-- --

CREATE INDEX idx_device_activation_dev_eui ON device_activation(dev_eui);


--
-- Name: idx_device_activation_nonce_lookup; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_activation_nonce_lookup ON device_activation(join_eui, dev_eui, join_req_type, dev_nonce);


--
-- Name: idx_device_device_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_device_profile_id ON device(device_profile_id);


--
-- Name: idx_device_mode; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_mode ON device(mode);


--
-- Name: idx_device_queue_confirmed; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_queue_confirmed ON device_queue(confirmed);


--
-- Name: idx_device_queue_dev_eui; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_queue_dev_eui ON device_queue(dev_eui);


--
-- Name: idx_device_queue_emit_at_time_since_gps_epoch; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_queue_emit_at_time_since_gps_epoch ON device_queue(emit_at_time_since_gps_epoch);


--
-- Name: idx_device_queue_timeout_after; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_queue_timeout_after ON device_queue(timeout_after);


--
-- Name: idx_device_routing_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_routing_profile_id ON device(routing_profile_id);


--
-- Name: idx_device_service_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_device_service_profile_id ON device(service_profile_id);


--
-- Name: idx_gateway_gateway_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_gateway_gateway_profile_id ON gateway(gateway_profile_id);


--
-- Name: idx_gateway_profile_extra_channel_gw_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_gateway_profile_extra_channel_gw_profile_id ON gateway_profile_extra_channel(gateway_profile_id);


--
-- Name: idx_gateway_routing_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_gateway_routing_profile_id ON gateway(routing_profile_id);


--
-- Name: idx_gateway_stats_gateway_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_gateway_stats_gateway_id ON gateway_stats(gateway_id);


--
-- Name: idx_gateway_stats_interval; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_gateway_stats_interval ON gateway_stats("interval");


--
-- Name: idx_gateway_stats_timestamp; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_gateway_stats_timestamp ON gateway_stats("timestamp");


--
-- Name: idx_multicast_group_routing_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_multicast_group_routing_profile_id ON multicast_group(routing_profile_id);


--
-- Name: idx_multicast_group_service_profile_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_multicast_group_service_profile_id ON multicast_group(service_profile_id);


--
-- Name: idx_multicast_queue_emit_at_time_since_gps_epoch; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_multicast_queue_emit_at_time_since_gps_epoch ON multicast_queue(emit_at_time_since_gps_epoch);


--
-- Name: idx_multicast_queue_multicast_group_id; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_multicast_queue_multicast_group_id ON multicast_queue(multicast_group_id);


--
-- Name: idx_multicast_queue_schedule_at; Type: INDEX; Schema: public; Owner: chirpstack_ns
--

CREATE INDEX idx_multicast_queue_schedule_at ON multicast_queue(schedule_at);


--
-- Name: device_activation device_activation_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
--

-- ALTER TABLE ONLY device_activation
--     ADD CONSTRAINT device_activation_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES device(dev_eui) ON DELETE CASCADE;


-- --
-- -- Name: device device_device_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device
--     ADD CONSTRAINT device_device_profile_id_fkey FOREIGN KEY (device_profile_id) REFERENCES device_profile(device_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: device_multicast_group device_multicast_group_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_multicast_group
--     ADD CONSTRAINT device_multicast_group_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES device(dev_eui) ON DELETE CASCADE;


-- --
-- -- Name: device_multicast_group device_multicast_group_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_multicast_group
--     ADD CONSTRAINT device_multicast_group_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES multicast_group(id) ON DELETE CASCADE;


-- --
-- -- Name: device_queue device_queue_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device_queue
--     ADD CONSTRAINT device_queue_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES device(dev_eui) ON DELETE CASCADE;


-- --
-- -- Name: device device_routing_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device
--     ADD CONSTRAINT device_routing_profile_id_fkey FOREIGN KEY (routing_profile_id) REFERENCES routing_profile(routing_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: device device_service_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY device
--     ADD CONSTRAINT device_service_profile_id_fkey FOREIGN KEY (service_profile_id) REFERENCES service_profile(service_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: gateway_board gateway_board_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_board
--     ADD CONSTRAINT gateway_board_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES gateway(gateway_id) ON DELETE CASCADE;


-- --
-- -- Name: gateway gateway_gateway_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway
--     ADD CONSTRAINT gateway_gateway_profile_id_fkey FOREIGN KEY (gateway_profile_id) REFERENCES gateway_profile(gateway_profile_id);


-- --
-- -- Name: gateway_profile_extra_channel gateway_profile_extra_channel_gateway_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_profile_extra_channel
--     ADD CONSTRAINT gateway_profile_extra_channel_gateway_profile_id_fkey FOREIGN KEY (gateway_profile_id) REFERENCES gateway_profile(gateway_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: gateway gateway_routing_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway
--     ADD CONSTRAINT gateway_routing_profile_id_fkey FOREIGN KEY (routing_profile_id) REFERENCES routing_profile(routing_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: gateway_stats gateway_stats_mac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY gateway_stats
--     ADD CONSTRAINT gateway_stats_mac_fkey FOREIGN KEY (gateway_id) REFERENCES gateway(gateway_id) ON DELETE CASCADE;


-- --
-- -- Name: multicast_group multicast_group_routing_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_group
--     ADD CONSTRAINT multicast_group_routing_profile_id_fkey FOREIGN KEY (routing_profile_id) REFERENCES routing_profile(routing_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: multicast_group multicast_group_service_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_group
--     ADD CONSTRAINT multicast_group_service_profile_id_fkey FOREIGN KEY (service_profile_id) REFERENCES service_profile(service_profile_id) ON DELETE CASCADE;


-- --
-- -- Name: multicast_queue multicast_queue_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_queue
--     ADD CONSTRAINT multicast_queue_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES gateway(gateway_id) ON DELETE CASCADE;


-- --
-- -- Name: multicast_queue multicast_queue_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack_ns
-- --

-- ALTER TABLE ONLY multicast_queue
--     ADD CONSTRAINT multicast_queue_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES multicast_group(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

-- +migrate StatementEnd