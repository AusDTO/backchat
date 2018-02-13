SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE forms (
    id character varying NOT NULL,
    name character varying,
    website character varying,
    redirect_url character varying,
    allow_file boolean,
    input_fields jsonb,
    owner_id integer
);


--
-- Name: forms_outputs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE forms_outputs (
    output_id character varying,
    form_id character varying
);


--
-- Name: global_configs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE global_configs (
    id integer NOT NULL,
    app_name character varying,
    app_domain character varying,
    facebook_app_id character varying,
    twitter_app_id character varying,
    linkedin_app_id character varying,
    use_slack boolean DEFAULT false,
    slack_team character varying,
    slack_icon_url character varying,
    slack_user character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: global_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE global_configs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: global_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE global_configs_id_seq OWNED BY global_configs.id;


--
-- Name: identities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE identities (
    id integer NOT NULL,
    user_id integer,
    provider character varying,
    uid character varying,
    id_token character varying,
    access_token character varying,
    refresh_token character varying,
    scope character varying,
    expires_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE identities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE identities_id_seq OWNED BY identities.id;


--
-- Name: output_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE output_jobs (
    id character varying NOT NULL,
    output_id character varying,
    submission_id character varying,
    success boolean,
    result jsonb,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: outputs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE outputs (
    id character varying NOT NULL,
    name character varying,
    configuration jsonb,
    type character varying,
    owner_id integer
);


--
-- Name: que_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE que_jobs (
    priority smallint DEFAULT 100 NOT NULL,
    run_at timestamp with time zone DEFAULT now() NOT NULL,
    job_id bigint NOT NULL,
    job_class text NOT NULL,
    args json DEFAULT '[]'::json NOT NULL,
    error_count integer DEFAULT 0 NOT NULL,
    last_error text,
    queue text DEFAULT ''::text NOT NULL
);


--
-- Name: TABLE que_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE que_jobs IS '3';


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE que_jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE que_jobs_job_id_seq OWNED BY que_jobs.job_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE submissions (
    id character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    path character varying,
    satisfaction numeric(3,0),
    file_id character varying,
    file_filename character varying,
    file_size integer,
    file_content_type character varying,
    content jsonb,
    form_id character varying
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    name character varying,
    admin boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    approved boolean DEFAULT false NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: global_configs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY global_configs ALTER COLUMN id SET DEFAULT nextval('global_configs_id_seq'::regclass);


--
-- Name: identities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY identities ALTER COLUMN id SET DEFAULT nextval('identities_id_seq'::regclass);


--
-- Name: que_jobs job_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs ALTER COLUMN job_id SET DEFAULT nextval('que_jobs_job_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: global_configs global_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY global_configs
    ADD CONSTRAINT global_configs_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: output_jobs output_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY output_jobs
    ADD CONSTRAINT output_jobs_pkey PRIMARY KEY (id);


--
-- Name: outputs outputs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY outputs
    ADD CONSTRAINT outputs_pkey PRIMARY KEY (id);


--
-- Name: que_jobs que_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs
    ADD CONSTRAINT que_jobs_pkey PRIMARY KEY (queue, priority, run_at, job_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_forms_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_forms_on_owner_id ON forms USING btree (owner_id);


--
-- Name: index_forms_outputs_on_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_forms_outputs_on_form_id ON forms_outputs USING btree (form_id);


--
-- Name: index_forms_outputs_on_output_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_forms_outputs_on_output_id ON forms_outputs USING btree (output_id);


--
-- Name: index_identities_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_identities_on_user_id ON identities USING btree (user_id);


--
-- Name: index_output_jobs_on_output_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_output_jobs_on_output_id ON output_jobs USING btree (output_id);


--
-- Name: index_output_jobs_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_output_jobs_on_submission_id ON output_jobs USING btree (submission_id);


--
-- Name: index_outputs_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_outputs_on_owner_id ON outputs USING btree (owner_id);


--
-- Name: index_submissions_on_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_form_id ON submissions USING btree (form_id);


--
-- Name: index_users_on_approved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_approved ON users USING btree (approved);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20150126180608'),
('20150126180704'),
('20150129184051'),
('20160202015000'),
('20160202015332'),
('20160202015425'),
('20160202034021'),
('20160419112224');


