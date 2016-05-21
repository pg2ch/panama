--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: panama_addresses; Type: TABLE; Schema: public; Owner: _postgres
--

CREATE TABLE panama_addresses (
    node_id integer NOT NULL,
    address character varying(800) NOT NULL,
    icij_id character varying(48),
    valid_until character varying(48) NOT NULL,
    country_codes character varying(5),
    countries character varying(48),
    sourceid character varying(20) NOT NULL,
    google_latlon point,
    google_cache text,
    google_is_skip boolean DEFAULT false NOT NULL,
    address_fix text NOT NULL
);


ALTER TABLE panama_addresses OWNER TO _postgres;

--
-- Name: panama_all_edges; Type: TABLE; Schema: public; Owner: _postgres
--

CREATE TABLE panama_all_edges (
    node_1 integer NOT NULL,
    rel_type character varying(20),
    node_2 integer
);


ALTER TABLE panama_all_edges OWNER TO _postgres;

--
-- Name: panama_entities; Type: TABLE; Schema: public; Owner: _postgres
--

CREATE TABLE panama_entities (
    name character varying(200),
    original_name character varying(200),
    former_name character varying(200),
    jurisdiction character varying(10) NOT NULL,
    jurisdiction_description character varying(48) NOT NULL,
    company_type character varying(48),
    address character varying(300),
    internal_id integer,
    incorporation_date character varying(20),
    inactivation_date character varying(20),
    struck_off_date character varying(20),
    dorm_date character varying(20),
    status character varying(48),
    service_provider character varying(48) NOT NULL,
    ibcruc character varying(20),
    country_codes character varying(20),
    countries character varying(80),
    note character varying(256),
    valid_until character varying(52) NOT NULL,
    node_id integer NOT NULL,
    sourceid character varying(20) NOT NULL
);


ALTER TABLE panama_entities OWNER TO _postgres;

--
-- Name: panama_intermediaries; Type: TABLE; Schema: public; Owner: _postgres
--

CREATE TABLE panama_intermediaries (
    name character varying(100),
    internal_id character varying(20),
    address character varying(256),
    valid_until character varying(48) NOT NULL,
    country_codes character varying(20),
    countries character varying(80),
    status character varying(48),
    node_id integer NOT NULL,
    sourceid character varying(20) NOT NULL
);


ALTER TABLE panama_intermediaries OWNER TO _postgres;

--
-- Name: panama_officers; Type: TABLE; Schema: public; Owner: _postgres
--

CREATE TABLE panama_officers (
    name character varying(256),
    icij_id character varying(48),
    valid_until character varying(48) NOT NULL,
    country_codes character varying(200),
    countries character varying(400),
    node_id integer NOT NULL,
    sourceid character varying(20) NOT NULL
);


ALTER TABLE panama_officers OWNER TO _postgres;

--
-- Name: panama_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: _postgres
--

ALTER TABLE ONLY panama_addresses
    ADD CONSTRAINT panama_addresses_pkey PRIMARY KEY (node_id);


--
-- Name: panama_addresses_node_id_idx; Type: INDEX; Schema: public; Owner: _postgres
--

CREATE INDEX panama_addresses_node_id_idx ON panama_addresses USING btree (node_id);
CREATE INDEX panama_addresses_google_latlon_idx ON panama_addresses USING gist (google_latlon);

--
-- Name: panama_all_edges_node_1_idx; Type: INDEX; Schema: public; Owner: _postgres
--

CREATE INDEX panama_all_edges_node_1_idx ON panama_all_edges USING btree (node_1);


--
-- Name: panama_all_edges_node_2_idx; Type: INDEX; Schema: public; Owner: _postgres
--

CREATE INDEX panama_all_edges_node_2_idx ON panama_all_edges USING btree (node_2);


--
-- Name: panama_entities_node_id_idx; Type: INDEX; Schema: public; Owner: _postgres
--

CREATE INDEX panama_entities_node_id_idx ON panama_entities USING btree (node_id);


--
-- Name: panama_intermediaries_node_id_idx; Type: INDEX; Schema: public; Owner: _postgres
--

CREATE INDEX panama_intermediaries_node_id_idx ON panama_intermediaries USING btree (node_id);


--
-- Name: panama_officers_node_id_idx; Type: INDEX; Schema: public; Owner: _postgres
--

CREATE INDEX panama_officers_node_id_idx ON panama_officers USING btree (node_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: _postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM _postgres;
GRANT ALL ON SCHEMA public TO _postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

